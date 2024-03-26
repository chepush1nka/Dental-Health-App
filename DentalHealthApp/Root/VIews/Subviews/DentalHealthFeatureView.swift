//
//  DentalHealthFeatureView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import Foundation
import SwiftUI

struct DentalHealthFeatureView: View {
    let featureTitle: String
    let imageName: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Что нового?")
                    .font(.headline)
                    .bold()
                Text(featureTitle)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            Spacer()
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct DentalHealthFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        DentalHealthFeatureView(featureTitle: "IISBBS BSODVOJSDB BO DAESJBOB DOJBD SO", imageName: "ring-zub")
    }
}
