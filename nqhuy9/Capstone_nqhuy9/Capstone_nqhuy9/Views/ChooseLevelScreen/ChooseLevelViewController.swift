//
//  ViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import UIKit
import RxSwift
import RxCocoa

enum LevelKnowledge: String {
    case fresher = "Fresher"
    case junior = "Junior"
    case middle = "Middle"
    case senior = "Senior"
}

class ChooseLevelViewController: BaseVC {
    
    @IBOutlet weak var fresherButton:UIButton!
    @IBOutlet weak var juniorButton:UIButton!
    @IBOutlet weak var middleButton:UIButton!
    @IBOutlet weak var seniorButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.fresherButton.layer.cornerRadius = 10.0
        self.juniorButton.layer.cornerRadius = 10.0
        self.middleButton.layer.cornerRadius = 10.0
        self.seniorButton.layer.cornerRadius = 10.0
    }
    
    //MARK: -Event
    private func event() {
        self.eventPickFresher()
        self.eventPickJunior()
        self.eventPickMiddle()
        self.eventPickSenior()
    }
    
    private func eventPickFresher() {
        self.fresherButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
                vc.insertKnowledgeViewModel.isHaveTabBar.onNext(false)
                vc.insertKnowledgeViewModel.level = LevelKnowledge.fresher
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventPickJunior() {
        self.juniorButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
                vc.insertKnowledgeViewModel.isHaveTabBar.onNext(false)
                vc.insertKnowledgeViewModel.level = LevelKnowledge.junior
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventPickMiddle() {
        self.middleButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
                vc.insertKnowledgeViewModel.isHaveTabBar.onNext(false)
                vc.insertKnowledgeViewModel.level = LevelKnowledge.middle
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventPickSenior() {
        self.seniorButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let vc = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
                vc.insertKnowledgeViewModel.isHaveTabBar.onNext(false)
                vc.insertKnowledgeViewModel.level = LevelKnowledge.senior
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
}

