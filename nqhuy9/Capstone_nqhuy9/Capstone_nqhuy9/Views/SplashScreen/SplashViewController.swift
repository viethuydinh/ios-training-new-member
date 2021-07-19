//
//  SplashViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/15/21.
//

import UIKit
import RxSwift

class SplashViewController: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: AdvancedPageControlView!
    
    var splashViewModel = DefaultSplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.setupPageControl()
        self.setupCollectionView()
        self.startButton.layer.cornerRadius = 10.0
    }
    
    private func setupPageControl() {
        self.pageControl.numberOfPages = self.splashViewModel.listSplashImage.count
        self.pageControl.drawer = ExtendedDotDrawer(numberOfPages: self.splashViewModel.listSplashImage.count, space: 4.0, raduis: 6.0, height: 6.0, width: 6.0, currentItem: 0, dotsColor: #colorLiteral(red: 0.8823529412, green: 0.8980392157, blue: 0.9019607843, alpha: 1), indicatorColor: UIColor(red: 18.0/255.0, green: 121.0/255.0, blue: 194.0/255.0, alpha: 1), isBordered: false, borderColor: .clear, borderWidth: .zero)
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: SplashCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: SplashCollectionViewCell.identifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.view.layoutIfNeeded()
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height * 0.9)
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            layout.sectionInset = .zero
            layout.scrollDirection = .horizontal
        }
    }
    
    //MARK: -Event
    private func event() {
        self.eventStart()
    }
    
    private func eventStart() {
        self.startButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                guard let signInVC = self.getViewControllerFromStorybroad(storybroadName: "Authentication", identifier: SignInViewController.identifier) as? SignInViewController else { return }
                self.navigationController?.pushViewController(signInVC, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
}

extension SplashViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.splashViewModel.listSplashImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SplashCollectionViewCell.identifier, for: indexPath) as? SplashCollectionViewCell else { return UICollectionViewCell() }
        cell.imageSplash.image = self.splashViewModel.listSplashImage[indexPath.item]
        cell.size = CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height * 0.9)
        return cell
    }
}

extension SplashViewController : UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.setCurrentItem(offset: self.collectionView.contentOffset.x, width: collectionView.frame.width)
    }
}
