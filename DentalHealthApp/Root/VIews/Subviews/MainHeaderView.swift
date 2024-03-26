//
//  MainHeaderView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation
import SwiftUI

struct MainHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Здоровые зубы с первого взгляда")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button(action: {
                    print("button pressed")

                }) {
                    Image(systemName: "person")
                        .resizable()
                        .foregroundColor(.splatRed)
                        .frame(width: 22, height: 22)
                }
                .padding()
            }
            let result = UserData.shared.getLastResult()
            HStack {
                DentalHealthMetricView(
                    metricName: "Цвет зубов",
                    metricValue: result.teethColor.toString(),
                    background: .gray,
                    primary: .black
                )
                //DentalHealthMetricView(metricName: "Plaque", metricValue: "1.9")
                DentalHealthMetricView(
                    metricName: "Прикус",
                    metricValue: result.bite.rawValue,
                    background: .gray,
                    primary: .black
                )
            }.padding()
            Divider().padding(.vertical)
            DentalHealthFeatureView(featureTitle: "Улучшено качество проверки цвета зубов, добавлены новые тона и ускорено время анализа", imageName: "ring-zub")
            .padding(.horizontal)
            Divider().padding(.vertical)
        }
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView()
    }
}
