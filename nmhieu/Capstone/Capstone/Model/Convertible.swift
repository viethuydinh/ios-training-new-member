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
//Object
protocol DomainConvertible {
    associatedtype Domain : ObjectConvertible
    
    var asDomain : Domain { get }
}

extension DomainConvertible {
    static var name : String { return String(describing: self) }
}

extension ObjectConvertible {
    static var name : String { return Object.name }
}
