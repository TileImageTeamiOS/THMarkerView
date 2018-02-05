//
//  ViewController.swift
//  ScrollViewMarker
//
//  Created by Seong ho Hong on 2018. 1. 1..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView = UIImageView()
    
    var markerArray = [THMarkerView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "bench.png")
        scrollView.addSubview(imageView)
        let marker = THMarkerView()
        marker.frame.size =  CGSize(width: 20, height: 20)
        marker.set(origin: CGPoint(x:1500, y:1500), zoomScale: 2.0, scrollView: scrollView)
        marker.setZoom(duration: 3.0, delay: 0.0, initialSpringVelocity: 0.66)
        marker.setImage(markerImage: UIImage(named: "marker.png")!)
        marker.delegate = self
        marker.index = markerArray.count
        markerArray.append(marker)
        
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
}
extension ViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        markerArray.map { marker in
            marker.framSet()
        }
    }
}
extension ViewController: THMarkerViewDelegate {
    func tapEvent(marker: THMarkerView) {
    }

}

