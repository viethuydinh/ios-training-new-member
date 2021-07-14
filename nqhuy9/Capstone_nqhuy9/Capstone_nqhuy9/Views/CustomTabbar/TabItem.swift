//
//  TabItem.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case level = "Level"
    case question = "Question"
    case review = "Review"

    var viewController: UIViewController {
        switch self {
        case .level:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: ChooseLevelViewController.identifier) as? ChooseLevelViewController else { return UIViewController() }
            return vc
        case .question:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return UIViewController() }
            return vc
        case .review:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: ListReviewsViewController.identifier) as? ListReviewsViewController else { return UIViewController() }
            return vc
        }
    }

    var icon: UIImage {
        switch self {
        case .level:
            return UIImage(named: "level")!
        case .question:
            return UIImage(named: "question")!
        case .review:
            return UIImage(named: "review")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
