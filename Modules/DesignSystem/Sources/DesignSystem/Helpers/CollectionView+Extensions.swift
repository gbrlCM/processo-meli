//
//  CollectionView+Extensions.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

import UIKit

extension UICollectionView {
    public var didScrollToTheEnd: Bool {
        let contentYOffset = contentOffset.y
        let contentHeight = contentSize.height
        let endTreshold: CGFloat = 130
        
        return contentYOffset > (contentHeight - frame.size.height - endTreshold) && !self.indexPathsForVisibleItems.isEmpty
    }
}
