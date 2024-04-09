import os
import time
from dotenv import load_dotenv
import json
from pika import BlockingConnection, ConnectionParameters, PlainCredentials, BasicProperties, exceptions

from news.schema.message_item import MessageItem

load_dotenv()

CONFIG = {
    'username': os.getenv('RABBITMQ_USERNAME'),
    'password': os.getenv('RABBITMQ_PASSWORD'),
    'host': os.getenv('RABBITMQ_HOST'),
    'port': int(os.getenv('RABBITMQ_PORT')),
    'queue_name': os.getenv('STORE_QUEUE'),
    'exchange_name': os.getenv('STORE_EXCHANGE'),
    'routing_key': os.getenv('STORE_KEY'),
}

CONTENT_TYPE = 'application/json'

def get_connection_params():
    credentials = PlainCredentials(username=CONFIG['username'], password=CONFIG['password'])
    return ConnectionParameters(host=CONFIG['host'],
                                credentials=credentials,
                                heartbeat=600,
                                blocked_connection_timeout=300)


def send_message(message: MessageItem):
    try:
        connection = BlockingConnection(get_connection_params())
        channel = connection.channel()
        channel.queue_declare(queue=CONFIG['queue_name'], durable=True)

        props = BasicProperties(content_type=CONTENT_TYPE, delivery_mode=1)
        serialized_message = json.dumps(message.__dict__)

        channel.basic_publish(exchange=CONFIG['exchange_name'],
                              routing_key=CONFIG['routing_key'],
                              body=serialized_message,
                              properties=props)
        connection.close()
    except (exceptions.AMQPConnectionError, exceptions.StreamLostError) as e:
        print("Connection failed, retrying in 5 seconds... Error: {}".format(e))
        time.sleep(5)
        send_message(message)