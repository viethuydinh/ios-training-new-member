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
    
    func createReview(review : Review) -> Bool
    
    func fetchAllReview(completion: @escaping(([Review]) -> ())) -> Bool
    
    func deleteReview(id : String?) -> Bool
}

struct DefaultReviewViewModel : ReviewViewModel {
    
    var review: Review?
    
    var reviewList: [Review] = []
    
    var repository = DefaultReviewRepository()
    
    func createReview(review: Review) -> Bool {
        return self.repository.createReview(review: review)
    }
    
    func fetchAllReview(completion: @escaping(([Review]) -> ())) -> Bool {
        return self.repository.fetchAllReview { review in
            completion(review)
        }
    }
    
    func deleteReview(id: String?) -> Bool {
        return self.repository.deleteReview(id: id)
    }
}
