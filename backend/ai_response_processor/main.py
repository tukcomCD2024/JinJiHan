from fastapi import FastAPI
import os
from dotenv import load_dotenv

from news.contentqueue import rabbitmq_consumer

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
load_dotenv(os.path.join(BASE_DIR, "scoop-ai-env", ".env"))

app = FastAPI()
rabbitmq_consumer = rabbitmq_consumer
