//
//  AirplaneViewController.swift
//  AirlinesApp
//
//  Created by Thuy on 6/30/21.
//

import UIKit



class AirplaneInfoViewController: UIViewController {
    
    static var identifier : String { return "AirplaneInfoViewController" }
    
    static var name : String { return self.identifier }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var list: [Airplane] = Airplane.example

    var index: Int?
    
    var imageName: String?
        
    var informationDictionary : [[String : String]] = []
    
    var informationDetail : AirplaneInfo? {
        didSet {
            self.informationDictionary.append(["National Origin " : informationDetail!.nationalOrigin])
            self.informationDictionary.append(["Manufacturer" : informationDetail!.manufacturer])
            self.informationDictionary.append(["First Flight" : informationDetail!.firstFlight])
            self.informationDictionary.append(["Produced" : informationDetail!.produced])
            self.informationDictionary.append(["Number Built" : "\(informationDetail!.numberBuilt)"])
            self.informationDictionary.append(["Status " : informationDetail!.status])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AirplaneInfoCell", bundle: nil), forCellReuseIdentifier: "AirplaneInfoCell")
        imageView.image = UIImage(named: imageName!)
        configureDescriptionLabel()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureDescriptionLabel() {
        descriptionTextView.text = list[index!].information.description
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AirplaneInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirplaneInfoCell", for: indexPath) as! AirplaneInfoCell
        informationDictionary[indexPath.row].forEach { (key, value) in
            cell.informationListLabel.text = key
            cell.informationDetailLabel.text = value
            tableView.tableFooterView = UIView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Information"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
}


