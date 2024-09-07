#!/bin/bash

# Create the fraud-detection directory if it doesn't exist
mkdir -p ./fraud-detection

# Create the fraud_detection.py script
cat <<EOL > ./fraud-detection/fraud_detection.py
from pycaret.classification import *
import pandas as pd

# Load your fraud detection dataset
data = pd.read_csv('fraud_dataset.csv')

# Initialize PyCaret classification setup
clf1 = setup(data, target='fraud', session_id=123)

# Compare all available models and select the best one
best_model = compare_models()

# Save the best model
save_model(best_model, 'fraud_detection_model')

# Load the model and predict on new data
model = load_model('fraud_detection_model')
predictions = predict_model(model, data)
print(predictions)
EOL

# Create the Dockerfile for PyCaret
cat <<EOL > ./fraud-detection/Dockerfile
# Use the official Python image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required libraries (PyCaret and pandas)
RUN pip install pycaret pandas

# Expose the port (optional, if you’re planning to serve the model as an API later)
EXPOSE 5000

# Run the fraud detection script
CMD ["python", "fraud_detection.py"]
EOL

echo "PyCaret Dockerfile and fraud detection script have been created in ./fraud-detection"

