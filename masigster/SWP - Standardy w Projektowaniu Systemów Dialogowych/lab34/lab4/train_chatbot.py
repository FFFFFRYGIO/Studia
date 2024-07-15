import json
import pickle
import random

import nltk
import numpy as np
from keras.layers import Dense, Dropout
from keras.models import Sequential
from nltk.stem import WordNetLemmatizer
# from keras.optimizers import SGD
from tensorflow.keras.optimizers import SGD

# for first time used
# nltk.download('punkt')  # fix problem about import SGD
# nltk.download('wordnet')  # fix wordnet not found
# nltk.download('omw-1.4')  # fix omw-1.4 not found

words = []
classes = []
documents = []
ignore_words = ['?', '!']
data_file = open('intents.json').read()
intents = json.loads(data_file)

for intent in intents['intents']:
    for pattern in intent['patterns']:

        # tokenize each word
        w = nltk.word_tokenize(pattern)
        words.extend(w)
        # add documents in the corpus
        documents.append((w, intent['tag']))

        # add to our classes list
        if intent['tag'] not in classes:
            classes.append(intent['tag'])

lemmatizer = WordNetLemmatizer()
# lemmantize and lower each word and remove duplicates
words = [lemmatizer.lemmatize(w.lower()) for w in words if w not in ignore_words]
words = sorted(list(set(words)))
# sort classes
classes = sorted(list(set(classes)))
# documents = combination between patterns and intents
print(len(documents), "documents")
# classes = intents
print(len(classes), "classes", classes)
# words = all words, vocabulary
print(len(words), "unique lemmatized words", words)

pickle.dump(words, open('words.pkl', 'wb'))
pickle.dump(classes, open('classes.pkl', 'wb'))

# my code
training = []

# Create training set by converting sentences to a bag-of-words
for doc in documents:
    pattern_words = doc[0]
    # Lemmatize each word in the sentence
    pattern_words = [lemmatizer.lemmatize(word.lower()) for word in pattern_words]
    # Create a bag of words
    bag = []
    for w in words:
        bag.append(1) if w in pattern_words else bag.append(0)

    # Output is a 'one hot' encoded list of results
    output_row = [0] * len(classes)
    output_row[classes.index(doc[1])] = 1

    # Append the bag of words and output row to training data
    training.append([bag, output_row])

# Shuffle the training data and convert it into a NumPy array for training
random.shuffle(training)
training = np.array(training, dtype=object)

# Create train and test lists
train_patterns = np.array([t[0] for t in training])
train_intents = np.array([t[1] for t in training])

if train_patterns.shape[0] == 0:
    raise ValueError("Empty training data")

print("Training data shape: %s\t train_x shape: %s\t train_y shape: %s" % (
    training.shape, train_patterns.shape, train_intents.shape))

# Create model - 3 layers. First layer 128 neurons, second layer 64 neurons and 3rd output layer contains  number
# equal to number of intents to predict output intent with softmax
model = Sequential()
model.add(Dense(128, input_shape=(len(train_patterns[0]),), activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(len(train_intents[0]), activation='softmax'))

# Compile model. Stochastic gradient descent with Nesterov accelerated gradient gives good results for this model
sgd = SGD(learning_rate=0.01, decay=1e-6, momentum=0.9, nesterov=True)
model.compile(loss='categorical_crossentropy', optimizer=sgd, metrics=['accuracy'])

# fitting and saving the model
hist = model.fit(np.array(train_patterns), np.array(train_intents), epochs=200, batch_size=5, verbose=1)
model.save('chatbot_model.h5', hist)

print("model created")
