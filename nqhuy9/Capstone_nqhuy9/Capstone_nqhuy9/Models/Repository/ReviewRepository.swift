//
//  ReviewRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

protocol ReviewRepository {
    func createReview(review : Review) -> Bool
    
    func fetchAllReview(completion: @escaping(([Review]) -> ())) -> Bool
    
    func deleteReview(id : String?) -> Bool
}

struct DefaultReviewRepository : ReviewRepository {
    
    var reviewDAO = CoreDataRepository<Review>.shared
    
    var reviewFirebase = FirebaseRepository<Review>.shared
    
    func createReview(review: Review) -> Bool {
        return reviewFirebase.save(tableName: "Review", domain: review, id: review.id)
    }
    
    func fetchAllReview(completion: @escaping(([Review]) -> ())) -> Bool {
        return reviewFirebase.fetchAll(tableName: "Review", field: nil, targetCondition: nil) { review in
            completion(review)
        }
    }
    
    func deleteReview(id : String?) -> Bool {
        guard let idDelete = id else { return false }
        return reviewFirebase.delete(tableName: "Review", value: idDelete)
    }
}
