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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.bindData()
        self.tableViewReview.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    private func bindData() {
        self.reviewViewModel.reviewList = self.reviewViewModel.fetchAllReview()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableViewReview.delegate = self
        self.tableViewReview.dataSource = self
        self.tableViewReview.backgroundColor = .white
        self.tableViewReview.contentInset = UIEdgeInsets(top: 16.0, left: .zero, bottom: .zero, right: .zero)
        self.tableViewReview.register(UINib(nibName: ReviewTableViewCell.name, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.identifier)
    }
    
    //MARK: -Event
    private func event() {
        self.eventAdd()
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
        return self.reviewViewModel.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        cell.review = self.reviewViewModel.reviewList[indexPath.row]
        return cell
    }
}

extension ListReviewsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let content = self.reviewViewModel.fetchAllReview()[indexPath.row].content else { return .zero }
        return ReviewTableViewCell.height(bounds: UIScreen.main.bounds, content: content)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let dialog = AlertCustomView.init(title: "Delete Alert", content: "Are you sure to delete?", isHiddenCancel: false) {
                if !self.reviewViewModel.deleteReview(id: self.reviewViewModel.reviewList[indexPath.row].id) {
                    let dialog = AlertCustomView.init(title: "Fail", content: "Delete Fail", isHiddenCancel: true) {
                        return
                    }
                    dialog.show(superView: self.view)
                }
                self.reviewViewModel.reviewList.remove(at: indexPath.row)
                self.tableViewReview.reloadData()
            }
            dialog.show(superView: self.view)
        }
    }
}
