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
        guard let vc = UIStoryboard(name: "InsertKnowledge", bundle: nil).instantiateViewController(withIdentifier: InsertKnowledgeViewController.identifier) as? InsertKnowledgeViewController else { return }
        vc.level = LevelInterView.intern
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func eventFresherButton() {
    
    }
    
    @IBAction func eventJuniorButton() {
        
    }
    
    @IBAction func eventSeniorButton() {
        
    }
}
