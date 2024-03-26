//
//  PriorAnalisysView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct PriorAnalisysView: View {
    var body: some View {
        //NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Анализы")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                        .padding(.leading)
                    PriorTimelineView()
                }
            }
    }
}

struct PriorTimelineView: View {

    let dates: [String] = []

    var body: some View {
        let options = ["Анализ цвета зубов", "Анализ прикуса"]
        let lastResults = UserData.shared.getLastResult()
        VStack(alignment: .leading, spacing: 20) {
            ForEach(options, id: \.self) { key in
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.splatRed)
                        .padding(.trailing)
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(key)
                                .bold()
                        }
                    }
                    Spacer()
                    if key == "Анализ цвета зубов" {
                        NavigationLink(destination: ColorPhotoView())  {
                            Text("Начать")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.splatRed)
                                .cornerRadius(10)
                        }.padding()
                    } else {
                        NavigationLink(destination: BitePhotoView())  {
                            Text("Начать")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.splatRed)
                                .cornerRadius(10)
                        }.padding()
                    }
                }
                .padding(.leading)
                Divider()
                    .padding(.leading, 5)
            }
        }
    }
}

struct PriorAnalisysView_Previews: PreviewProvider {
    static var previews: some View {
        PriorAnalisysView()
    }
}

