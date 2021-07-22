//
//  KnowledgeSetsViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 22/07/2021.
//

import UIKit

class KnowledgeSetsViewController: UIViewController {

    @IBOutlet weak var knowledgeTableView: UITableView!
    @IBOutlet weak var levelSegment: UISegmentedControl!
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bindingData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.knowledgeVM.clear()
    }
    
    //MARK: -UI
    private func setUpUI() {
        self.levelSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        self.levelSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.navy], for: UIControl.State.selected)
        
        self.knowledgeTableView.register(UINib(nibName: KnowledgeSetTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: KnowledgeSetTableViewCell.identifier)
        self.knowledgeTableView.dataSource = self
        self.knowledgeTableView.delegate = self
        self.knowledgeTableView.contentInset = .init(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)
    }
    
    //MARK: -Event
    @IBAction func eventLevelSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.knowledgeVM.level = .intern
        case 1:
            self.knowledgeVM.level = .fresher
        case 2:
            self.knowledgeVM.level = .junior
        case 3:
            self.knowledgeVM.level = .senior
        default:
            break
        }
        self.knowledgeVM.listKnowledges = self.knowledgeVM.fetchKnowledge(level: self.knowledgeVM.level)
        self.knowledgeTableView.reloadData()
    }
    
    @IBAction func eventAdd(_ sender: Any) {
        guard let vc = UIStoryboard(name: "InsertKnowledge", bundle: nil).instantiateViewController(withIdentifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
        vc.level = self.knowledgeVM.level
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -BindingData
    private func bindingData() {
        self.knowledgeVM.level = .intern
        self.knowledgeVM.listKnowledges = self.knowledgeVM.fetchKnowledge(level: self.knowledgeVM.level)
    }
}

//MARK: -UITableViewDataSource
extension KnowledgeSetsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.knowledgeVM.listKnowledges.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KnowledgeSetTableViewCell.identifier) as? KnowledgeSetTableViewCell else {
            return UITableViewCell()
        }
        cell.bindingData(knowledge: self.knowledgeVM.listKnowledges[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return KnowledgeSetTableViewCell.titleHeader(section: section)
    }
}

//MARK: -UITableViewDelegate
extension KnowledgeSetsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let knowlege = self.knowledgeVM.listKnowledges[indexPath.section]
        return KnowledgeSetTableViewCell.height(width: tableView.bounds.width,
                                                question: knowlege.content ?? "",
                                                answer: knowlege.answer ?? "")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            self.numberOfRow -= 1
            self.knowledgeTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KnowledgeSetTableViewCell.heightHeader
    }
}
