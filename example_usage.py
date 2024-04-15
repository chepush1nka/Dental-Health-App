import base64
import requests
filename = "IMG_7284.HEIC" # your file name
with open(filename, "rb") as img:
    string = base64.b64encode(img.read()).decode('utf-8')
# print(string)

api_url = "http://127.0.0.1:5000/handle_photo_upload_color"
response = requests.post(url= api_url, json={'user_photo_0':string, 'user_photo_1':string})
print(response.text)
api_url = "http://127.0.0.1:5000/handle_analysis_request_color"
response = requests.post(url = api_url, json={'user_photo_0':string, 'user_photo_1':string})
print(response.text)
api_url = "http://127.0.0.1:5000/provide_recommendations_color"
response = requests.get(url = api_url, json={'analysis_result':response.text})

print(response.text)

api_url = "http://127.0.0.1:5000/provide_recommendations_bite"
response = requests.get(url = api_url, json={'analysis_result':1})
print(response.text)
