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
        setupUI()
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: "AirplaneCell", bundle: nil), forCellReuseIdentifier: "AirplaneCell")
        tableView.dataSource = self
        tableView.delegate = self
        let logo = UIImage(named: "NavTitle")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
}
    
extension ListAirplaneController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AirplaneCell", for: indexPath) as? AirplaneCell else {
            return UITableViewCell()
        }
        cell.configureCell(list: list, indexPath: indexPath)
        cell.configureContainerView()
        return cell
    }
}

extension ListAirplaneController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 120
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: AirplaneInfoViewController.identifier) as? AirplaneInfoViewController else { return }
        vc.configureView(list: list, indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

