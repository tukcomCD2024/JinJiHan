//
//  DIContainer.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    var navigationRouter: NavigationRoutable & ObservableObjectSettable
    
    init(
        services: ServiceType,
        navigationRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter()
    ) {
        self.services = services
        self.navigationRouter = navigationRouter
        
        self.navigationRouter.setObjectWillChange(objectWillChange)
    }
}

extension DIContainer {
    static var stub: DIContainer {
        .init(services: StubServices())
    }
}
