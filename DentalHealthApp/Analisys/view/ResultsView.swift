//
//  ResultsView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct ResultsView: View {
    let result: AnalysisResult
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    HStack {
                        ResultView(title: "Цвет зубов", value: "A1")
                        ResultView(title: "Прикус", value: "Нормальный")
                    }
                }

                Text("Цвет ваших зубов - А1. Оттенок ваших зубов, как правило, светлее среднего. Это считается очень светлым оттенком белого и является самым светлым естественным оттенком.\nАнализ вашего прикуса показывает, что у вас хорошее общее выравнивание и ваши зубы находятся в здоровом положении")
                    .padding(.vertical)
                Spacer()
                NavigationLink(destination: CareRecommendationsView()) {
                    Text("Перейти к рекомендациям")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.splatRed)
                        .cornerRadius(10)
                }.padding(.bottom)
            }
            .padding()
    }
}

struct ResultView: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(result: AnalysisResult(type: .bite, teethColor: .undefined, bite: .normal))
    }
}

