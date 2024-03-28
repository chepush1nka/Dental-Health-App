import tensorflow as tf
from tensorflow.keras.preprocessing import image
from tensorflow.keras.applications.resnet50 import preprocess_input, decode_predictions
import numpy as np

# Функция загрузки и предобработки изображения
def load_and_preprocess_image(image_path):
    img = image.load_img(image_path, target_size=(224, 224))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)
    return img_array

# Функция загрузки модели ResNet50
def load_resnet_model():
    model = tf.keras.applications.ResNet50(weights='imagenet')
    return model

# Функция классификации изображения
def classify_tooth_bite(image_path, model):
    img_array = load_and_preprocess_image(image_path)
    predictions = model.predict(img_array)
    decoded_predictions = decode_predictions(predictions, top=6)[0] 
    classified_bite = [prediction[1] for prediction in decoded_predictions]
    return classified_bite
