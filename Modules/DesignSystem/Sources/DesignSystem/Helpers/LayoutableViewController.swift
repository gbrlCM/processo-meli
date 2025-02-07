//
//  LayoutableViewController.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import UIKit

open class LayoutableViewController: UIViewController, Layoutable {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    open func setupHierarchy() {}
    open func setupLayout() {}
    open func setupStyle() {}
}
