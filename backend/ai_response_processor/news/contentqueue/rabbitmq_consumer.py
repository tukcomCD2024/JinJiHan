import os
from dotenv import load_dotenv
import json
import logging
from pika import BlockingConnection, ConnectionParameters, PlainCredentials

from news.crud.news_summarizer import summarize_news

load_dotenv()
logger = logging.getLogger(__name__)

# RabbitMQ 설정
credentials = PlainCredentials(username=os.getenv('RABBITMQ_USERNAME'), password=os.getenv('RABBITMQ_PASSWORD'))
connection = BlockingConnection(ConnectionParameters(host=os.getenv('RABBITMQ_HOST'),
                                                     port=int(os.getenv('RABBITMQ_PORT')),
                                                     credentials=credentials))
channel = connection.channel()
channel.exchange_declare(exchange=os.getenv('SUMMARY_EXCHANGE'),
                         exchange_type='direct',
                         durable=True)
channel.queue_declare(queue=os.getenv('SUMMARY_QUEUE'), durable=True)
channel.queue_bind(exchange=os.getenv('SUMMARY_EXCHANGE'),
                   queue=os.getenv('SUMMARY_QUEUE'), routing_key=os.getenv('SUMMARY_KEY'))


def callback(ch, method, properties, body):
    logger.info(" [x] Queue Received ")
    received_data = body.decode()

    try:
        received_data_json = json.loads(received_data)
        if 'content' in received_data_json:
            summarize_news(news_id=received_data_json['id'], content=received_data_json['content'])
        else:
            logger.info("Error: 'content' key is missing in the received data.")
    except json.JSONDecodeError:
        logger.info("Error decoding JSON from the received data.")


# 메시지 소비 시작
channel.basic_consume(queue=os.getenv('SUMMARY_QUEUE'), on_message_callback=callback, auto_ack=True)
channel.start_consuming()
