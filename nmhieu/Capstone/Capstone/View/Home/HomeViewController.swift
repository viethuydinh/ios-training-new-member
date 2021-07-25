//
//  HomeViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 08/07/2021.
//

import UIKit

class HomeViewController: BaseVC {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var internButton: UIButton!
    @IBOutlet weak var fresherButton: UIButton!
    @IBOutlet weak var juniorButton: UIButton!
    @IBOutlet weak var seniorButton: UIButton!
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.internButton.superview!.layer.cornerRadius = 10
        self.fresherButton.superview!.layer.cornerRadius = 10
        self.juniorButton.superview!.layer.cornerRadius = 10
        self.seniorButton.superview!.layer.cornerRadius = 10
    }
    
    //MARK: -Event
    @IBAction func eventInternButton(_ sender: Any) {
        self.eventOverlayView(level: .intern)
    }
    
    @IBAction func eventFresherButton(_ sender: Any) {
        self.eventOverlayView(level: .fresher)
    }
    
    @IBAction func eventJuniorButton(_ sender: Any) {
        self.eventOverlayView(level: .junior)
    }
    
    @IBAction func eventSeniorButton(_ sender: Any) {
        self.eventOverlayView(level: .senior)
    }
    
    
    fileprivate func eventOverlayView(level : LevelInterView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let createAction = UIAlertAction(title: "Create question", style: .default) { (action) in
            guard let vc = UIStoryboard(name: "InsertKnowledge", bundle: nil).instantiateViewController(withIdentifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
            vc.level = level
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let interViewAction = UIAlertAction(title: "Interview", style: .default) { (action) in
            let numberQuestions = self.knowledgeVM.fetchKnowledge(level: level).count
            if numberQuestions >= 5 {
                guard let vc = UIStoryboard(name: "Interview", bundle: nil).instantiateViewController(withIdentifier: InterviewViewController.identifier) as? InterviewViewController else { return }
                vc.level = level
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.eventAlert(message: CommonError.notEnoughQuestion.rawValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        
        }
        actionSheet.addAction(createAction)
        actionSheet.addAction(interViewAction)
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}
