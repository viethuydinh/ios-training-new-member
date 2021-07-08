//
//  Convertable.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import Foundation
import CoreData
//Domain
protocol ObjectConvert {
    associatedtype Object : DomainConvert & NSManagedObject
        
    func update(object: Object?) -> Object
    
    var key: [String : String] { get }
}


//Object
protocol DomainConvert {
    associatedtype Domain: ObjectConvert
    
    var asDomain: Domain { get }
}

extension DomainConvert {
    static var name: String { String(describing: self) }
}
