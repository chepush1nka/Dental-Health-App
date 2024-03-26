//
//  CareRecommendationsView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI

struct CareRecommendationsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Spacer()

            Text("Основываясь на результатах анализа ваших фотографий, вот несколько советов по уходу за вашими зубами")

            AdviceSection(advice: [
                ("Чистка зубов", "2 раза в день"),
                ("Использование зубной нити", "1 раз в день"),
                ("Посещение стоматолога", "Каждые 6 месяцев")
            ])

            ProductSection(products: [
                ("Splat", "299 ₽", "Зубная нить", "productImage1"),
                ("Splat ", "199 ₽", "Зубная паста", "productImage2")
            ])

            Spacer()

            NavigationLink(destination: DentalHealthView()) {
                Text("Отлично")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.splatRed)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.animation(.none)
        }
        .padding()
    }
}

struct AdviceSection: View {
    let advice: [(String, String)]

    var body: some View {
        ForEach(advice, id: \.0) { item in
            HStack {
                VStack {
                    Image(systemName: "hand.thumbsup.fill")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(item.0)
                        .fontWeight(.bold)
                    Text(item.1)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct ProductSection: View {
    let products: [(String, String, String, String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Products")
                .font(.headline)
                .fontWeight(.semibold)

            ForEach(products, id: \.0) { product in
                HStack {
                    // Replace placeholder image name with your image asset names
                    if let productImage = UIImage(named: product.3) {
                        Image(uiImage: productImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading) {
                        Text(product.0)
                            .fontWeight(.bold)
                        Text(product.2)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(product.1)
                        .fontWeight(.bold)
                }
                .padding(.vertical)
            }
        }
    }
}

struct CareRecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        CareRecommendationsView()
    }
}
