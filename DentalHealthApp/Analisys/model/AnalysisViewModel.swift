//
//  AnalysisViewModel.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev on 26.03.2024.
//

import SwiftUI
import Combine

class AnalysisViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showResultScreen = false
    @Published var analysisResult: AnalysisResult = AnalysisResult(type: .all, teethColor: .undefined, bite: .undefined)

    private let apiClient = APIClient()

    func performAnalysis(type: String, images: [UIImage]) {
        isLoading = true

        let imageDataArray = images.map { $0.jpegData(compressionQuality: 0.8) ?? Data() }

        apiClient.uploadPhotos(type: type, images: imageDataArray) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.requestAnalysis(type: type)
                case .failure(let error):
                    print("Error uploading photos: \(error.localizedDescription)")
                    self?.isLoading = false
                }
            }
        }
    }

    private func requestAnalysis(type: String) {
        apiClient.requestAnalysis(type: type) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let data = response.data(using: .utf8) {
                        do {
                            let decoder = JSONDecoder()
                            let analysisResult = try decoder.decode(AnalysisResult.self, from: data)
                            self?.analysisResult = analysisResult
                            self?.showResultScreen = true
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    } else {
                        print("Invalid response data")
                    }
                case .failure(let error):
                    print("Error requesting analysis: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
        }
    }

}

