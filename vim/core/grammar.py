from enum import Enum


class TargetType(Enum):
    WORD = 1
    LINE = 2


class ActionType(Enum):
    COPY = 1
    BRING = 2
