//
//  InsertKnowledgeViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import UIKit
import RxSwift

class InsertKnowledgeViewController: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var level: LevelKnowledge?
    
    var numberCell:Int = 1 {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var insertKnowledgeViewModel = DefaultKnowledgeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 16.0, left: .zero, bottom: .zero, right: .zero)
        self.tableView.register(UINib(nibName: InsertQuestionTableViewCell.name, bundle: nil), forCellReuseIdentifier: InsertQuestionTableViewCell.identifier)
    }
    
    //MARK: -Event
    private func event() {
        self.eventAddRow()
        self.eventBack()
        self.eventSave()
    }
    
    private func eventAddRow() {
        self.addButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.numberCell += 1
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
    
    private func eventBack() {
        self.backButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                print(self.insertKnowledgeViewModel.fetchListQuestion())
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
                self.insertKnowledgeViewModel.createListQuestion(questions: self.insertKnowledgeViewModel.listQuestions)
                self.navigationController?.popViewController(animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
}

extension InsertKnowledgeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InsertQuestionTableViewCell.identifier, for: indexPath) as? InsertQuestionTableViewCell else { return UITableViewCell() }
        cell.didEndEditAction = { [weak self] question in
            guard let level = self!.level else { return }
            self!.insertKnowledgeViewModel.listQuestions.append(Question(id: nil, content: question.content, level: level.rawValue))
        }
        return cell
    }
}

extension InsertKnowledgeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InsertQuestionTableViewCell.height()
    }
}