//
//  ReviewViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

protocol ReviewViewModel {
    var review: Review? { get set }
    
    func createReview(review : Review)
    
    func fetchAllReview() -> [Review]
}

struct DefaultReviewViewModel : ReviewViewModel {
    
    var review: Review?
    
    var repository = DefaultReviewRepository()
    
    func createReview(review: Review) {
        self.repository.createReview(review: review)
    }
    
    func fetchAllReview() -> [Review] {
        self.repository.fetchAllReview()
    }
}
