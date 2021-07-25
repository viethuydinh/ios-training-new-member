//
//  InsertKnowledgeViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import UIKit

class InsertKnowledgeViewController: BaseVC {

    @IBOutlet weak var knowledgeTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var bottomConstraintsTableView: NSLayoutConstraint!
    
    var level : LevelInterView? 
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    var numberOfRow : Int = 0 {
        didSet {
            self.knowledgeVM.listKnowledges.append(KnowledgeModel(id: nil, content: "", answer: "", level: self.level))
            self.knowledgeTableView.reloadData()
            self.knowledgeTableView.scrollToRow(at: .init(row: self.numberOfRow - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    var originYBottomView : CGFloat = .zero
    
    var bottomHeightSafeArea : CGFloat = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.event()
        self.bindingData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpConstrainSubView()
        self.getFrameOfContent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.knowledgeVM.clear()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.knowledgeTableView.register(UINib(nibName: KnowledgeTableViewCell.name, bundle: nil), forCellReuseIdentifier: KnowledgeTableViewCell.identifier)
        self.knowledgeTableView.dataSource = self
        self.knowledgeTableView.delegate = self
        self.knowledgeTableView.contentInset = .init(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    private func setUpConstrainSubView() {
        self.addButton.layer.cornerRadius = self.addButton.bounds.height/2
    }
    
    private func getFrameOfContent() {
        self.originYBottomView = self.bottomView.frame.origin.y
        let window = UIApplication.shared.windows.first
        self.bottomHeightSafeArea = window?.safeAreaInsets.bottom ?? .zero
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -Event
    private func event() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.eventKeyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.eventKeyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.eventEnterKnowledge(notification:)), name: NSNotification.Name(rawValue: NotificationKey.enterKnowledge), object: nil)
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventDone() {
        self.knowledgeVM.saveListKnowledges()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventAdd() {
        self.numberOfRow += 1
    }
    
    @objc func eventEnterKnowledge(notification : Notification) {
        if let beginEditing = notification.userInfo?["beginEditing"] as? Bool {
            if beginEditing {
                let indexPath = notification.userInfo?["indexPath"] as! IndexPath
                self.orderLabel.text = "\(indexPath.row  + 1)/\(self.numberOfRow)"
                self.knowledgeTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
        }
    }
    
    @objc func eventKeyboardShow(notification : Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.bottomView.frame.origin.y == self.originYBottomView {
                    let bottomChange = keyboardSize.height - self.bottomHeightSafeArea
                    self.bottomView.frame.origin.y -= bottomChange
                    self.knowledgeTableView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: bottomChange, right: 0.0)
                    self.orderLabel.isHidden = false
                }
            }
        }
    }
    
    @objc func eventKeyboardHide(notification : Notification ){
        if self.bottomView.frame.origin.y != self.originYBottomView {
            self.bottomView.frame.origin.y = self.originYBottomView
            self.knowledgeTableView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
            self.orderLabel.isHidden = true
        }
    }
    
    //MARK: -BindingData
    fileprivate func bindingData() {
        self.knowledgeVM.level = self.level ?? .intern
    }
}

//MARK: -UITableViewDataSource
extension InsertKnowledgeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KnowledgeTableViewCell.identifier, for: indexPath) as? KnowledgeTableViewCell else {
            return UITableViewCell()
        }
        cell.knowledgeClosure = { knowledge in
            self.knowledgeVM.listKnowledges[indexPath.row].content = knowledge.content
            self.knowledgeVM.listKnowledges[indexPath.row].answer = knowledge.answer
        }
        cell.bindingData(indexPath: indexPath, listKnowledge: self.knowledgeVM.listKnowledges)
        return cell
    }
}

//MARK: -UITableViewDelegate
extension InsertKnowledgeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KnowledgeTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.numberOfRow -= 1
            self.knowledgeTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


