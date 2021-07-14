//
//  ListReviewsViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import UIKit
import RxSwift

class ListReviewsViewController: BaseVC {
    
    @IBOutlet weak var tableViewReview : UITableView!
    @IBOutlet weak var addButton : UIButton!
    
    var reviewViewModel = DefaultReviewViewModel()

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
        self.tableViewReview.delegate = self
        self.tableViewReview.dataSource = self
        self.tableViewReview.contentInset = UIEdgeInsets(top: 16.0, left: .zero, bottom: .zero, right: .zero)
        self.tableViewReview.register(UINib(nibName: ReviewTableViewCell.name, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.identifier)
    }
    
    //MARK: -Event
    private func event() {
        self.eventAdd()
        self.observerNotificationCenter()
    }
    
    private func observerNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(NotificationKey.SAVE_REVIEW_DONE_KEY), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.tableViewReview.reloadData()
    }
    
    private func eventAdd() {
        self.addButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertReviewViewController.identifier) as? InsertReviewViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }

}

extension ListReviewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewViewModel.fetchAllReview().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        cell.review = self.reviewViewModel.fetchAllReview()[indexPath.row]
        return cell
    }
}

extension ListReviewsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let content = self.reviewViewModel.fetchAllReview()[indexPath.row].content else { return .zero }
        return ReviewTableViewCell.height(bounds: UIScreen.main.bounds, content: content)
    }
}
