//
//  BaseCollectionViewController.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

import UIKit
import SnapKit

open class BaseCollectionViewController<Section: Hashable & Sendable, Item: Hashable & Sendable>: LayoutableViewController {
    public private(set) lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        .init(collectionView: collectionView) {[weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }
            return self.buildCell(for: collectionView, at: indexPath, with: item)
        }
    }()
    
    public private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: .background)
        return collectionView
    }()
    
    private let loadingView: DSLoading = DSLoading()
    
    open var layout: UICollectionViewLayout { UICollectionViewFlowLayout() }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        view.addSubview(loadingView)
        collectionView.dataSource = dataSource
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loadingView.layer.zPosition = 1000
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return self?.buildSupplementaryView(for: collectionView, withKind: kind, at: indexPath)
        }
        
        loadingView.loading(false)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: Colors.accent)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: Colors.text)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        UIBarButtonItem.appearance().tintColor = UIColor(named: Colors.text)
    }
    
    open func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: Item
    ) -> UICollectionViewCell {
        fatalError("Abstract Method")
    }
    
    open func buildSupplementaryView(
        for collectionView: UICollectionView,
        withKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView? {
        return nil
    }
}

extension BaseCollectionViewController: ListUpdateDelegate {
    public func updateWithNewData(data: [CollectionViewSection<Section, Item>], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(data.map(\.sectionType))
        data.forEach {
            snapshot.appendItems($0.items, toSection: $0.sectionType)
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    public func loading(_ isLoading: Bool) {
        loadingView.loading(isLoading)
    }
}


