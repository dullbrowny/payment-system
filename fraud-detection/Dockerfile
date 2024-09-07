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
