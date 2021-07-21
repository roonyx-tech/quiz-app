final class SignInViewModel {
    
    private let apiDispatcher: RequestDispatcher = Resolver.resolve()
    
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
}
