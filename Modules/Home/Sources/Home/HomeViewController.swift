import UIKit
import DesignSystem
import SnapKit

final class HomeViewController: LayoutableViewController {
    private let container: BlurBackgroundStackView = .init()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let searchTextField: DSTextField = DSTextField()
    private let searchButton: UIButton = UIButton(type: .system)
    private let textContainer: UIStackView = UIStackView()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(
            systemItem: .done,
            primaryAction: .init(handler: { [weak self] _ in self?.searchTextField.resignFirstResponder() })
        )
        toolbar.setItems([flexibleSpace, done], animated: false)
        return toolbar
    }()
    
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    override func setupHierarchy() {
        view.addSubview(container)
        view.addSubview(textContainer)
        textContainer.addArrangedSubview(titleLabel)
        textContainer.addArrangedSubview(descriptionLabel)
        container.addArrangedSubview(searchTextField)
        container.addArrangedSubview(searchButton)
    }
    
    override func setupLayout() {
        container.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Spacing.lg)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Spacing.lg)
        }
        
        textContainer.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Spacing.lg)
            make.top.equalTo(view.snp.top).inset(Spacing.xLg)
        }
    }
    
    override func setupStyle() {
        container.backgroundView.layer.cornerRadius = CornerRadius.lg
        container.backgroundView.backgroundColor = UIColor(named: Colors.background).withAlphaComponent(0.85)
        container.spacing = Spacing.md
        view.backgroundColor = UIColor(named: Colors.accent)
        
        container.axis = .vertical
        textContainer.axis = .vertical
        
        titleLabel.text = L10n.name
        titleLabel.textColor = UIColor(named: Colors.text)
        
        descriptionLabel.text = L10n.description
        descriptionLabel.textColor = UIColor(named: Colors.secondaryText)
        
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        container.setCustomSpacing(Spacing.xSm, after: titleLabel)
        
        searchTextField.backgroundColor = UIColor(named: Colors.cellBackground)
        searchTextField.textColor = UIColor(named: Colors.text)
        
        searchTextField.clipsToBounds = true
        searchButton.configuration = UIButton.Configuration.borderedProminent()
        searchButton.tintColor = UIColor(named: Colors.accent)
        searchTextField.placeholder = L10n.placeholder
        
        searchTextField.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        
        var title = try? AttributedString.init(markdown: L10n.button)
        
        title?.foregroundColor = UIColor(named: Colors.text)
        searchButton.configuration?.attributedTitle = title
    }
    
    func setupActions() {
        searchButton.addAction(
            .init(handler: { [weak self] _ in self?.interactor.search() }),
            for: .touchUpInside
        )
        
        searchTextField.addAction(
            .init(handler: { [weak self] _ in self?.interactor.textValueDidChange(self?.searchTextField.text ?? "") }),
            for: .editingChanged
        )
    }
}
