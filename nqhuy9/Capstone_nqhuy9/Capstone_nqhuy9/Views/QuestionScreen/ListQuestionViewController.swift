//
//  ListQuestionViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import UIKit
import RxSwift

class ListQuestionViewController: BaseVC {
    
    @IBOutlet weak var levelSelectPickerView: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var tableViewQuestion: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var questionViewModel = DefaultKnowledgeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.setupPickerView()
        self.setupTableView()
    }
    
    private func setupPickerView() {
        self.levelSelectPickerView.dataSource = self
        self.levelSelectPickerView.delegate = self
    }
    
    private func setupTableView() {
        self.tableViewQuestion.delegate = self
        self.tableViewQuestion.dataSource = self
        self.tableViewQuestion.backgroundColor = .white
        self.tableViewQuestion.contentInset = UIEdgeInsets(top: 16.0, left: .zero, bottom: .zero, right: .zero)
        self.tableViewQuestion.register(UINib(nibName: QuestionTableViewCell.name, bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
    }
    
    //MARK: -Event
    private func event() {
        self.eventSearch()
        self.eventRecommend()
        self.eventAdd()
    }
    
    private func eventSearch() {
        self.searchButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.questionViewModel.listQuestions = self.questionViewModel.fetchListQuestion()
                self.tableViewQuestion.reloadData()
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventRecommend() {
        self.recommendButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.questionViewModel.listQuestions = self.questionViewModel.fetchRecommendQuestion()
                self.tableViewQuestion.reloadData()
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventAdd() {
        self.addButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
                vc.insertKnowledgeViewModel.isHaveTabBar.onNext(false)
                vc.insertKnowledgeViewModel.level = self.questionViewModel.level
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
}

extension ListQuestionViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
}

extension ListQuestionViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.questionViewModel.listLevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let view = Bundle.main.loadNibNamed(LevelPickerView.name, owner: self, options: nil)?.first as? LevelPickerView else { return UIView() }
        view.contentLabel.text = self.questionViewModel.listLevel[row].rawValue
        return view
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.questionViewModel.level = self.questionViewModel.listLevel[row]
    }
}

extension ListQuestionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionViewModel.listQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else { return UITableViewCell() }
        cell.question = self.questionViewModel.listQuestions[indexPath.row]
        return cell
    }
}

extension ListQuestionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let content = self.questionViewModel.listQuestions[indexPath.row].content else { return .zero }
        return QuestionTableViewCell.height(bounds: UIScreen.main.bounds, content: content)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.questionViewModel.deleteQuestion(id: self.questionViewModel.listQuestions[indexPath.row].id)
            self.questionViewModel.listQuestions.remove(at: indexPath.row)
            self.tableViewQuestion.reloadData()
        }
    }
}
