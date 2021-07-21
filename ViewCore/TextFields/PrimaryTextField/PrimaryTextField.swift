import UIKit

class PrimaryTextField: UITextField {

    open var placeholderColor: UIColor = .lightGray {
        didSet {
            updatePlaceholder()
        }
    }

    open var placeholderFont: UIFont = .init() {
        didSet {
            updatePlaceholder()
        }
    }

    override open var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: 48)
    }

    public var normalBackgroundColor: UIColor = .background {
        didSet {
            updateBackgroundColor()
        }
    }

    public var selectedBackgroundColor: UIColor = .background {
        didSet {
            updateBackgroundColor()
        }
    }

    var errorBackgroundColor: UIColor = .error {
        didSet {
            updateBackgroundColor()
        }
    }

    var isErrorState = false {
        didSet {
            updateBackgroundColor()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        autocorrectionType = .no
        updateBackgroundColor()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }

    @discardableResult open override func becomeFirstResponder() -> Bool {
        let isBecome = super.becomeFirstResponder()
        if isBecome {
            updateBackgroundColor()
        }
        return isBecome
    }

    @discardableResult open override func resignFirstResponder() -> Bool {
        let isResign = super.resignFirstResponder()
        if isResign {
            updateBackgroundColor()
        }
        return isResign
    }

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 11,
            y: 0,
            width: superRect.width - 11 * 2,
            height: superRect.height
        )
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 11,
            y: 0,
            width: superRect.width - 11 * 2,
            height: superRect.height
        )
    }

    private func updatePlaceholder() {
        guard let placeholder = placeholder else { return }

        let colorToSet = placeholderColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: colorToSet,
                .font: placeholderFont
            ]
        )
    }

    func updateBackgroundColor() {
        if isErrorState {
            backgroundColor = errorBackgroundColor
            return
        }
        layer.borderColor = isFirstResponder ? UIColor.trueBlue.cgColor : UIColor.lightGray.cgColor
        backgroundColor = isFirstResponder ? selectedBackgroundColor : normalBackgroundColor
    }
}
