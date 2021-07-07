//
//  Convertible.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//

import Foundation
import CoreData

protocol ObjectConvertible {
    associatedtype Object : NSManagedObject
    
    var asObject : Object { get }
    
    func update (obj: Object) -> Object
    
    var primaryKey : [String:String] { get }
}

protocol DomainConvertible {
    associatedtype Domain
    
    var asDomain : Domain { get }
}

extension DomainConvertible {
    static var name : String { return String(describing: self) }
}

extension ObjectConvertible {
    static var name : String { return Object.name }
}
