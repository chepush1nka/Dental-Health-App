//
//  UserData.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation

class UserData: Codable {
    static let shared = UserData()

    private var results: [Date: AnalysisResult] = [:]

    private init() {
        loadSettings()
        addResult(AnalysisResult(type: .all, teethColor: .A(type: 2), bite: .deep))
    }

    func getResults() -> [Date: AnalysisResult] {
        return results
    }

    func getLastResult() -> AnalysisResult {
        let sortedDates = results.keys.sorted()
        guard let lastDate = sortedDates.last, let lastResult = results[lastDate] else {
            return AnalysisResult(type: .all, teethColor: .undefined, bite: .undefined)
        }
        return lastResult
    }

    func addResult(_ result: AnalysisResult) {
        let date = Date()
        results[date] = result
        saveSettings()
    }

    private var filePath: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("userSettings.json")
    }

    func saveSettings() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            try data.write(to: filePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }

    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    private func loadSettings() {
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let settings = try decoder.decode(UserData.self, from: data)
            self.results = settings.results
        } catch {
            print("Ошибка при загрузке: \(error)")
        }
    }
}
