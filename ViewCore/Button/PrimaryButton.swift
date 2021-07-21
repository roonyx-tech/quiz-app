import UIKit

class PrimaryButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 44)
    }
    
    override var isEnabled: Bool {
        didSet {
            setupAccesibility()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupAccesibility()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        setupAccesibility()
    }
    
    private func configureView() {
        backgroundColor = .trueBlue
        setTitleColor(.background, for: .normal)
        layer.cornerRadius = 8
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.primary.cgColor
    }
    
    private func setupAccesibility() {
        if isEnabled {
            backgroundColor = .trueBlue
        } else {
            backgroundColor = .lightGray
        }
    }
}
