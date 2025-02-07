//
//  DSTextField.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import UIKit
import SnapKit

public final class DSTextField: UITextField {
    let padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    
    public init() {
        super.init(frame: .zero)
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }
}
