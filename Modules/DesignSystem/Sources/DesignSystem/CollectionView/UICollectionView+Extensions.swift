//
//  UICollectionView+Extensions.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

import UIKit

extension UICollectionView {
    public func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(cell.self, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    public func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            preconditionFailure("no cell of type \(Cell.self) was found")
        }
        return cell
    }
}
