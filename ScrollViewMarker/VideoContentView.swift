//
//  VideoContentView.swift
//  ScrollViewMarker
//
//  Created by Seong ho Hong on 2018. 1. 5..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

enum PlayStatus: Int {
    case play = 0
    case pause
}

enum VideoStatus: Int {
    case showStatus = 0
    case hideStatus
}

class VideoContentView: UIView {
    private var videoTapGestureRecognizer = UITapGestureRecognizer()
    var player =  AVPlayer()
    var playStatus = PlayStatus.pause
    var ViddoStatus = VideoStatus.showStatus
    var fullscreenButton = UIButton()
    var videoButton = UIButton()
    var topVC = UIApplication.shared.keyWindow?.rootViewController
    
    func setVideoPlayer() {
//        videoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(videoViewTap(_:)))
//        videoTapGestureRecognizer.delegate = self
//        self.addGestureRecognizer(videoTapGestureRecognizer)
        self.backgroundColor = UIColor.black
        
        fullscreenButton.frame = CGRect(x: self.frame.width - 30, y: self.frame.height - 30, width: 20, height: 20)
        fullscreenButton.backgroundColor = UIColor.white
        fullscreenButton.layer.cornerRadius = 3
        fullscreenButton.layer.opacity = 0.5
        fullscreenButton.setImage(#imageLiteral(resourceName: "fullscreen"), for: .normal)
        fullscreenButton.addTarget(self, action: #selector(pressfullscreenButton(_ :)), for: .touchUpInside)
        
        videoButton.frame = CGRect(x: self.frame.width/2 - 25, y: self.frame.height/2 - 25, width: 50, height: 50)
        videoButton.backgroundColor = UIColor.white
        videoButton.layer.cornerRadius = 3
        videoButton.layer.opacity = 0.5
        videoButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
        videoButton.addTarget(self, action: #selector(pressVideoButton(_ :)), for: .touchUpInside)
    }
    
    func setVideo(name: String, format: String) {
        let videoUrl = Bundle.main.url(forResource: name, withExtension: format)
        if let url = videoUrl {
            player =  AVPlayer(url: url)
            player.allowsExternalPlayback = false
            
            let layer: AVPlayerLayer = AVPlayerLayer(player: player)
            layer.frame = self.bounds
            layer.videoGravity = AVLayerVideoGravity.resizeAspect
            self.layer.addSublayer(layer)
            self.addSubview(fullscreenButton)
            self.addSubview(videoButton)
        }
    }
    
    func setVideoUrl(url: URL) {
        player =  AVPlayer(url: url)
        player.allowsExternalPlayback = false
            
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.frame = self.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        self.layer.addSublayer(layer)
        self.addSubview(fullscreenButton)
        self.addSubview(videoButton)
    }
    
    private func playVideo() {
        playStatus = .play
        player.play()
    }
    
    private func playStatusVideo() {
        
    }
    
    private func pauseVideo() {
        playStatus = .pause
        player.pause()
    }
    
    @objc func pressVideoButton(_ sender: UIButton!) {
        if playStatus == .pause {
            playVideo()
        } else {
            pauseVideo()
        }
    }
    
    @objc func pressfullscreenButton(_ sender: UIButton!) {
        let playerViewController = AVPlayerViewController()
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.player = player
        
        self.parentViewController?.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

//extension VideoContentView: UIGestureRecognizerDelegate {
//
//}

