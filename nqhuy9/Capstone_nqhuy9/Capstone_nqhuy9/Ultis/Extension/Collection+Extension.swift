//
//  Collection+Extension.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/15/21.
//

import Foundation

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
