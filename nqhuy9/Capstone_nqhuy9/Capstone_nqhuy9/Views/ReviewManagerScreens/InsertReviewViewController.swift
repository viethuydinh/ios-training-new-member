//
//  InsertReviewViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import UIKit
import RxSwift

class InsertReviewViewController: BaseVC {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var candidateNameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var statusButton: CheckBox!
    
    var insertReviewViewModel = DefaultReviewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.saveButton.layer.cornerRadius = 10
    }
    
    //MARK: -Event
    private func event() {
        self.eventBack()
        self.eventSave()
    }
    
    private func eventBack() {
        self.backButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.navigationController?.popViewController(animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventSave() {
        self.saveButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.insertReviewViewModel.createReview(review: Review(id: nil, candidateName: self.candidateNameTextField.text, content: self.reviewTextView.text, status: self.statusButton.isChecked))
                NotificationCenter.default.post(name: Notification.Name(NotificationKey.SAVE_REVIEW_DONE_KEY), object: nil)
                self.navigationController?.popViewController(animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
}
