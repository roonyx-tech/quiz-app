import UIKit

final class CloseableViewController: CoordinatorNavigationController {
    private let closeBarButtonImage: UIImage?

    override init(backBarButtonImage: UIImage?, closeBarButtonImage: UIImage? = nil) {
        self.closeBarButtonImage = closeBarButtonImage
        super.init(backBarButtonImage: backBarButtonImage, closeBarButtonImage: closeBarButtonImage)
    }

    required init?(coder aDecoder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
    }

    private func setupCloseButton() {
        guard let rootViewController = viewControllers.first else { return }
        rootViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeBarButtonImage,
                                                                              style: .done,
                                                                              target: self,
                                                                              action: #selector(closeButtonDidTap))
//        rootViewController.navigationItem.rightBarButtonItem = nil
    }

    @objc
    private func closeButtonDidTap() {
        coordinatorNavigationDelegate?.customCloseButtonDidTap()
    }
}
