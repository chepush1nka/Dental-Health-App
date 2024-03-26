//
//  AnalysisResult.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

enum TeethColorType: Codable, Hashable {
    case undefined
    case A(type: Int)
    case B(type: Int)
    case C(type: Int)
    case D(type: Int)

    func toString() -> String {
        switch self {
        case .undefined:
            return "Не определен"
        case let .A(type):
            return "A\(type)"
        case .B(type: let type):
            return "B\(type)"
        case .C(type: let type):
            return "C\(type)"
        case .D(type: let type):
            return "D\(type)"
        }
    }
}

enum ByteType: String, Codable, Hashable {
    case undefined = "Не определен"
    case normal = "Нормальный"
    case distal = "Дистальный"
    case mesial = "Мезиальный"
    case deep = "Глубокий"
    case open = "Открытый"
    case cross = "Перекрестный"
}

enum AnalisysType: String, Codable, Hashable {
    case all = "Определение цвета зубов и прикуса"
    case teethColor = "Определение цвета зубов"
    case bite = "Определение прикуса"
}

struct AnalysisResult: Codable, Hashable {
    static func == (lhs: AnalysisResult, rhs: AnalysisResult) -> Bool {
        return lhs.type == rhs.type && lhs.teethColor == rhs.teethColor &&
        lhs.teethColorCareRecommendations == rhs.teethColorCareRecommendations &&
        lhs.bite == rhs.bite && lhs.biteСorrectionRecommendations == rhs.biteСorrectionRecommendations
    }

    let type: AnalisysType

    let teethColor: TeethColorType
    let teethColorCareRecommendations: String?

    let bite: ByteType
    let biteСorrectionRecommendations: String?

    init(type: AnalisysType, teethColor: TeethColorType, teethColorCareRecommendations: String? = nil, bite: ByteType, biteСorrectionRecommendations: String? = nil) {
        self.type = type
        self.teethColor = teethColor
        self.teethColorCareRecommendations = teethColorCareRecommendations
        self.bite = bite
        self.biteСorrectionRecommendations = biteСorrectionRecommendations
    }
}
