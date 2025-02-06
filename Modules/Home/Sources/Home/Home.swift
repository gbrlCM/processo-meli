import UIKit
import DesignSystem

public final class HomeViewController: BaseCollectionViewController<Int,String> {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var layout: UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Home"
        view.backgroundColor = ColorTokens.systemBackground
        collectionView.register(UICollectionViewListCell.self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateWithNewData(data: [0: ["Lady", "Gaga"], 1: ["Taylor", "Swift"]], animated: false)
    }
    
    public override func buildCell(for collectionView: UICollectionView, at indexPath: IndexPath, with item: String) -> UICollectionViewCell {
        let cell: UICollectionViewListCell = collectionView.dequeueReusableCell(for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = item
        config.image = .init(systemName: "person.circle")
        cell.contentConfiguration = config
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
}

#if DEBUG
import SwiftUI

struct AnyVCRepresentable: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

#Preview {
    AnyVCRepresentable(viewController: UINavigationController(rootViewController:  HomeViewController()))
}
#endif

