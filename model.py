import ultralytics
from ultralytics import YOLO
import cv2 as cv

MIN_CONF = 0.5
A3 = 3
A35 = 3.5
A4 = 4


# you can turn this option on to check for different issues with the pretrained model, but it takes some time
# ultralytics.checks()

def load_image(photo_encoded):
    # image = cv2.imread(file_path)
    image = cv.imdecode(photo_encoded, cv.IMREAD_COLOR)
    return image


def determine_tooth_color(photo_encoded):
    image = load_image(photo_encoded)

    model = YOLO(f'detect/weights/best.pt')
    results = model.predict(source=image, save=True)  # you can set "save = True" to see the exact detection
    mean_prob = 0
    total_num = 0
    for result in results:
        names = result.names
        confidences = result.boxes.conf.numpy()
        print(confidences)
        labels = result.boxes.cls.numpy()
        for i in range(len(labels)):
            if confidences[i] > MIN_CONF:
                total_num += 1
                float_colour = float(names[labels[i]][1:])
                mean_prob += float_colour
    ans = mean_prob / total_num
    dist_1 = abs(A35 - ans)
    dist_2 = abs(A3 - ans)
    dist_3 = abs(A4 - ans)
    if dist_1 < dist_2 and dist_1 < dist_3:
        ans = A35
    if ans != A35:
        ans = round(ans)
    return "A" + str(ans)
