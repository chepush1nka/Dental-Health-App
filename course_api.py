import base64

import numpy as np
from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse
from model import determine_tooth_color

import sqlite3
import json
app = Flask(__name__)
api = Api(app)


class RecommendationService:
    def __init__(self):
        self.conn = sqlite3.connect('bite.db', check_same_thread=False)
        self.cursor = self.conn.cursor()

    def fetch_recommendations(self, color_result, bite_result):
        self.cursor.execute('SELECT description, products from recommendations WHERE name == ?', (bite_result,))
        bite_rec = self.cursor.fetchone()
        self.cursor.execute('SELECT description, products from colour_recommendations WHERE name == ?', (color_result,))
        color_rec = self.cursor.fetchone()
        if bite_rec is None or color_rec is None:
            return "ERROR"
        return str((bite_rec, color_rec))


class ColorAnalysisModel:
    def analyze_photo(self, photo):
        return determine_tooth_color(photo)


class BiteAnalysisModel:
    def analyze_photo(self, photo):
        return "Дистальный прикус"


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

    def handle_photo_upload(self):
        try:
            base64.b64decode(request.get_json().get('user_photo'))
        except:
            return "Can't upload your photo", 400
        return request.get_json().get('user_photo'), 201

    def handle_analysis_request(self):
        photo = base64.b64decode(request.get_json().get('user_photo'))
        try:
            photo = np.frombuffer(photo, np.uint8)
        except:
            return "Upload another picture, please", 400
        color_result = self.analysis_service.analyze_color(photo)
        bite_result = self.analysis_service.analyze_bite(photo)
        return jsonify({
            'color_analysis': color_result,
            'bite_analysis': bite_result
        }), 201

    def provide_recommendations(self):
        results = request.get_json()
        color_ans = json.loads(results["analysis_result"])["color_analysis"]
        bite_ans = json.loads(results["analysis_result"])["bite_analysis"]
        service = RecommendationService()
        recommendations = service.fetch_recommendations(color_ans, bite_ans)
        if recommendations == "ERROR":
            return "Can't procces the recommendations", 400
        return recommendations, 200


controller = APIController()


@app.route('/handle_photo_upload', methods=['POST'])
def upload():
    return controller.handle_photo_upload()


@app.route('/handle_analysis_request', methods=['POST'])
def request_analysis():
    return controller.handle_analysis_request()


@app.route('/provide_recommendations', methods=['GET'])
def provide():
    return controller.provide_recommendations()


if __name__ == '__main__':
    app.run(debug=True)
