//
//  ViewController.swift
//  ScrollViewMarker
//
//  Created by Seong ho Hong on 2018. 1. 1..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var audioContentView: AudioContentView!
    @IBOutlet weak var videoContentView: VideoContentView!
    var textContentView: TextContentView!

    var markerDataSoucrce:MarkerViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        
        textContentView = TextContentView(frame: CGRect(x: self.view.frame.height - 100 , y: 0, width: self.view.frame.width, height: 200))
        
        markerDataSoucrce = MarkerViewDataSource(scrollView: scrollView, imageView: imageView, ratioByImage: 400, audioContentView: audioContentView, videoContentView: videoContentView)
        
        let markerView1 = MarkerView()
        markerView1.set(dataSource: markerDataSoucrce!, x: 2000, y: 2000, zoomScale: 1, isAudioContent: true, isVideoContent: false)
        markerView1.setAudioContent(name: "bell", format: "mp3")
        
        let markerView2 = MarkerView()
        markerView2.set(dataSource: markerDataSoucrce!, x: 3000, y: 3000, zoomScale: 0.5, isAudioContent: false, isVideoContent: false)

        let markerView3 = MarkerView()
        markerView3.set(dataSource: markerDataSoucrce!, x: 4000, y: 5000, zoomScale: 0.8, isAudioContent: false, isVideoContent: true)
        markerView3.setVideoContent(name: "seunga", format: "mp4")
        
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    func setZoomParametersForSize(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scollViewAction"), object: nil, userInfo: nil)
    }
}
