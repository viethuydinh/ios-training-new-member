//
//  Inject.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 10/08/2021.
//

import Foundation

@propertyWrapper
struct Inject<Service> {
    
    var name: String?
    
    var wrappedValue: Service {
        get {
            DefaultContainer.shared.container.resolve(Service.self, name: self.name)!
        }
        set {
            DefaultContainer.shared.container.register(Service.self, name: self.name) { (_)  in
                newValue
            }
        }
    }
    
    init(name: String? = nil) {
        self.name = name
    }
}

@propertyWrapper
struct DispatcherInject<D> {
    var name: String?
    var host: String
    var wrappedValue: D {
        get {
            DefaultContainer.shared.container.resolve(D.self, name: self.name, argument: self.host)!
        }
        set {
            DefaultContainer.shared.container.register(D.self, name: self.name) { (_)  in
                newValue
            }
        }
    }
    
    init(host: String, name: String? = nil) {
        self.name = name
        self.host = host
    }
}


