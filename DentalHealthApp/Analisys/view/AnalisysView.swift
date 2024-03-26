//
//  AnalisysView.swift
//  DentalHealthApp
//
//  Created by Pavel Vyaltsev.
//

import SwiftUI
import Lottie

struct AnalisysView: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        VStack {
            LottieView(name: "Animation-Analisys", loopMode: .loop)
                .frame(width: 200, height: 200)
                .onAppear {
                    self.isAnimating = true
                }
        }
    }
}

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // Leave this function empty for simple animations
    }
}

struct AnalisysView_Previews: PreviewProvider {
    static var previews: some View {
        AnalisysView()
    }
}
