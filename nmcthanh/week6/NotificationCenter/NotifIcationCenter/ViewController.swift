//
//  ViewController.swift
//  NotifycationCenter
//
//  Created by Thuy on 7/13/21.
//

import UIKit

class ViewController: UIViewController {

    static var identifier : String { return "ViewController" }
    
    static var name : String { return self.identifier }
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let light = Notification.Name(rawValue: NotificationName.lightNotification)
    let dark = Notification.Name(rawValue: NotificationName.darkNotification)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = 20
        chooseButton.layer.borderWidth = 2
        creatObserver()
    }
    
    func creatObserver() {
        //light
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterImage(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackground(notification:)), name: light, object: nil)
        //dark
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterImage(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackground(notification:)), name: dark, object: nil)
    }
    
    @objc func updateCharacterImage(notification: NSNotification) {
        let isLight = notification.name == light
        let image = isLight ? UIImage(named: "luke")! : UIImage(named: "vader")!
        imageView.image = image
    }
    
    @objc func updateBackground(notification: NSNotification) {
        let isLight = notification.name == light
        let color = isLight ? UIColor.cyan : UIColor.red
        view.backgroundColor = color
    }
    
    
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        guard let selectionVC = sb.instantiateViewController(identifier: SelectionViewController.identifier) as? SelectionViewController else { return }
        present(selectionVC, animated: true, completion: nil)
    }
    
}
    

