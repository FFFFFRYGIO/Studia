# model
import tensorflow as tf

# nlp processing
import unicodedata
import re
import numpy as np


import warnings

from tensorflow.python.autograph import lang

warnings.filterwarnings("ignore")


# SEGMENTACJA


# reading data
data = open('dialogs.txt').read()

# paired list of question and corresponding answer
QA_list = [QA.split('\t') for QA in data.split('\n') if len(QA.split('\t')) == 2]
# print(QA_list[:5])


# NORMALIZACJA


def remove_diacritic(input_str: str) -> str:
    """
    Remove diacritics from a given string.
    """
    nfkd_form = unicodedata.normalize('NFKD', input_str)
    only_ascii = nfkd_form.encode('ASCII', 'ignore')
    return only_ascii.decode('utf-8')


def preprocessing(text: str):
    """ clear and prepare structure for text data"""

    # Case folding and removing extra whitespaces
    text = remove_diacritic(text.lower().strip())

    # Ensuring punctuation marks to be treated as tokens
    text = re.sub(r'[" "]+', " ", text)

    # Removing non-alphabetic characters
    text = re.sub(r"[^a-zA-Z?.!,¿]+", " ", text)

    text = text.strip()

    # Indicating the start and end of each sentence
    text = '<start> ' + text + ' <end>'

    return text


questions = [QA[0] for QA in QA_list]
answers = [QA[1] for QA in QA_list]

preprocessed_questions = [preprocessing(sen) for sen in questions]
preprocessed_answers = [preprocessing(sen) for sen in answers]

print(preprocessed_questions[0])
print(preprocessed_answers[0])


# TOKENIZACJA

def tokenize(lang):
    """ tokens most of the time are words that are basic elements of text for chatbot to analyze """

    lang_tokenizer = tf.keras.preprocessing.text.Tokenizer(filters='')

    # build vocabulary on unique words
    lang_tokenizer.fit_on_texts(lang)

    return lang_tokenizer


# TWORZENIE ZESTAWU DANYCH


def vectorization(lang_tokenizer, lang):
    """ prepare dataset of Q and A for chatbot to learn """

    # work embedding for training the neural network
    tensor = lang_tokenizer.texts_to_sequences(lang)

    tensor = tf.keras.preprocessing.sequence.pad_sequences(tensor, padding='post')

    return tensor


def load_dataset(data, size=None):
    """ load dataset of Q and A for chatbot to learn """

    if size == None:
        y, X = data[:size]
    else:
        y, X = data

    X_tokenizer = tokenize(X)
    y_tokenizer = tokenize(y)

    X_tensor = vectorization(X_tokenizer, X)
    y_tensor = vectorization(y_tokenizer, y)

    return X_tensor, X_tokenizer, y_tensor, y_tokenizer


X_train, X_tokenizer, y_train, y_tokenizer = load_dataset((preprocessed_questions, preprocessed_answers))

BUFFER_SIZE = len(X_train)
BATCH_SIZE = 64
steps_per_epoch = BUFFER_SIZE // BATCH_SIZE
embedding_dim = 256
units = 1024
vocab_inp_size = len(X_tokenizer.word_index) + 1
vocab_out_size = len(y_tokenizer.word_index) + 1

dataset = tf.data.Dataset.from_tensor_slices((X_train, y_train)).shuffle(BUFFER_SIZE)
dataset = dataset.batch(BATCH_SIZE, drop_remainder=True)

try:
    example_input_batch, example_target_batch = next(iter(dataset))
    print(example_input_batch.shape, example_target_batch.shape)
except StopIteration:
    print("The dataset is empty or exhausted.")
