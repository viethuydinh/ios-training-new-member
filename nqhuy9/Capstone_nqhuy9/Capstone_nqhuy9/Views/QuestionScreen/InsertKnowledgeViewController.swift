//
//  InsertKnowledgeViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import UIKit
import RxSwift
import RxCocoa

class InsertKnowledgeViewController: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var distanceButtonAddFromBottom: NSLayoutConstraint!
    @IBOutlet weak var distanceBottomTableView: NSLayoutConstraint!
        
    var numberCell:Int = 0 {
        didSet {
            self.insertKnowledgeViewModel.listQuestions.append(Question(id: nil, content: "", level: self.insertKnowledgeViewModel.level.rawValue, answer: ""))
            self.tableView.reloadData()
            self.tableView.scrollToBottom()
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
        self.buttonHidden()
    }
    
    private func buttonHidden() {
        self.insertKnowledgeViewModel.isHaveTabBar.subscribe { (isHave) in
            self.backButton.isHidden = isHave
            self.distanceButtonAddFromBottom.constant = isHave ? 90.0 : 36.0
        } onError: { (_) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: self.disposeBag)

    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 16.0, left: .zero, bottom: 100.0, right: .zero)
        self.tableView.backgroundColor = .white
        self.tableView.register(UINib(nibName: InsertQuestionTableViewCell.name, bundle: nil), forCellReuseIdentifier: InsertQuestionTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                self.distanceButtonAddFromBottom.constant = keyboardHeight + 18.0
                self.distanceBottomTableView.constant = keyboardHeight - 10.0
            }
    }

    @objc func keyboardWillDisappear() {
        self.distanceButtonAddFromBottom.constant = 36.0
        self.distanceBottomTableView.constant = .zero
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
                if self.insertKnowledgeViewModel.createListQuestion(questions: self.insertKnowledgeViewModel.listQuestions) {
                    let dialog = AlertCustomView.init(title: "Success", content: "Create Question Success", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                } else {
                    let dialog = AlertCustomView.init(title: "Fail", content: "Create Question Fail", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                }
                NotificationCenter.default.post(name: Notification.Name(NotificationKey.UPDATE_QUESTION), object: nil)
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
            self?.insertKnowledgeViewModel.listQuestions[indexPath.row].content = question.content
            self?.insertKnowledgeViewModel.listQuestions[indexPath.row].answer = question.answer
        }
        cell.questionTextField.text = self.insertKnowledgeViewModel.listQuestions[indexPath.row].content
        cell.answerTextField.text = self.insertKnowledgeViewModel.listQuestions[indexPath.row].answer
        return cell
    }
}

extension InsertKnowledgeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InsertQuestionTableViewCell.height()
    }
}
