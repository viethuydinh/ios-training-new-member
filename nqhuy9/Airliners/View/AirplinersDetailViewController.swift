//
//  AirplinersDetailViewController.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/29/21.
//

import UIKit

enum AirlinerDetailSection: Int, Comparable, CaseIterable {
    case general = 0
    case detail = 1
    
    static func < (lhs: AirlinerDetailSection, rhs: AirlinerDetailSection) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    var title: String {
        switch self {
        case .general:
            return ""
        case .detail:
            return "Infomation"
        }
    }
}

class AirplinersDetailViewController: UIViewController {
    
    static var identifier: String { return "AirplinersDetailViewController" }
    static var name: String { return self.identifier }
    
    @IBOutlet weak var collectionViewDetail: UICollectionView!
    @IBOutlet weak var imgParalel: UIImageView!
    @IBOutlet weak var heightParalel: NSLayoutConstraint!
        
    var airliner : Airplane! {
        didSet{
            dictionaryDetail.append(["National Origin":airliner.infomation.nation])
            dictionaryDetail.append(["Manifacturer":airliner.infomation.manufaturer])
            dictionaryDetail.append(["First Flight":airliner.infomation.firstFlight])
            dictionaryDetail.append(["Produced":airliner.infomation.produced])
            dictionaryDetail.append(["Number Built":airliner.infomation.numberBuilt])
            dictionaryDetail.append(["Status":airliner.infomation.status])
            dictionaryDetail.remove(at: 0)
        }
    }
    
    var dictionaryDetail : [[String : String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.imgParalel.downloaded(from: airliner.image)
        self.imgParalel.contentMode = .scaleAspectFill
        self.collectionViewDetail.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupCollectionView() {
        self.collectionViewDetail.delegate = self
        self.collectionViewDetail.dataSource = self
        self.collectionViewDetail.backgroundColor = .clear
        
        self.collectionViewDetail.register(name: AirlinersDescriptionCollectionViewCell.name, identifier: AirlinersDescriptionCollectionViewCell.identifier)
        self.collectionViewDetail.register(name: InfomationComponentCollectionViewCell.name, identifier: InfomationComponentCollectionViewCell.identifier)
        self.collectionViewDetail.registerKind(name: HeaderCollectionReusableView.name, identifier: HeaderCollectionReusableView.identifier, kind: UICollectionView.elementKindSectionHeader)
    }
}


extension AirplinersDetailViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case AirlinerDetailSection.detail.rawValue:
            return InfomationComponentCollectionViewCell.size(bounds: view.bounds.size)
        case AirlinerDetailSection.general.rawValue:
            return AirlinersDescriptionCollectionViewCell.size(bounds: view.bounds, content: self.airliner.infomation.longDescription)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.defaultPadding * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.defaultPadding * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case AirlinerDetailSection.general.rawValue:
            return .zero
        case AirlinerDetailSection.detail.rawValue:
            return CGSize(width: collectionView.frame.width, height: 40)
        default:
            return .zero
        }
      }
}

extension AirplinersDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AirlinerDetailSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case AirlinerDetailSection.general.rawValue:
            return 1
        case AirlinerDetailSection.detail.rawValue:
            return dictionaryDetail.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case AirlinerDetailSection.general.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirlinersDescriptionCollectionViewCell.identifier, for: indexPath) as? AirlinersDescriptionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.descriptionLabel.text = airliner.infomation.longDescription
            return cell
        case AirlinerDetailSection.detail.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfomationComponentCollectionViewCell.identifier, for: indexPath) as? InfomationComponentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureData(data: self.dictionaryDetail[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case AirlinerDetailSection.general.rawValue:
            return UIView() as! UICollectionReusableView
        case AirlinerDetailSection.detail.rawValue:
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
                return headerView
            default:
                assert(false, "Unexpected element kind")
            }
        default:
            assert(false, "Unexpected element kind")
        }
    }

}

//MARK: -Scroll Paralel Header
extension AirplinersDetailViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        let height = max(y,10)
        self.heightParalel.constant = height
    }
}
