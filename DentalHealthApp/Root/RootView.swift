//
//  ContentView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct RootView: View {
    var body: some View {
            TabView {
                DentalHealthView()
                    .tabItem {
                        Image(systemName: "list.clipboard")
                        Text("Анализ")
                    }

                HistoryView()
                    .tabItem {
                        Image(systemName: "tray.full")
                        Text("История")
                    }

                ChartView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Профиль")
                    }
            }
            .accentColor(.splatRed) // Accent color for tabs
        }
}

extension Color {
    static let splatRed = Color(red: 187 / 255, green: 13 / 255, blue: 47 / 255)
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
