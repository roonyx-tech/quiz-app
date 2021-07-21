import UIKit

public protocol CoordinatorNavigationControllerDelegate: class {
    func transitionBackDidFinish()
    func customBackButtonDidTap()
    func customCloseButtonDidTap()
}

open class CoordinatorNavigationController: UINavigationController {
    public weak var coordinatorNavigationDelegate: CoordinatorNavigationControllerDelegate?

    private let backBarButtonImage: UIImage?
    private let closeBarButtonImage: UIImage?
    private var isPushBeingAnimated = false

    public init(backBarButtonImage: UIImage?, closeBarButtonImage: UIImage? = nil) {
        self.backBarButtonImage = backBarButtonImage
        self.closeBarButtonImage = closeBarButtonImage
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        nil
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = .white
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        isPushBeingAnimated = true
        super.pushViewController(viewController, animated: animated)
        setupBackButton(viewController: viewController)
    }

    public func presentWithCloseBarButtonItem(_ viewController: UIViewController, animated: Bool, modalPresentationStyle: UIModalPresentationStyle, completion: Callback?) {
        let rootController = CloseableViewController(backBarButtonImage: backBarButtonImage, closeBarButtonImage: closeBarButtonImage)
        rootController.setViewControllers([viewController], animated: true)
        rootController.modalPresentationStyle = modalPresentationStyle
        present(rootController, animated: animated, completion: completion)
    }

    public func setupBackButton(viewController: UIViewController) {
        viewController.navigationItem.hidesBackButton = false
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: backBarButtonImage,
                                                                          style: .done,
                                                                          target: self,
                                                                          action: #selector(backButtonDidTap))
    }

    func enableSwipeBack() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }

    @objc
    private func backButtonDidTap() {
        coordinatorNavigationDelegate?.customBackButtonDidTap()
    }
    
    internal func embedInCloseableController(_ viewController: UIViewController, animated: Bool = false) -> CloseableViewController {
        let rootController = CloseableViewController(backBarButtonImage: backBarButtonImage, closeBarButtonImage: closeBarButtonImage)
        rootController.setViewControllers([viewController], animated: animated)
        return rootController
    }
    
}

extension CoordinatorNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let coordinator = navigationController.topViewController?.transitionCoordinator else { return }
        coordinator.notifyWhenInteractionChanges { [weak self] context in
            guard !context.isCancelled else { return }
            self?.coordinatorNavigationDelegate?.transitionBackDidFinish()
        }
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? CoordinatorNavigationController else { return }
        swipeNavigationController.isPushBeingAnimated = false
    }
}

extension CoordinatorNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else { return true }
        return viewControllers.count > 1 && isPushBeingAnimated == false
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
