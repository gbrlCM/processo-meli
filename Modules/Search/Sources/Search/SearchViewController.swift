import UIKit
import DesignSystem
import Combine

@MainActor
protocol SearchViewControllerProtocol: AnyObject, ListUpdateDelegate where Section == Int, Item == ProductCellViewModel {}

final class SearchViewController: BaseCollectionViewController<Int, ProductCellViewModel> {
    private let interactor: SearchInteractorProtocol
    private let searchController: UISearchController
    private var cancellables: Set<AnyCancellable>
    private let searchSubject: CurrentValueSubject<String, Never>
    private let scrollSubject: PassthroughSubject<Bool, Never>
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(
            systemItem: .done,
            primaryAction: .init(handler: { [weak self] _ in self?.searchController.searchBar.resignFirstResponder() })
        )
        toolbar.setItems([flexibleSpace, done], animated: false)
        return toolbar
    }()
    
    init(interactor: SearchInteractorProtocol, initialQuery: String) {
        self.interactor = interactor
        self.searchController = UISearchController()
        self.cancellables = []
        self.searchSubject = .init(initialQuery)
        self.scrollSubject = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var layout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(16)
        group.edgeSpacing = .init(
            leading: .fixed(0),
            top: .fixed(0),
            trailing: .fixed(0),
            bottom: .fixed(8)
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        collectionView.delegate = self
        
        collectionView.register(ProductCell.self)
        setupBindings()
        
        searchController.searchBar.text = searchSubject.value
        searchController.searchBar.inputAccessoryView = toolbar
        toolbar.sizeToFit()
    }
    
    
    
    override func setupStyle() {
        title = L10n.title
        view.backgroundColor = UIColor(named: Colors.background)
        collectionView.backgroundColor = UIColor(named: Colors.background)
        searchController.searchBar.tintColor = UIColor(named: Colors.secondaryText)
    }
    
    func setupBindings() {
        searchSubject
            .filter { !$0.isEmpty }
            .removeDuplicates()
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main)
            .sink { [weak self] query in
                Task {
                    await self?.interactor.search(query: query)
                }
            }
            .store(in: &cancellables)
        
        scrollSubject
            .removeDuplicates()
            .filter { $0 }
            .throttle(for: .milliseconds(200), scheduler: RunLoop.main, latest: true)
            .sink { [weak self] _ in
                Task {
                    guard let self else { return }
                    await self.interactor.loadMoreElements(query: self.searchSubject.value)
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func buildCell(
        for collectionView: UICollectionView,
        at indexPath: IndexPath,
        with item: ProductCellViewModel
    ) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: item)
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchSubject.send(searchController.searchBar.text ?? "")
    }
}

extension SearchViewController: SearchViewControllerProtocol {}

extension SearchViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollSubject.send(collectionView.didScrollToTheEnd)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.selectedProduct(at: indexPath.row)
    }
}
