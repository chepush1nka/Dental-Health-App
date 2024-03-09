import cv2
import numpy as np
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler

def load_image(file_path):
    # image = cv2.imread(file_path)
    image = cv2.imdecode(file_path, cv2.IMREAD_COLOR)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    return image

def extract_colors(image, num_colors=3):

    pixels = image.reshape((-1, 3))


    kmeans = KMeans(n_clusters=num_colors)
    kmeans.fit(pixels)


    colors = kmeans.cluster_centers_


    colors /= 255.0

    return colors


def determine_tooth_color(image_path):

    image = load_image(image_path)


    colors = extract_colors(image)


    avg_color = np.mean(colors, axis=0)
    tooth_color = "white" if np.max(avg_color) > 0.8 else "yellow"

    return tooth_color

# image_path = "/content/i-35-35-1536x1004.jpeg"
# tooth_color = determine_tooth_color(image_path)
# print(f"The tooth color is {tooth_color}.")