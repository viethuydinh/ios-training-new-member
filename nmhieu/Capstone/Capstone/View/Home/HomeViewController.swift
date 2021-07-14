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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.internButton.layer.cornerRadius = 10
        self.fresherButton.layer.cornerRadius = 10
        self.juniorButton.layer.cornerRadius = 10
        self.seniorButton.layer.cornerRadius = 10
    }
    
    //MARK: -Event
    @IBAction func eventInternButton() {
        self.eventOverlayView(level: .intern)
    }
    
    @IBAction func eventFresherButton() {
        self.eventOverlayView(level: .fresher)
    }
    
    @IBAction func eventJuniorButton() {
        self.eventOverlayView(level: .junior)
    }
    
    @IBAction func eventSeniorButton() {
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
            guard let vc = UIStoryboard(name: "Interview", bundle: nil).instantiateViewController(withIdentifier: InterviewViewController.identifier) as? InterviewViewController else { return }
            vc.level = level
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        
        }
        
        actionSheet.addAction(createAction)
        actionSheet.addAction(interViewAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}
