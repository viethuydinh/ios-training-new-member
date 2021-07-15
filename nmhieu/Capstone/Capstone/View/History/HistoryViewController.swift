//
//  HistoryViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 15/07/2021.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var interviewVM = DefaultInterviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindingData()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.historyTableView.register(UINib(nibName: HistoryTableViewCell.name, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -Data
    func bindingData() {
        self.interviewVM.interviewHistory = self.interviewVM.fetchInterviewHistory()
    }
}

extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interviewVM.interviewHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as? HistoryTableViewCell else { return UITableViewCell() }
        cell.bindingData(data: self.interviewVM.interviewHistory[indexPath.row])
        return cell
    }
}

extension HistoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HistoryTableViewCell.height(tableView.bounds)
    }
}
