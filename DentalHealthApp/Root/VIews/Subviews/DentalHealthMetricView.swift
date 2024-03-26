//
//  DentalHealthMetricView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation
import SwiftUI

struct DentalHealthMetricView: View {
    let metricName: String
    let metricValue: String
    let background: Color
    let primary: Color

    var body: some View {
        VStack {
            Text(metricValue)
                .font(.headline)
                .bold()
            Text(metricName)
                .font(.caption)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(primary)
        .background(background.opacity(0.2))
        .cornerRadius(10)
    }
}

struct DentalHealthMetricView_Previews: PreviewProvider {
    static var previews: some View {
        DentalHealthMetricView(
            metricName: "JKDFN",
            metricValue: "74,",
            background: .gray,
            primary: .black
        )
    }
}
