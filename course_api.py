import base64

import numpy as np
from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse
from model import determine_tooth_color

import sqlite3
import json

app = Flask(__name__)
api = Api(app)

BITE = 3
COLOR = 2


class RecommendationService:
    def __init__(self):
        self.conn = sqlite3.connect('bite.db', check_same_thread=False)
        self.cursor = self.conn.cursor()

    def fetch_recommendations_color(self, color_result):
        self.cursor.execute('SELECT description, products from colour_recommendations WHERE name == ?', (color_result,))
        color_rec = self.cursor.fetchone()
        if color_rec is None:
            return "ERROR"
        return str([color_rec, color_result])

    def fetch_recommendations_bite(self, bite_result):
        self.cursor.execute('SELECT description, products from recommendations WHERE id == ?', (bite_result,))
        bite_rec = self.cursor.fetchone()
        if bite_rec is None:
            return "ERROR"
        return str([bite_rec, bite_result])


class ColorAnalysisModel:
    def analyze_photo(self, photo):
        return determine_tooth_color(photo)


class BiteAnalysisModel:
    def analyze_photo(self, photo):
        return 1


class PhotoAnalysisService:
    def analyze_color(self, photo):
        model = ColorAnalysisModel()
        return model.analyze_photo(photo)

    def analyze_bite(self, photo):
        model = BiteAnalysisModel()
        return model.analyze_photo(photo)


class APIController:
    def __init__(self):
        self.analysis_service = PhotoAnalysisService()

    def handle_photo_upload(self, number):
        try:
            for i in range(number):
                base64.b64decode(request.get_json().get(f'user_photo_{i}'))
        except:
            return f"Upload {number} photos again", 400

        return request.get_json(), 201

    def handle_analysis_request(self, number):
        photo = []
        try:
            for i in range(number):
                photo_now = base64.b64decode(request.get_json().get(f'user_photo_{i}'))
                photo.append(np.frombuffer(photo_now, np.uint8))
        except:
            return "Upload different pictures, please", 400
        if number == COLOR:
            color_result = self.analysis_service.analyze_color(photo)
            return str(color_result), 201
        else:
            bite_result = self.analysis_service.analyze_bite(photo)
            return str(bite_result), 201

    def provide_recommendations(self, number):
        results = request.get_json()
        ans = results.get('analysis_result')
        service = RecommendationService()
        if number == COLOR:
            recommendations = service.fetch_recommendations_color(ans)
        else:
            recommendations = service.fetch_recommendations_bite(ans)
        if recommendations == "ERROR":
            return "Can't procces the recommendations", 400
        return recommendations, 200


controller = APIController()


@app.route('/handle_photo_upload_color', methods=['POST'])
def upload_color():
    return controller.handle_photo_upload(COLOR)


@app.route('/handle_photo_upload_bite', methods=['POST'])
def upload_bite():
    return controller.handle_photo_upload(BITE)


@app.route('/handle_analysis_request_bite', methods=['POST'])
def request_analysis_bite():
    return controller.handle_analysis_request(BITE)


@app.route('/handle_analysis_request_color', methods=['POST'])
def request_analysis_color():
    return controller.handle_analysis_request(COLOR)


@app.route('/provide_recommendations_color', methods=['GET'])
def provide_color():
    return controller.provide_recommendations(COLOR)


@app.route('/provide_recommendations_bite', methods=['GET'])
def provide_bite():
    return controller.provide_recommendations(BITE)


if __name__ == '__main__':
    app.run(debug=True)
