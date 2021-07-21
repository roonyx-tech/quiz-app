import UIKit

class TextButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 44)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        setTitleColor(.trueBlue, for: .normal)
        backgroundColor = .clear
        titleLabel?.textAlignment = .center
    }
}
