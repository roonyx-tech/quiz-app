protocol RootConfigurator {
    func configure()
}

protocol Container: AnyObject {
    func resolve<Service>(_ type: Service.Type, name: String?) -> Service

    func resolve<Service>(_ type: Service.Type) -> Service
}

extension Resolver: Container {
    func resolve<Service>(_ type: Service.Type, name: String?) -> Service {
        return resolve(type, name: name, args: nil)
    }

    func resolve<Service>(_ type: Service.Type) -> Service {
        return resolve(type, name: nil)
    }
}


final class RootContainer: Container {

    private let baseSontainer: Resolver

    init(baseSontainer: Resolver) {
        self.baseSontainer = baseSontainer
    }

    func resolve<Service>(_ type: Service.Type = Service.self, name: String? = nil) -> Service {
        return baseSontainer.resolve(type, name: name)
    }

    func resolve<Service>(_ type: Service.Type = Service.self) -> Service {
        return resolve(type, name: nil)
    }
    
}

final class RootContainerConfigurator {
    private let resolver: Resolver = Resolver.root
    private let otherConfigurators: [RootConfigurator]

    init(otherConfigurators: [RootConfigurator]) {
        self.otherConfigurators = otherConfigurators
    }
    
    func configureContainer() -> Container {
        let rootContainer = RootContainer(baseSontainer: resolver)
        let resolver = self.resolver
        
        resolver.register {
            APINetworkSession() as NetworkSessionProtocol
        }.scope(Resolver.application)
        
        resolver.register {
            APIRequestDispatcher(networkSession: resolver.resolve()) as RequestDispatcher
        }.scope(Resolver.application)
        
        return rootContainer
    }
}
