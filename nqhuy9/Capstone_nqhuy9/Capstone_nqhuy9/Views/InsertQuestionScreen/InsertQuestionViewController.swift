//
//  InsertQuestionViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class InsertQuestionViewController: BaseVC {
    
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var contentAnswerTrue: UITextField!
    @IBOutlet weak var contentAnswerFalseFirst: UITextField!
    @IBOutlet weak var contentAnswerFalseSecond: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var fetchButton: UIButton!
    
    var level: LevelKnowledge?
    
    var knowledgeViewModel = DefaultKnowledgeViewModel()

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
        self.eventSave()
        self.eventFetch()
    }
    
    private func eventSave() {
        self.saveButton
            .rx
            .controlEvent(.touchUpInside)
            .do( onNext:{ (_) in
                self.view.endEditing(true)
            })
            .withLatestFrom(Observable.combineLatest(self.contentTextField.rx.text, self.contentAnswerTrue.rx.text, self.contentAnswerFalseFirst.rx.text, self.contentAnswerFalseSecond.rx.text))
            .map{ Knowledge(question: Question(id: nil, content: $0!, level: self.level?.rawValue), answers: [Answer(id: nil, content: $1!, accuracy: true),Answer(id: nil, content: $2!, accuracy: false),Answer(id: nil, content: $3!, accuracy: false)]) }
            .subscribe { (knowledge) in
                self.knowledgeViewModel.createKnowledge(knowledge: knowledge)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventFetch(){
        self.fetchButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                print(CoreDataRepository<Answer>.shared.fetchAll(predicate: nil).count)
                print(CoreDataRepository<Answer>.shared.fetchAll(predicate: nil))
                print(CoreDataRepository<Question>.shared.fetchAll(predicate: nil).count)
                print(CoreDataRepository<Question>.shared.fetchAll(predicate: nil))
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }

}
