from fastapi import FastAPI
from pydantic import BaseModel
from openai import OpenAI

app = FastAPI()
client = OpenAI()

class ChatRequest(BaseModel):
  message: str

@app.post("/chat")
def chat(request: ChatRequest):

  response = client.responses.create(
    model="gpt-5-mini",

    instructions="""
    あなたは｢memory｣というアプリの対話サポートAI｢メモリス｣です。
    ユーザーが大切な人との思い出や、自分の気持ちを
    ゆっくり言葉にできるようサポートしてください。

    ユーザーの話を決めつけず、必要に応じて質問をしながら、
    気持ちや思い出を整理する手助けをしてください。

    一度にたくさんの質問をせず、質問は原則として一つずつにしてください。
    回答は長くなりすぎないよう、簡潔で自然な会話を心がけてください。
    無理に前向きな気持ちへ誘導しないでください。


    医師やカウンセラーとして診断や治療を行うのではなく、
    対話を通じてユーザーが自分の気持ちを言葉にすることを
    支援してください。
  """,

    input=request.message
  )
  return {
    "reply": response.output_text
  }