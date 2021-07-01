//
//  UICollectionView+Extension.swift
//  Airliners
//
//  Created by Nghiêm Huy on 7/1/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(name: String, identifier: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerKind(name:String, identifier: String, kind : String){
        self.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
}
