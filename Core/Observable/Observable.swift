import Foundation

@propertyWrapper
public final class Observable<Value> {
    public var wrappedValue: Value? {
        didSet {
            valueDidChanged()
        }
    }

    public var projectedValue: Observable<Value> {
        self
    }

    private var observations = [UUID: (Value?) -> Void]()

    public init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }

    private func valueDidChanged() {
        observations.values.forEach { $0(wrappedValue) }
    }

    @discardableResult
    public func observe<O: AnyObject>(_ observer: O, closure: @escaping (O, Value?) -> Void) -> ObservationToken {
        let id = UUID()
        observations[id] = { [weak self, weak observer] item in
            guard let observer = observer else {
                self?.removeObserver(for: id)
                return
            }

            closure(observer, item)
        }

        if let value = wrappedValue {
            closure(observer, value)
        }

        return ObservationToken { [weak self] in
            self?.removeObserver(for: id)
        }
    }

    private func removeObserver(for id: UUID) {
        observations.removeValue(forKey: id)
    }
}

public final class ObservationToken {
    private let cancellationClosure: () -> Void

    public init(cancellationClosure: @escaping () -> Void) {
        self.cancellationClosure = cancellationClosure
    }

    public func cancel() {
        cancellationClosure()
    }
}

private extension Dictionary where Key == UUID {
    mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}
