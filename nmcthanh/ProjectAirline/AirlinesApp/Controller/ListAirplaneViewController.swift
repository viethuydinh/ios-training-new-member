//
//  ViewController.swift
//  AirlinesApp
//
//  Created by Thuy on 6/30/21.
//

import UIKit

class ListAirplaneController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Airplane] = Airplane.example
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavTitle()
        tableView.register(UINib(nibName: "AirplaneCell", bundle: nil), forCellReuseIdentifier: "AirplaneCell")
    }
    
    func configureNavTitle() {
        let logo = UIImage(named: "NavTitle")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
}
    
extension ListAirplaneController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 120
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirplaneCell", for: indexPath) as! AirplaneCell
        cell.nameLabel.text = list[indexPath.row].name
        cell.overviewLabel.text = list[indexPath.row].overview
        cell.imageView?.image = UIImage(named: "\(list[indexPath.row].imageName)")
        cell.configureContainerView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: AirplaneInfoViewController.identifier) as! AirplaneInfoViewController
        vc.informationDetail = self.list[indexPath.row].information
        vc.imageName = self.list[indexPath.row].imageName
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

