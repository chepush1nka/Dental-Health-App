//
//  APIClient.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation

class APIClient {
    private let baseURL = "https://firebasestorage.googleapis.com/v0/b/dental-health-splat.appspot.com/o/"


    func uploadPhotos(type: String, images: [Data], completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = type == "color" ? "/handle_photo_upload_color" : "/handle_photo_upload_bite"
        let url = URL(string: baseURL + endpoint)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        var body = Data()

        for (index, image) in images.enumerated() {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\(index)\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(image)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
            }
        }

        task.resume()
    }

    func requestAnalysis(type: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = type == "color" ? "/handle_analysis_request_color" : "/handle_analysis_request_bite"
        let url = URL(string: baseURL + endpoint)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
            }
        }

        task.resume()
    }

    func provideRecommendations(type: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = type == "color" ? "/provide_recommendations_color" : "/provide_recommendations_bite"
        let url = URL(string: baseURL + endpoint)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
            }
        }

        task.resume()
    }
}
