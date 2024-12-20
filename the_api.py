from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from logic import respond_with_context

app = FastAPI(title="TutorAI Backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],  
)

class UserMessage(BaseModel):
    message: str

class TutorResponse(BaseModel):
    Grade: int
    Subject: str
    Chapter: int
    Answer: str

@app.post("/chat", response_model=TutorResponse)
async def chat_endpoint(user_message: UserMessage):
    try:
        response = respond_with_context(user_message.message)
        return response
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")