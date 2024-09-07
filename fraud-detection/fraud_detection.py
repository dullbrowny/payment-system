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
