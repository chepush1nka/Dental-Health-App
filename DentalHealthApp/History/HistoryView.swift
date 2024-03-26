//
//  HistoryView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        //NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Анализы")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                        .padding(.leading)
                    TimelineView()
                }
            }
    }
}

struct TimelineView: View {

    let dates: [String] = []

    var body: some View {
        let results = UserData.shared.getResults()
        VStack(alignment: .leading, spacing: 20) {
            ForEach(results.keys.sorted().reversed(), id: \.self) { key in
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.splatRed)
                        .padding(.trailing)
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(results[key]?.type.rawValue ?? "Анализ")
                                .bold()
                            Text(UserData.formatDate(key))
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: ResultsView(result: results[key] ?? AnalysisResult(type: .bite, teethColor: .undefined, bite: .normal)))  {
                        Text("Просмотр")
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.splatRed)
                            .cornerRadius(10)
                    }.padding()
                }
                .padding(.leading)
                Divider()
                    .padding(.leading, 5)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

