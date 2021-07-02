//
//  Convertable.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
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
