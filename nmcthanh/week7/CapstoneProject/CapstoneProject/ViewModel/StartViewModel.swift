//
//  AuthenticationViewModel.swift
//  CapstoneProject
//
//  Created by Thuy on 7/15/21.
//

import Foundation
import AVFoundation

protocol StartViewModel {
    func getGif () -> AVPlayer
}

struct DefaultStartViewModel : StartViewModel {
    
    func getGif() -> AVPlayer {
        let bundlePath = Bundle.main.path(forResource: "cmc", ofType: "mp4")
        
        guard bundlePath != nil else {
            return AVPlayer()
        }

        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
    
        
        // Create the layer
        let videoPlayer = AVPlayer(playerItem: item)
        
        return videoPlayer
    }

}
