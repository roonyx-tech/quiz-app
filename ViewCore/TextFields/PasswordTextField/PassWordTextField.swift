import UIKit

final class PassWordTextField: PrimaryTextField {
    
    private let textMask = Veil(pattern: "+7 ### - ## - ##")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func textDidChange(_ sender: UITextField) {
        guard let currentText = sender.text else  {
            return
        }
        let maskedText = textMask.mask(input: currentText)
        sender.text = maskedText
        print((text ?? "") == maskedText)
    }
    
    private func configureView() {
//        addTarget(self, action: #selector(textDidChange(_:)), for: .allEditingEvents)
        placeholder = "Пароль"
        isSecureTextEntry = true
    }
}
