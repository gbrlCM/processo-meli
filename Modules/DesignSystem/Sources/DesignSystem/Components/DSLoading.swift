//
//  DSLoading.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//
import SnapKit
import UIKit

public final class DSLoading: UIView, Layoutable {
    private let progressIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let background: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupHierarchy() {
        addSubview(background)
        addSubview(progressIndicator)
    }
    
    public func setupLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.lg)
        }
    }
    
    public func setupStyle() {
        progressIndicator.color = UIColor(named: .accent)
        background.backgroundColor = UIColor(named: .cellBackground).withAlphaComponent(0.3)
        background.layer.zPosition = -1
        background.layer.masksToBounds = true
        background.clipsToBounds = true
        background.layer.cornerRadius = CornerRadius.lg
        layer.cornerRadius = CornerRadius.lg
    }
    
    public func loading(_ isLoading: Bool) {
        if isLoading {
            progressIndicator.startAnimating()
        } else {
            progressIndicator.stopAnimating()
        }
        
        isHidden = !isLoading
    }
}
