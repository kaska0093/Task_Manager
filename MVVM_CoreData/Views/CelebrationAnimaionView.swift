//
//  CelebrationAnimaionView.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 19.01.2024.
//

import Lottie
import UIKit

class CelebrationAnimaionView: UIView {
    
    var animationView: LottieAnimationView
    
    init(fileName: String) {
        let animation = LottieAnimation.named(fileName)
        self.animationView = LottieAnimationView(animation: animation)
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleToFill
        addSubview(animationView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)            
            ])
    }
    
    func play(complition: @escaping (Bool) -> Void) {
        animationView.play(completion: complition)
    }
}
