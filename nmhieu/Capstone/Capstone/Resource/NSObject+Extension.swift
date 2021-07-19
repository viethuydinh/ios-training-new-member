//
//  NSObject+Extension.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
