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
