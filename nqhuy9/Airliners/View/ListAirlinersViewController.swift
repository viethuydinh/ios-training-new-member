//
//  ViewController.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/28/21.
//

import UIKit

class ListAirlinersViewController: UIViewController {
    
    @IBOutlet weak var collectionViewAirlines: UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var imgTitle : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionViewAirlines.register(name: AirlinersOverallCollectionViewCell.name, identifier: AirlinersOverallCollectionViewCell.identifier)
        self.collectionViewAirlines.dataSource = self
        self.collectionViewAirlines.delegate = self
        self.collectionViewAirlines.backgroundColor = .clear
        self.collectionViewAirlines.contentInset = UIEdgeInsets(top: CGFloat.defaultPadding*2, left: CGFloat.defaultPadding*2, bottom: .zero, right: CGFloat.defaultPadding*2)
    }
}

extension ListAirlinersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.defaultPadding*2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.defaultPadding*2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AirlinersOverallCollectionViewCell.size(bounds: self.view.bounds.size)
    }
}

extension ListAirlinersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Airplane.ListFakeAirplane.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirlinersOverallCollectionViewCell.identifier, for: indexPath) as! AirlinersOverallCollectionViewCell
        cell.airplane = Airplane.ListFakeAirplane[indexPath.row]
        cell.layer.cornerRadius = CGFloat.defaultPadding*2.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: AirplinersDetailViewController.identifier) as! AirplinersDetailViewController
        vc.airliner = Airplane.ListFakeAirplane[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

