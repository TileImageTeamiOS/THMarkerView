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
    
    var markerViewArray = [MarkerView]()
    var markerDataSoucrce: MarkerViewDataSource!
    
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
        markerView1.set(dataSource: markerDataSoucrce!, x: 2000, y: 2000, zoomScale: 1, isTitleContent: true, isAudioContent: true, isVideoContent: false, isTextContent: false)
        markerView1.setTitle(title: "첫번째 마커")
        markerView1.setAudioContent(url: Bundle.main.url(forResource: "water", withExtension: "mp3")!)
        markerView1.setMarkerImage(markerImage: #imageLiteral(resourceName: "marker"))
        
        let markerView2 = MarkerView()
        markerView2.set(dataSource: markerDataSoucrce!, x: 3000, y: 3000, zoomScale: 0.5, isTitleContent: true, isAudioContent: false, isVideoContent: false, isTextContent: false)
        markerView2.setTitle(title: "두번째 마커")
        markerView2.backgroundColor = UIColor.blue

        let markerView3 = MarkerView()
        markerView3.set(dataSource: markerDataSoucrce!, x: 4000, y: 5000, zoomScale: 0.8, isTitleContent: true, isAudioContent: false, isVideoContent: true, isTextContent: true)
        markerView3.setTitle(title: "세번째 마커")
        markerView3.setVideoContent(url: Bundle.main.url(forResource: "seunga", withExtension: "mp4")!)
        markerView3.setText(title: nil, link: nil, content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        markerView3.backgroundColor = UIColor.yellow
        
        markerViewArray.append(markerView1)
        markerViewArray.append(markerView2)
        markerViewArray.append(markerView3)
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

    @IBAction func backButtonAction(_ sender: Any) {
        markerDataSoucrce.reset()
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
        markerViewArray.map { marker in
            markerDataSoucrce?.framSet(markerView: marker)
        }
    }
}
