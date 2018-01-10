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
    var textContentView = TextContentView()
    var titleLabel = UILabel()

    
    var markerDataSoucrce:MarkerViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        
        titleLabel.center = self.view.center
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font.withSize(20)
        self.view.addSubview(titleLabel)
        
        textContentView.frame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 100)
        textContentView.backgroundColor = UIColor.white
        self.view.addSubview(textContentView)
        
        markerDataSoucrce = MarkerViewDataSource(scrollView: scrollView, imageView: imageView, ratioByImage: 400, titleLabelView: titleLabel, audioContentView: audioContentView, videoContentView: videoContentView, textContentView: textContentView)
        
        let markerView1 = MarkerView()
        markerView1.set(dataSource: markerDataSoucrce!, x: 2000, y: 2000, zoomScale: 1, isTitleContent: false, isAudioContent: true, isVideoContent: false, isTextContent: false)
        markerView1.setAudioContent(url: Bundle.main.url(forResource: "water", withExtension: "mp3")!)
        markerView1.backgroundColor = UIColor.red
        
        let markerView2 = MarkerView()
        markerView2.set(dataSource: markerDataSoucrce!, x: 3000, y: 3000, zoomScale: 0.5, isTitleContent: false, isAudioContent: false, isVideoContent: false, isTextContent: false)
        markerView2.backgroundColor = UIColor.blue

        let markerView3 = MarkerView()
        markerView3.set(dataSource: markerDataSoucrce!, x: 4000, y: 5000, zoomScale: 0.8, isTitleContent: false, isAudioContent: false, isVideoContent: true, isTextContent: false)
        markerView3.setVideoContent(url: Bundle.main.url(forResource: "seunga", withExtension: "mp4")!)
        markerView3.backgroundColor = UIColor.yellow
        
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
