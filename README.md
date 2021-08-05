# QuizApp
All business case writed on clean swift , without any side Dependencies, App has single view to demonstrate usage. 
The Architure of this project is Redux 
Navigation realized by Coordinator pattern 
View layouting maded by NSLayoutConstraints 
Depenncy Inversion realized by Resolver 
## Usage

## Network Layer 
Networking realized by base UserSession by specific class Api Dispatcher
```
    private let apiDispatcher: RequestDispatcher = Resolver.resolve()

    func makeSignIn(email: String, password: String) {
        apiDispatcher.execute(request: AuthTarget.signIn(pass: password, userName: email)) { result in
            print(result)
        }
    }
```

## Target where configurated endPoint and base parametres to make Request
```
enum AuthTarget: RequestProtocol {
    case signIn(pass: String, userName: String)

    var path: String {
        switch self {
        case .signIn:
            return "signIn"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var headers: ReaquestHeaders? {
        return nil
    }
    
    var parameters: RequestParameters? {
        switch self {
        case let.signIn(pass, userName):
            return ["userName": userName, "password": pass]
        }
    }
    
    var requestType: RequestType {
        return .data
    }
    
    var responseType: ResponseType {
        return .json
    }
    
    var progressHandler: ProgressHandler? {
        switch self {
        case .signIn:
            return nil
        }
    }
}
```

## Architecture
The main Architure of this project is  Redux Architecture system, where Store waits specific Input to reproduce specific Output
```
  enum Input {
        case loginTapped(email: String, password: String)
    }
    
    enum Output {
        case loginResult(result: String)
    }
    
    @Observable private(set) var state: Output?
    
    func transForm(input: Input) {
        switch input {
        case let.loginTapped(email, password):
            makeSignIn(email: email, password: password)
        }
    }

    func makeSignIn(email: String, password: String) {
        state = .loginResult(result: "Okkeds")
        apiDispatcher.execute(request: AuthTarget.signIn(pass: password, userName: email)) { result in
            print(result)
        }
    }
```

## Navigation
Navigation in the project realized by Coordinator pattern , which navigate between Presentable 
```
final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        let module = SignInViewControllerBuilder.build()
        router.setRootModule(module)
    }
    
```
## Views and Constraints 
Views created by autolayout without using of constructors

## How to set rootView
View holder it's protocol where view of Controller replaced by specific UIView
```
import UIKit

public protocol ViewHolder: AnyObject {
  associatedtype RootViewType: UIView
}

public extension ViewHolder where Self: UIViewController {

  var rootView: RootViewType {
    guard let rootView = view as? RootViewType else {
      fatalError("Excpected \(RootViewType.description()) as rootView. Now \(type(of: view))")
    }
    return rootView
  }
 }
```

## Usage of ViewHolder 

```
    class ViewController: UIViewController, ViewHolder { 
    typealias RootViewType = HomeView
    
    override func loadView() {
        view = HomeView()
    }
    }
```

## License
[MIT](https://github.com/roonyx-tech/quiz-app/blob/main/LICENSE)
