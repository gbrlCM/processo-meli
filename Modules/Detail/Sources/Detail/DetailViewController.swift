import UIKit
import DesignSystem

@MainActor
protocol DetailViewControllerProtocol: AnyObject {}

final class DetailViewController: LayoutableViewController, DetailViewControllerProtocol {
    private let interactor: DetailInteractorProtocol
    
    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupStyle() {
        view.backgroundColor = UIColor(named: Colors.background)
    }
}
