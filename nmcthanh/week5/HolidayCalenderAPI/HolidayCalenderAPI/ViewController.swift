//
//  ViewController.swift
//  HolidayCalenderAPI
//
//  Created by Thuy on 7/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let holiday = listOfHolidays[indexPath.row]
        print(listOfHolidays)
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
}



