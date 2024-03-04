## Local and SaturnCloud Running

# Python

This needs to be set at Python 3.9.18, because this is the default SaturnCloud setup.

## Setup

There is a bash file `setup.sh` this will:

1) Check for `.venv` and setup if not installed
2) Uninstall previous Keras/KerasCV as there is a dependency order issue to get to Keras 3.x
3) Install packages both from requirements and upgrade of TensorFlow/Keras/KerasCV
4) Info outputs

## SaturnCloud Setup

Follow this page for adding a script to the server to get opencv working

https://saturncloud.io/docs/troubleshooting/package-support/opencv/

## Setting up the RoboFlow data

You will need an API Key from Roboflow. In SaturnCloud add the API key as an environment variable `ROBOFLOW`. Locally export ROBOFLOW={YOUR_KEY}

Run the roboflow notebook the data should appear in `dataset/voc_v1/data`. With folder for annotations and images. This currenly merges the dataset to one folder, until the code can use the predefined test/train/valid structure.

## The SolarFlare Notebook

sf-keras.ipynb once opened should run. 