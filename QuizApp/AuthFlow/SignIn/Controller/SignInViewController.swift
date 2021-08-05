//
//  ViewController.swift
//  AdvCoinApp
//
//  Created by Shyngys Kuandyk on 01.07.2021.
//

import UIKit

protocol SignInModule: Presentable {
    var onRegisterTap: Callback? { get set }
}

final class SignInViewControllerBuilder {
    static func build() -> SignInModule {
        let viewModel = SignInViewModel()
        let controller = SignInViewController()
        controller.viewModel = viewModel
        return controller
    }
}

final class SignInViewController: UIViewController, ViewHolder, SignInModule {
    typealias RootViewType = SignInView

    var onRegisterTap: Callback?
    var viewModel: SignInViewModel!
    
    private let requestDispatcher: RequestDispatcher = Resolver.resolve()

    override func loadView() {
        view = SignInView()
        title = "Авторизация"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureActions()
    }
    
    @objc private func loginTapped() {
        viewModel.transForm(input: .loginTapped(email: rootView.phoneTextField.text!, password: rootView.passWordTextField.text!))
    }
    
    @objc private func registerTapped() {
        onRegisterTap?()
    }
    
    private func bindViewModel() {
        viewModel.$state.observe(self) { vc, output in
            guard let output = output else { return }
            switch output {
            case let .loginResult(result):
                print(result)
            }
        }
    }
    
    private func configureActions() {
        rootView.signInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        rootView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
}

