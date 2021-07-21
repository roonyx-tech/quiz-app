import UIKit

final class SignInView: UIView {
    
    let phoneTextField = PhoneNumberTextField()
    let passWordTextField = PassWordTextField()
    let signInButton = PrimaryButton()
    let registerButton = TextButton()
    private lazy var stackView = UIStackView(arrangedSubviews: [phoneTextField, passWordTextField, signInButton])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        addSubview(stackView)
        addSubview(registerButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ]
        )
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ]
        )
        NSLayoutConstraint.activate([phoneTextField.heightAnchor.constraint(equalToConstant: 44)])
    }

    private func configureView() {
        backgroundColor = .background
        stackView.distribution = .fillEqually
        signInButton.setTitle("Войти", for: .normal)
        stackView.axis = .vertical
        stackView.spacing = 20
        registerButton.setTitle("Зарегистрироваться", for: .normal)
    }
}
