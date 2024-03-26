//
//  DentalAnalysisView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct DentalHealthView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                MainHeaderView()

                NavigationLink(destination: PriorAnalisysView()) {
                    MenuOptionView(optionName: "Загрузить фото", systemImage: "camera")
                }
                NavigationLink(destination: ChartView()) {
                    MenuOptionView(optionName: "Результаты анализов", systemImage: "doc.text.magnifyingglass")
                }
                NavigationLink(destination: CareRecommendationsView()) {
                    MenuOptionView(optionName: "Рекомендации по уходу", systemImage: "heart.text.square")
                }
                NavigationLink(destination: HistoryView()) {
                    MenuOptionView(optionName: "История", systemImage: "clock")
                }

                Button(action: {

                }) {
                    Text("Пройти анализ")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.splatRed)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}

struct MenuOptionView: View {
    typealias Action = () -> Void
    let optionName: String
    let systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.gray)
            Text(optionName)
                .foregroundColor(.black)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 4)
    }
}

struct DentalHealthView_Previews: PreviewProvider {
    static var previews: some View {
        DentalHealthView()
    }
}
