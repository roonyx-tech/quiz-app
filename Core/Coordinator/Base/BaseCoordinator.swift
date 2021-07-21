import UIKit

open class BaseCoordinator: Coordinator {
    public private(set) var childCoordinators: [Coordinator] = []
    public let router: Router

    init(router: Router) {
        self.router = router
    }

    open func start() {}

    public func dismiss(child coordinator: Coordinator?) {
        router.dismissModule()
        removeDependency(coordinator)
    }

    public func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty,
            let coordinator = coordinator else { return }
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter { $0 !== coordinator }.forEach { coordinator.removeDependency($0) }
        }
        childCoordinators.removeAll { $0 === coordinator }
    }

    public func clearChildCoordinators() {
        childCoordinators.forEach { removeDependency($0) }
    }
}
