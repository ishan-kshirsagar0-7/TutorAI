import os
import google.generativeai as genai
from dotenv import load_dotenv
from langchain.chains.question_answering import load_qa_chain
from corpus import PDFStorageSystem
import typing_extensions as typing
from prompts import indexing_prompt, content_prompt, chapter_prompt, rephraser
from langchain_google_genai import GoogleGenerativeAIEmbeddings, ChatGoogleGenerativeAI
from ast import literal_eval
from langchain.prompts import PromptTemplate
from langchain_community.vectorstores import FAISS
load_dotenv()

GEMINI_API_KEY = os.getenv("GOOGLE_API_KEY")
genai.configure(api_key=GEMINI_API_KEY)
index_model = genai.GenerativeModel("gemini-2.0-flash-exp")
response_model = genai.GenerativeModel("gemini-2.0-flash-exp")
chapter_model = genai.GenerativeModel("gemini-2.0-flash-exp")
storage_sys = PDFStorageSystem()

class IndexSchema(typing.TypedDict):
    idx_string: str
    justification: str

class ResponseSchema(typing.TypedDict):
    rephrased: str

class ChapterSchema(typing.TypedDict):
    chapter: int

def get_index(user_query):
    index_pdf = genai.upload_file("index.pdf")
    config = genai.GenerationConfig(response_mime_type="application/json", response_schema=IndexSchema)
    idx = index_model.generate_content([f"{indexing_prompt}\n{user_query}", index_pdf], generation_config=config).text
    # print(idx)
    to_list = literal_eval(idx)
    return to_list

def retrieve_content(relevant_index):
    grade = int(relevant_index["idx_string"].split("_")[1])
    subject = relevant_index["idx_string"].split("_")[0]
    # print(grade, subject)
    path = storage_sys.get_pdf_path(grade, subject)
    return path

def get_conversational_chain():
    retrieval_model = ChatGoogleGenerativeAI(model="gemini-2.0-flash-exp", google_api_key=GEMINI_API_KEY)
    prompt = PromptTemplate(template=content_prompt, input_variables=["context", "question"])
    chain = load_qa_chain(retrieval_model, chain_type="stuff", prompt=prompt)
    return chain

def respond_with_context(user_q):
    retrieved_idx = get_index(user_q)
    level = int(retrieved_idx["idx_string"].split("_")[1])
    source = f"vectorstore/{retrieved_idx['idx_string']}"
    # source = retrieve_content(retrieved_idx).replace("\\", "\\\\")
    # print(reference)
    embeddings = GoogleGenerativeAIEmbeddings(model="models/embedding-001", google_api_key=GEMINI_API_KEY)
    new_db = FAISS.load_local(source, embeddings, allow_dangerous_deserialization=True)
    docs = new_db.similarity_search(user_q)
    chain = get_conversational_chain()
    rephrase_config = genai.GenerationConfig(response_mime_type="application/json", response_schema=ResponseSchema)
    chapter_config = genai.GenerationConfig(response_mime_type="application/json", response_schema=ChapterSchema)
    tool_config = {"google_search_retrieval": {"dynamic_retrieval_config": {"mode": "dynamic", "dynamic_threshold":0.3}}}
    response = chain({"input_documents":docs, "question":user_q}, return_only_outputs=True)
    # response = response_model.generate_content([f"{content_prompt}\n{user_q}\nThe user's grade is: {level}", reference], generation_config=new_config).text
    # response = response_model.generate_content(contents=f"{content_prompt}\n{user_q}\nThe user's grade is: {level}", tools=tool_config, generation_config=new_config).text
    # print(response)
    # print(type(response))
    rephrased_response = response_model.generate_content(f"{rephraser}\n{response["output_text"]}\nHere's the user's grade:\n{level}", generation_config=rephrase_config).text
    # print(rephrased_response)
    typecasted_response = literal_eval(rephrased_response)
    chapter = chapter_model.generate_content(f"{chapter_prompt}\n{user_q}\nHere's some context: {response['output_text']}", generation_config=chapter_config).text
    subject_keys = {"eng": "English", "math": "Mathematics", "sci": "Science"}
    subject_name = subject_keys[retrieved_idx["idx_string"].split("_")[0]]
    typecasted_chapter = literal_eval(chapter)
    final_dict = {
        "Grade": level,
        "Subject": subject_name,
        "Chapter": typecasted_chapter["chapter"],
        "Answer": typecasted_response["rephrased"]
    }
    print(final_dict)
    return final_dict