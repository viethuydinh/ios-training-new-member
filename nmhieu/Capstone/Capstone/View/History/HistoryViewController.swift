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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.bindingData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.historyTableView.register(UINib(nibName: HistoryTableViewCell.name, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
        self.historyTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: BaseTabBarViewController.shared.tabBarHeight, right: 0.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventTest(_ sender: Any) {
        print(self.interviewVM.fetchInterviewHistory())

    }
    //MARK: -Data
    func bindingData() {
        self.interviewVM.fetchInterviewHistory { interview, error in
            self.interviewVM.interviewHistory = interview
            self.historyTableView.reloadData()
        }
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
