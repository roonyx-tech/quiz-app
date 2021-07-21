struct APIEnvironment: EnvironmentProtocol {
    /// The development environment.
    
    /// The default HTTP request headers for the given environment.
    var headers: ReaquestHeaders? {
        return [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer yourBearerToken"
        ]
    }
    
    /// The base URL of the given environment.
    var baseURL: String {
        return AppEnviroment.baseURL
    }
}
