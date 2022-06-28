//
//  ViewController.swift
//  CapstoneProject
//
//  Created by Thuy on 7/14/21.
//

import UIKit
import AVKit

class StartViewController: UIViewController {

    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    var authenticationVM = DefaultStartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name:NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.videoPlayer!.currentItem)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupUI() {
        Utilities.styleFilledButton(getStartedButton)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUpVideo() {
        self.videoPlayer = self.authenticationVM.getGif()
        self.videoPlayerLayer = AVPlayerLayer(player: self.videoPlayer)
        videoPlayerLayer?.frame = CGRect(x: 0,
                                         y: 0,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.videoPlayer!.seek(to: CMTime.zero)
        self.videoPlayer!.play()
    }

    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: LoginViewController.identifier) as? LoginViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

