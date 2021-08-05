//
//  AppDelegate.swift
//  AdvCoinApp
//
//  Created by Shyngys Kuandyk on 01.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private var diContainer: Container!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupWindow()
        setupDI()
        makeCoordinator(application: application)
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CoordinatorNavigationController(backBarButtonImage: nil)
        window?.makeKeyAndVisible()
    }
    
    private func setupDI() {
        let di: RootContainerConfigurator = .init(otherConfigurators: [])
        diContainer = di.configureContainer()
    }
    
    private func makeCoordinator(application: UIApplication) {
        guard let rootController = application.windows.first?.rootViewController as? CoordinatorNavigationController else {
            fatalError("rootViewController must be CoordinatorNavigationController")
        }
        
        appCoordinator = AppCoordinator(router: Router(rootController: rootController))
        appCoordinator?.start()
    }
}

