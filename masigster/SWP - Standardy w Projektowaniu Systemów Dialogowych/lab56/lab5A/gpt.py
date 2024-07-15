# model
import tensorflow as tf

# nlp processing
import unicodedata
import re
import numpy as np

import warnings
warnings.filterwarnings("ignore")

# SEGMENTACJA

# reading data
data = open('dialogs.txt').read()

# paired list of questions and corresponding answers
QA_list = [QA.split('\t') for QA in data.split('\n') if len(QA.split('\t')) == 2]

# NORMALIZACJA

def remove_diacritic(input_str: str) -> str:
    nfkd_form = unicodedata.normalize('NFKD', input_str)
    only_ascii = nfkd_form.encode('ASCII', 'ignore')
    return only_ascii.decode('utf-8')

def preprocessing(text: str):
    text = remove_diacritic(text.lower().strip())
    text = re.sub(r'[" "]+', " ", text)
    text = re.sub(r"[^a-zA-Z?.!,¿]+", " ", text)
    text = text.strip()
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
    lang_tokenizer = tf.keras.preprocessing.text.Tokenizer(filters='')
    lang_tokenizer.fit_on_texts(lang)
    return lang_tokenizer

# TWORZENIE ZESTAWU DANYCH

def vectorization(lang_tokenizer, lang):
    tensor = lang_tokenizer.texts_to_sequences(lang)
    tensor = tf.keras.preprocessing.sequence.pad_sequences(tensor, padding='post')
    return tensor

def load_dataset(questions, answers):
    Q_tokenizer = tokenize(questions)
    A_tokenizer = tokenize(answers)
    Q_tensor = vectorization(Q_tokenizer, questions)
    A_tensor = vectorization(A_tokenizer, answers)
    return Q_tensor, Q_tokenizer, A_tensor, A_tokenizer

# Load dataset
X_train, X_tokenizer, y_train, y_tokenizer = load_dataset(preprocessed_questions, preprocessed_answers)

BUFFER_SIZE = len(X_train)
BATCH_SIZE = 64
steps_per_epoch = BUFFER_SIZE // BATCH_SIZE
embedding_dim = 256
units = 1024
vocab_inp_size = len(X_tokenizer.word_index) + 1
vocab_out_size = len(y_tokenizer.word_index) + 1

dataset = tf.data.Dataset.from_tensor_slices((X_train, y_train)).shuffle(BUFFER_SIZE)
dataset = dataset.batch(BATCH_SIZE, drop_remainder=True)

# Ensure dataset is not empty
if BUFFER_SIZE > 0:
    example_input_batch, example_target_batch = next(iter(dataset))
    print(example_input_batch.shape, example_target_batch.shape)
else:
    print("Dataset is empty")
