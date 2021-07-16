//
//  HistoryViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 15/07/2021.
//

import UIKit

<<<<<<< HEAD
class HistoryViewController: BaseVC {
=======
class HistoryViewController: UIViewController {
>>>>>>> 6190db0 (feat : implement feature history interview)
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var interviewVM = DefaultInterviewViewModel()
    
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> deb4dc0 (add : appicon)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.bindingData()
    }
    
<<<<<<< HEAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
=======
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindingData()
>>>>>>> 6190db0 (feat : implement feature history interview)
=======
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
>>>>>>> deb4dc0 (add : appicon)
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.historyTableView.register(UINib(nibName: HistoryTableViewCell.name, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
<<<<<<< HEAD
        self.historyTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
=======
>>>>>>> 6190db0 (feat : implement feature history interview)
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -Data
    func bindingData() {
        self.interviewVM.interviewHistory = self.interviewVM.fetchInterviewHistory()
<<<<<<< HEAD
<<<<<<< HEAD
        self.historyTableView.reloadData()
    }
}

//MARK: -UITableViewDataSource
=======
=======
        self.historyTableView.reloadData()
>>>>>>> deb4dc0 (add : appicon)
    }
}

>>>>>>> 6190db0 (feat : implement feature history interview)
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

<<<<<<< HEAD
//MARK: -UITableViewDelegate
=======
>>>>>>> 6190db0 (feat : implement feature history interview)
extension HistoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HistoryTableViewCell.height(tableView.bounds)
    }
}
