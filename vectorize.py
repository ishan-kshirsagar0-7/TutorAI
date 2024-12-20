from PyPDF2 import PdfReader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_google_genai import GoogleGenerativeAIEmbeddings, ChatGoogleGenerativeAI
from langchain_community.vectorstores import FAISS
# import pdfplumber
import os
from dotenv import load_dotenv
import slate3k as slate
load_dotenv()

GEMINI_API_KEY = os.getenv("GOOGLE_API_KEY")

# def get_text_from_pdf(docs):
#     text = ""
#     pdf_reader = PdfReader(docs, strict=False)
#     for page in pdf_reader.pages:
#         text += page.extract_text()
#     return text

def get_text_from_pdf(docs):
    text = ""
    with open(docs, 'rb') as f:
        extracted = slate.PDF(f)
    text = ""
    for i in range(len(extracted)):
        text += extracted[i]
    return text

# def get_text_from_pdf(docs):
#     text = ""
#     with pdfplumber.open(docs) as pdf:
#         for page in pdf.pages:
#             text += page.extract_text()
#     return text


def get_chunks_from_text(text):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=10000, chunk_overlap=1000)
    chunks = text_splitter.split_text(text)
    return chunks


def get_vector_store(chunks, where_to):
    embeddings = GoogleGenerativeAIEmbeddings(model="models/embedding-001", google_api_key=GEMINI_API_KEY)
    vector_store = FAISS.from_texts(chunks, embedding=embeddings)
    vector_store.save_local(where_to)


def vectorize(path, where_to):
    raw_text = get_text_from_pdf(path)
    text_chunks = get_chunks_from_text(raw_text)
    get_vector_store(text_chunks, where_to)
    print(f"{path}'s Vector Store Created!")

# vectorize("database/grade_5/eng_5.pdf", "vectorstore/eng_5")
# vectorize("database/grade_5/math_5.pdf", "vectorstore/math_5")
# vectorize("database/grade_10/sci_10.pdf", "vectorstore/sci_10")