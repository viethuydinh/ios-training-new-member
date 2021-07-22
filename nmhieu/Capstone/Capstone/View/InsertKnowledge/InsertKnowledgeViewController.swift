//
//  InsertKnowledgeViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import UIKit

class InsertKnowledgeViewController: UIViewController {

    @IBOutlet weak var knowledgeTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    
    var level : LevelInterView? 
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    var originYBottomView : CGFloat = .zero
    
    var bottomHeightSafeArea : CGFloat = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.event()
        self.bindingData()
    }
    
    override func viewDidLayoutSubviews() {
        self.getFrameOfContent()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.knowledgeTableView.register(UINib(nibName: KnowledgeTableViewCell.name, bundle: nil), forCellReuseIdentifier: KnowledgeTableViewCell.identifier)
        self.knowledgeTableView.dataSource = self
        self.knowledgeTableView.delegate = self
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
        notificationCenter.addObserver(self, selector: #selector(self.eventKeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
        self.knowledgeVM.numberOfRow += 1
        self.knowledgeTableView.reloadData()
        let row = self.knowledgeVM.numberOfRow - 1
        let indexPath : IndexPath = .init(row: row, section: 0)
        self.scrollToRow(indexPath: indexPath)
    }
    
    private func scrollToRow(indexPath : IndexPath) {
        self.knowledgeTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    @objc func eventEnterKnowledge(notification : Notification) {
        if let beginEditing = notification.userInfo?["beginEditing"] as? Bool {
            if beginEditing {
                let indexPath = notification.userInfo?["indexPath"] as! IndexPath
//                self.orderLabel.text = "\(indexPath.row)/\(self.knowledgeVM.numberOfRow)"
                self.scrollToRow(indexPath: indexPath)
            }
        }
    }
    
    @objc func eventKeyboardShow(notification : Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.bottomView.frame.origin.y == self.originYBottomView {
                let bottomChange = keyboardSize.height - self.bottomHeightSafeArea
                self.bottomView.frame.origin.y -= bottomChange
                self.knowledgeTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: bottomChange, right: 0.0)
//                self.orderLabel.isHidden = false
            }
        }
    }
    
    @objc func eventKeyboardHide(notification : Notification ){
        if self.bottomView.frame.origin.y != self.originYBottomView {
            self.bottomView.frame.origin.y = self.originYBottomView
            self.knowledgeTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
//            self.orderLabel.isHidden = true
        }
    }
    
    //MARK: -BindingData
    fileprivate func bindingData() {
        self.knowledgeVM.level = self.level ?? .intern
    }
    
    private func appendKnowledge(knowledge : KnowledgeModel) {
        self.knowledgeVM.listKnowledges.append(knowledge)
    }
}

extension InsertKnowledgeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.knowledgeVM.numberOfRow 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KnowledgeTableViewCell.identifier, for: indexPath) as? KnowledgeTableViewCell else {
            return UITableViewCell()
        }
        cell.knowledgeClosure = { knowledge in
            self.appendKnowledge(knowledge: knowledge)
        }
        cell.bindingData(indexPath: indexPath)
        return cell
    }
}

extension InsertKnowledgeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KnowledgeTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.knowledgeVM.numberOfRow -= 1
            self.knowledgeTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


