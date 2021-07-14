//
//  ReviewRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

protocol ReviewRepository {
    func createReview(review : Review)
    
    func fetchAllReview() -> [Review]
}

struct DefaultReviewRepository : ReviewRepository {
    
    var reviewDAO = CoreDataRepository<Review>.shared
    
    func createReview(review: Review) {
        let id = self.fetchAllReview().count + 1
        var newReview = review
        newReview.id = Int16(id)
        reviewDAO.save(domain: newReview)
    }
    
    func fetchAllReview() -> [Review] {
        return reviewDAO.fetchAll(predicate: nil)
    }
}
