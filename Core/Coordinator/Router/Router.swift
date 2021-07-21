import UIKit

public typealias Callback = () -> Void

public final class Router: Presentable {
    private weak var rootController: CoordinatorNavigationController?
    private var completions: [UIViewController: Callback]

    public init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    public func toPresent() -> UIViewController? {
        rootController
    }

    public func present(_ module: Presentable?, animated: Bool = true, isCloseable: Bool = false) {
        if #available(iOS 13.0, *) {
            present(module, animated: animated, modalPresentationStyle: .automatic, isCloseable: isCloseable)
        } else {
            present(module, animated: animated, modalPresentationStyle: .overFullScreen, isCloseable: isCloseable)
        }
    }

    public func present(_ module: Presentable?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle, isCloseable: Bool = false) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = modalPresentationStyle
        if #available(iOS 13.0, *) { controller.isModalInPresentation = true }
        if isCloseable {
            rootController?.presentWithCloseBarButtonItem(controller, animated: animated, modalPresentationStyle: modalPresentationStyle, completion: nil)
        } else {
            rootController?.present(controller, animated: animated, completion: nil)
        }
    }

    public func dismissModule(animated: Bool = true, completion: Callback? = nil) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    /// Используется, чтобы скрыть контроллер презентованным на презентованном модуле
    public func dismissPresentedModule(_ presentedModule: Presentable?, animated: Bool = true, completion: Callback? = nil) {
        guard let controller = presentedModule?.toPresent() else { return }
        controller.dismiss(animated: true, completion: completion)
    }

    public func push(_ module: Presentable?, animated: Bool = true, hideBottomBarWhenPushed: Bool = false, completion: Callback? = nil) {
        guard let controller = module?.toPresent(), controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.enableSwipeBack()
        controller.hidesBottomBarWhenPushed = hideBottomBarWhenPushed
        rootController?.pushViewController(controller, animated: animated)
    }

    public func popModule(animated: Bool = true) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    public func setRootModule(_ module: Presentable?, isNavigationBarHidden: Bool = false) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = isNavigationBarHidden
    }

    public func popToRootModule(animated: Bool = true) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
