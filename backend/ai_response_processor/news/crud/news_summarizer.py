import os

from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate
import logging

from news.contentqueue.rabbitmq_producer import send_message
from news.schema.message_item import MessageItem

logger = logging.getLogger(__name__)
ChatOpenAI.openai_api_key = os.environ['OPENAI_API_KEY']


def summarize_news(news_id: int, content: str):
    logger.info("summarize_news start : (id)", news_id)
    chat = ChatOpenAI(temperature=0.3)

    template = ChatPromptTemplate.from_messages(
        [
            ("system", "You're a news summarizer. Also, the answer must be no more than 500 characters in Korean."),
            ("user", "{raw_news_content}"),
        ]
    )

    prompt = template.format_messages(
        raw_news_content={content}
    )

    result = chat.predict_messages(prompt)
    message_item = MessageItem(
        id=news_id,
        content=result.content
    )
    send_message(message_item)
