//
//  BlurBackgroundStackView.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//


import UIKit

public final class BlurBackgroundStackView: UIStackView {
    public let backgroundView: UIVisualEffectView
    
    public init() {
        let blurEffect = UIBlurEffect(style: .regular)
        backgroundView = UIVisualEffectView(effect: blurEffect)
        
        super.init(frame: .zero)
        
        backgroundView.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(-16)
            make.bottom.trailing.equalToSuperview().offset(16)
        }
        
        backgroundView.layer.zPosition = -1
        backgroundView.layer.masksToBounds = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
