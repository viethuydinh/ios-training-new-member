//
//  ReviewViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

protocol ReviewViewModel {
    var review: Review? { get set }
    
    var reviewList: [Review] { get set }
    
    func createReview(review : Review)
    
    func fetchAllReview() -> [Review]
    
    func deleteReview(id : Int16?)
}

struct DefaultReviewViewModel : ReviewViewModel {
    
    var review: Review?
    
    var reviewList: [Review] = []
    
    var repository = DefaultReviewRepository()
    
    func createReview(review: Review) {
        self.repository.createReview(review: review)
    }
    
    func fetchAllReview() -> [Review] {
        self.repository.fetchAllReview()
    }
    
    func deleteReview(id: Int16?) {
        self.repository.deleteReview(id: id)
    }
}
