from dataclasses import dataclass


@dataclass
class MessageItem:
    id: int
    content: str
