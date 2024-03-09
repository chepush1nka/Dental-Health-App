import base64
import requests
filename = "black.png"
with open(filename, "rb") as img:
    string = base64.b64encode(img.read()).decode('utf-8')
# print(string)

api_url = "http://127.0.0.1:5000/handle_photo_upload"
response = requests.post(url= api_url, json={'user_photo':string})
print(response.text)
api_url = "http://127.0.0.1:5000/handle_analysis_request"
response = requests.post(url = api_url, json={'user_photo':response.text})
print(response.text)
api_url = "http://127.0.0.1:5000/provide_recommendations"
response = requests.get(url = api_url, json={'analysis_result':response.text})
print(response.text)
