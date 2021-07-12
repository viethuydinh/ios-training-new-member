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
    
    var level : LevelInterView? 
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindingData()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.knowledgeTableView.register(UINib(nibName: KnowledgeTableViewCell.name, bundle: nil), forCellReuseIdentifier: KnowledgeTableViewCell.identifier)
        self.knowledgeTableView.dataSource = self
        self.knowledgeTableView.delegate = self
        self.addButton.layer.cornerRadius = 25
    }
    
    //MARK: -Event
    fileprivate func event() {
        
    }
    
    @IBAction func eventDone() {
        self.knowledgeVM.saveKnowledge()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventAdd() {
        self.knowledgeVM.numberOfRow += 1
        self.knowledgeTableView.reloadData()
    }
    
    //MARK: -BindingData
    fileprivate func bindingData() {
        self.knowledgeVM.level = self.level ?? .intern
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
        if cell.detectViewEndediting() {
            
            self.knowledgeVM.knowledge?.append(cell.knowledge ?? nil)
        }
        
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


