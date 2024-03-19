from fastapi import FastAPI
import os
from dotenv import load_dotenv
import logging

from news.contentqueue import rabbitmq_consumer

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
load_dotenv(os.path.join(BASE_DIR, ".env"))

app = FastAPI()
rabbitmq_consumer = rabbitmq_consumer

logger = logging.getLogger(__name__)
