//
//  ViewController.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 28/06/2021.
//

import UIKit

class ListAirlinerViewController: UIViewController {

    @IBOutlet weak var airplaneCollectionView: UICollectionView!
    
    var dataAirplane : [Airplane] = Airplane.example
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    
    }
    
    //MARK: UI
    fileprivate func setUpUI() {
        self.airplaneCollectionView.register(UINib(nibName: AirLineCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: AirLineCollectionViewCell.identifier)
        self.airplaneCollectionView.dataSource = self
        self.airplaneCollectionView.delegate = self
        self.airplaneCollectionView.contentInset = UIEdgeInsets(top: AirLineCollectionViewCell.lineSpace, left: 0, bottom: 0, right: 0)
    }
}

extension ListAirlinerViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataAirplane.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirLineCollectionViewCell.identifier, for: indexPath) as! AirLineCollectionViewCell
        cell.airplane = self.dataAirplane[indexPath.row]
        return cell
    }
    
}

extension ListAirlinerViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AirLineCollectionViewCell.size(bound: self.view.bounds)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AirLineCollectionViewCell.lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AirLineCollectionViewCell.lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "DetailAirplane", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailAirplaneViewController.identifier) as! DetailAirplaneViewController
        vc.dataAirplainInfo = self.dataAirplane[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
 }

