//
//  UITableView+Extension.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 19/07/2021.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
}
