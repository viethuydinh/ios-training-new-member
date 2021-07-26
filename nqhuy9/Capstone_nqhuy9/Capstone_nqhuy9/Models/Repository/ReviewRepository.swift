//
//  ReviewRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

protocol ReviewRepository {
    func createReview(review : Review) -> Bool
    
    func fetchAllReview() -> [Review]
    
    func deleteReview(id : Int16?) -> Bool
}

struct DefaultReviewRepository : ReviewRepository {
    
    var reviewDAO = CoreDataRepository<Review>.shared
    
    func createReview(review: Review) -> Bool {
        let id = review.id != nil ? review.id : Int16(self.fetchAllReview().count + 1)
        var newReview = review
        newReview.id = id
        return reviewDAO.save(domain: newReview)
    }
    
    func fetchAllReview() -> [Review] {
        return reviewDAO.fetchAll(predicate: nil)
    }
    
    func deleteReview(id : Int16?) -> Bool {
        guard let idDelete = id else { return false }
        return reviewDAO.deleteAll(predicate: .init(format: "id = %@", argumentArray: [String(idDelete)]))
    }
}
