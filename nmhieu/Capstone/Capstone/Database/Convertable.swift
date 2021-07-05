//
//  Convertable.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import Foundation
import CoreData

// Domain
protocol ObjectConvertable: Identifiable {
    associatedtype Object: DomainConvertable & NSManagedObject where Object.Domain == Self, Object.ID == Object.Domain.ID

    func update(object: Object) -> Object
     
}

// NSManagedObject
protocol DomainConvertable: Identifiable {
    associatedtype Domain: ObjectConvertable where Domain.Object == Self, Domain.ID == Domain.Object.ID
    
    var asDomain: Domain { get }
}

extension DomainConvertable {
    static var name: String { String(describing: self) }
}
