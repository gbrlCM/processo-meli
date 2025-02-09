import UIKit
import DesignSystem

@MainActor
protocol DetailViewControllerProtocol: AnyObject, ListUpdateDelegate where Section == DetailSection, Item == DetailItem {}

final class DetailViewController: BaseCollectionViewController<DetailSection, DetailItem>, DetailViewControllerProtocol {
    private let interactor: DetailInteractorProtocol
    
    override var layout: UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard
                let self,
                let section = self.dataSource.sectionIdentifier(for: sectionIndex)
            else {
                return .list(using: .init(appearance: .plain), layoutEnvironment: environment)
            }
            
            switch section {
            case .presentation:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(400)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .list:
                return .list(using: .init(appearance: .plain), layoutEnvironment: environment)
            case .attributes:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(120)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(Spacing.md)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: Spacing.md, leading: Spacing.md, bottom: Spacing.md, trailing: Spacing.md)
                section.interGroupSpacing = Spacing.md
                return section
            }
        }
        return layout
    }
    
    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewListCell.self)
        collectionView.register(ProductImageCell.self)
        collectionView.register(GeneralInformationCell.self)
        collectionView.register(AttributeCell.self)
    }
    
    override func setupStyle() {
        view.backgroundColor = UIColor(named: Colors.background)
        collectionView.backgroundColor = UIColor(named: Colors.background)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadDetail()
    }
    
    override func buildCell(for collectionView: UICollectionView, at indexPath: IndexPath, with item: DetailItem) -> UICollectionViewCell {
        switch item {
        case let .image(image):
            let cell: ProductImageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: image)
            return cell
        case let .generalInfo(info):
            let cell: GeneralInformationCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: info)
            return cell
        case let .perk(perk):
            let cell: UICollectionViewListCell = collectionView.dequeueReusableCell(for: indexPath)
            var configuration = cell.defaultContentConfiguration()
            configuration.text = perk.value
            configuration.image = perk.icon
            configuration.textProperties.color = UIColor(named: .secondaryText)
            configuration.imageProperties.tintColor = UIColor(named: .accent)
            cell.contentConfiguration = configuration
            if #available(iOS 16.0, *) {
                var backgroundConfiguration = cell.defaultBackgroundConfiguration()
                backgroundConfiguration.backgroundColor = UIColor(named: .cellBackground)
                cell.backgroundConfiguration = backgroundConfiguration
            } else {
                cell.backgroundColor = UIColor(named: .cellBackground)
            }
            return cell
        case let .attribute(attribute):
            let cell: AttributeCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: attribute)
            return cell
        }
    }
}
