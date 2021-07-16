//
//  Date+Extension.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/07/2021.
//

import Foundation

extension Date {
    static func now() -> Date { .init() }
    
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
