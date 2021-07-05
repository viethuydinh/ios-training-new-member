//
//  DetailAirplaneViewController.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 29/06/2021.
//

import UIKit

class DetailAirplaneViewController: UIViewController {

    static var identifier : String {return "DetailAirplaneViewController"}
    static var name : String {return self.identifier}
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgAirplane: UIImageView!
    @IBOutlet weak var heightImage: NSLayoutConstraint!
    
    var dataAirplainInfo : Airplane? {
        didSet {
            self.addInforDetail(airplaneData: dataAirplainInfo!.information ?? AirplaneInfor())
        }
    }
    
    var section : SectionAirplane?
    
    var detailDictionary : [[String:String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindingData()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.collectionView.register(UINib(nibName: LongInforCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: LongInforCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: DetailCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: HeaderCollectionReusableView.name, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: -Action
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  y = -scrollView.contentOffset.y + 10
        let height = max(y,10)
        self.heightImage.constant = height
    }
    
    //MARK: -BindingData
    fileprivate func bindingData() {
        self.imgAirplane.downloaded(from: self.dataAirplainInfo!.image!)
    }
    
    fileprivate func addInforDetail(airplaneData : AirplaneInfor) {
        self.detailDictionary.append(["National Origin":airplaneData.nationalOrigin ?? ""])
        self.detailDictionary.append(["Manufacturer" : airplaneData.manufacturer ?? ""])
        self.detailDictionary.append(["First Flight" :airplaneData.firstFlight ?? ""])
        self.detailDictionary.append(["Produced" : airplaneData.produced ?? ""])
        self.detailDictionary.append(["Number Build" : airplaneData.numberBuild ?? ""])
        self.detailDictionary.append(["Status":airplaneData.status ?? "" ])
        self.detailDictionary.remove(at: 0)
    }
    
}

extension DetailAirplaneViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SectionAirplane.longInfor.rawValue:
            return 1
        case SectionAirplane.detail.rawValue :
            return detailDictionary.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionAirplane.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SectionAirplane.longInfor.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongInforCollectionViewCell.identifier, for: indexPath) as? LongInforCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configData(self.dataAirplainInfo!.information?.longDescription ?? "")
            return cell
        case SectionAirplane.detail.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configData(self.detailDictionary[indexPath.row]) 
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case SectionAirplane.longInfor.rawValue :
            return UIView() as! UICollectionReusableView
        case SectionAirplane.detail.rawValue:
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
                header.configData(SectionAirplane.detail.title)
                return header
            default:
                return UIView() as! UICollectionReusableView
            }
        default:
            return UICollectionReusableView()
        }
    }
    
    
    
}

extension DetailAirplaneViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case SectionAirplane.longInfor.rawValue:
            return LongInforCollectionViewCell.size(bounds: self.view.bounds, content: self.dataAirplainInfo!.information?.longDescription ?? "")
        case SectionAirplane.detail.rawValue :
            return DetailCollectionViewCell.size(bounds: self.view.bounds)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case SectionAirplane.longInfor.rawValue:
            return .zero
        case SectionAirplane.detail.rawValue:
            return HeaderCollectionReusableView.size(bounds: self.view.bounds)
        default:
            return .zero
        }
    }
}

enum SectionAirplane : Int,Comparable,CaseIterable {
    case longInfor = 0
    case detail = 1
    
    static func < (lhs: SectionAirplane, rhs: SectionAirplane) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    var title : String {
        switch self {
        case .longInfor:
            return ""
        case .detail :
            return "Information"
        }
    }

}
