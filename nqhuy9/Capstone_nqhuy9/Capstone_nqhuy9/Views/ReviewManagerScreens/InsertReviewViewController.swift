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
    
    var review: Review?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.saveButton.layer.cornerRadius = 10
        self.setupView(backgroundColor: .white, view: self.reviewTextView, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.candidateNameTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.reviewTextView.text = self.review?.content
        self.candidateNameTextField.text = self.review?.candidateName
    }
    
    private func setupView(backgroundColor: UIColor,view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
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
                if self.insertReviewViewModel.createReview(review: Review(id: self.review != nil ? self.review?.id : nil, candidateName: self.candidateNameTextField.text, content: self.reviewTextView.text, status: self.statusButton.isChecked)) {
                    let dialog = AlertCustomView.init(title: "Success", content: "Update Review Success", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                } else {
                    let dialog = AlertCustomView.init(title: "Fail", content: "Update Review Fail", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                }
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
}
