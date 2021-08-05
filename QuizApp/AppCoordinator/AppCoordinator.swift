
final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        let module = SignInViewControllerBuilder.build()
        router.setRootModule(module)
    }
    
}

