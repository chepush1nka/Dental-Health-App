//
//  ChartView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Вы проводили анализы \(getOldestAndNewestDates())\n\nВаши последние результаты:")
                    .bold()
                    .padding([.leading, .trailing, .bottom])
                HStack {
                    let result = UserData.shared.getLastResult()
                    DentalHealthMetricView(
                        metricName: "Цвет зубов",
                        metricValue: result.teethColor.toString(),
                        background: .white,
                        primary: .splatRed
                    )
                    DentalHealthMetricView(
                        metricName: "Прикус",
                        metricValue: result.bite.rawValue,
                        background: .white,
                        primary: .splatRed
                    )
                }.padding()
                Text("Динамика изменения цвета зубов:")
                    .bold()
                    .padding([.leading, .trailing, .bottom])
                let chartStyle = ChartStyle(backgroundColor: .white, accentColor: .red, secondGradientColor: .splatRed, textColor: .black, legendTextColor: .black, dropShadowColor: .gray)
                BarChartView(data: ChartData(values: teethColorData), title: "Результаты анализов цвета зубов", legend: "Quarterly", style: chartStyle, form: ChartForm.extraLarge)
                    .padding([.leading, .trailing, .bottom])
            }
        }.navigationTitle("Результаты анализов")
    }

    func getOldestAndNewestDates() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let dates = UserData.shared.getResults().keys.sorted()

        guard let oldestDate = dates.first, let newestDate = dates.last else {
            return ""
        }

        let calendar = Calendar.current
        let yearComponentOld = calendar.component(.year, from: oldestDate)
        let yearComponentNew = calendar.component(.year, from: newestDate)

        let dayComponentOld = calendar.component(.day, from: oldestDate)
        let dayComponentNew = calendar.component(.day, from: newestDate)

        if yearComponentOld == yearComponentNew {
            dateFormatter.dateFormat = "d MMMM"
            let oldestDateString = dateFormatter.string(from: oldestDate)
            dateFormatter.dateFormat = "d MMMM yyyy"
            let newestDateString = dateFormatter.string(from: newestDate)
            if dayComponentOld == dayComponentNew {
                return oldestDateString
            }
            return "c \(oldestDateString) по \(newestDateString)"
        } else {
            dateFormatter.dateFormat = "d MMMM yyyy"
            let oldestDateString = dateFormatter.string(from: oldestDate)
            let newestDateString = dateFormatter.string(from: newestDate)
            return "c \(oldestDateString) по \(newestDateString)"
        }
    }

    var teethColorData: [(String, Double)] {
        var filteredResults: [(String, Double)] = []
        let results = UserData.shared.getResults()

        for result in results.sorted(by: { $0.0 < $1.0 }) {
            let date = UserData.formatDate(result.key)
            let value: Double
            let label: String

            switch result.value.teethColor {
            case .A(type: let type):
                value = Double(type)
                label = "A\(type)"
            case .B(type: let type):
                value = Double(type)
                label = "B\(type)"
            case .C(type: let type):
                value = Double(type)
                label = "C\(type)"
            case .D(type: let type):
                value = Double(type)
                label = "D\(type)"
            case .undefined:
                continue
            }

            if let last = filteredResults.last {
                let lastDate = last.0.split(separator: "\n").first
                if "\(date)" != lastDate || value != last.1 {
                    filteredResults.append(("\(date)\n \(label)", value))
                }
            } else {
                filteredResults.append(("\(date)\n\(label)", value))
            }
        }
        return filteredResults
    }

}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

