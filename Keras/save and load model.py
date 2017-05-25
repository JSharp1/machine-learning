# modified from: http://machinelearningmastery.com/save-load-keras-deep-learning-models/ 
# dataset: http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data
# MLP for Pima Indians Dataset serialize to JSON and HDF5
# import dataset and save model weights for use later

from keras.models import Sequential
from keras.layers import Dense
from keras.models import model_from_json
import numpy
import os

# fix random seed for reproducibility
seed = 7
numpy.random.seed(seed)
iterations = 0.0
acc = 0

# file paths csv = data set, json and h5 are stored weights and model
_csv="datasets/pima-indians-diabetes.csv"
_json="saved_models/pima-indians-diabetes.json"
_h5="saved_models/pima-indians-diabetes.h5"

# load pima indians dataset
dataset = numpy.loadtxt(_csv, delimiter=",")
# split into input (X) and output (Y) variables
X = dataset[:,0:8]
Y = dataset[:,8]
# create model
model = Sequential()
model.add(Dense(12, input_dim=8, init='uniform', activation='relu'))
model.add(Dense(8, init='uniform', activation='relu'))
model.add(Dense(1, init='uniform', activation='sigmoid'))
# Compile model
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
# userinput
targetAcc = input("whats your target accuracy?")

# create a file if not there
if not os.path.isfile(_json):
	print("creating file")
	# Fit the model
	model.fit(X, Y, nb_epoch=150, batch_size=10, verbose=0)
	# evaluate the model
	scores = model.evaluate(X, Y, verbose=0)
	print("%s: %.2f%%" % (model.metrics_names[1], scores[1]*100))

	# serialize model to JSON
	model_json = model.to_json()
	with open(_json, "w") as json_file:
	    json_file.write(model_json)
	# serialize weights to HDF5
	model.save_weights(_h5)
	print("Saved to disk")

# otherwise load data and loop until targetAcc is met 
while(acc < targetAcc): 
	# load json and create model
	json_file = open(_json, 'r')
	loaded_model_json = json_file.read()
	json_file.close()
	loaded_model = model_from_json(loaded_model_json)

	# load weights into new model
	print("Loading model from disk")
	loaded_model.load_weights(_h5)
	# evaluate loaded model on test data
	loaded_model.compile(loss='binary_crossentropy', optimizer='rmsprop', metrics=['accuracy'])
	# Fit the model
	print("Fitting model...")
	model.fit(X, Y, nb_epoch=150, batch_size=10, verbose=0)
	score = loaded_model.evaluate(X, Y, verbose=0)
	acc = score[1]*100
	print "%s: %.2f%%" % (loaded_model.metrics_names[1], acc)

	# serialize model to JSON
	model_json = model.to_json()
	with open(_json, "w") as json_file:
	    json_file.write(model_json)
	# serialize weights to HDF5
	model.save_weights(_h5)

	print("Saved model to disk")
	iterations = iterations +1
	print("number of iterations: %d \n" % iterations)

print "finished"	
