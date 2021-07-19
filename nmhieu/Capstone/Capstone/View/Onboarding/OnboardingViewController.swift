//
//  OnboardingViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 19/07/2021.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var gifCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    var onboardingVM = DefaultOnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    //MARK: -UI
    private func setUpUI() {
        self.startButton.layer.cornerRadius = 10
        self.gifCollectionView.register(UINib(nibName: GifOnboardingCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: GifOnboardingCollectionViewCell.name)
        self.gifCollectionView.dataSource  = self
        self.gifCollectionView.delegate = self
    }
    
    //MARK: -Event
    @IBAction func eventStart() {
        guard let vc = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "NavigationAuth") as? UINavigationController else { return }
        self.view.window?.rootViewController = vc
    }
}

extension OnboardingViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.onboardingVM.listGifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifOnboardingCollectionViewCell.name, for: indexPath) as? GifOnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bindingData(gif: self.onboardingVM.listGifs[indexPath.item])
        return cell
    }
}

extension OnboardingViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GifOnboardingCollectionViewCell.size(bounds: UIScreen.main.bounds)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let curentPage = Int(round(Double(scrollView.contentOffset.x/scrollView.bounds.width)))
        self.pageControl.currentPage = curentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
