//
//  Convertible.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//

import Foundation
import CoreData
//Domain
protocol ObjectConvertible {
    associatedtype Object : DomainConvertible & NSManagedObject
    
    func update (obj: Object) -> Object
}

protocol ObjectConvertibleFirebase {
    associatedtype ObjectFirebase : DomainConvertibleFirebase & Codable
    
    func asObject () -> ObjectFirebase
}

extension ObjectConvertible {
    static var name : String { return Object.name }
}

extension ObjectConvertibleFirebase {
    static var name : String { return ObjectFirebase.name }
}
//Object
protocol DomainConvertible {
    associatedtype Domain : ObjectConvertible
    
    var asDomain : Domain { get }
}

protocol DomainConvertibleFirebase {
    associatedtype DomainFirebase : ObjectConvertibleFirebase
    
    var asDomain : DomainFirebase { get }
}

extension DomainConvertible {
    static var name : String { return String(describing: self) }
}

extension DomainConvertibleFirebase {
    static var name : String { return String(describing: self) }
}




