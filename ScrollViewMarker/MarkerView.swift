//
//  MarkerView.swift
//  ScrollViewMarker
//
//  Created by Seong ho Hong on 2018. 1. 1..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

class MarkerView: UIView {
    fileprivate var dataSource: MarkerViewDataSource!
    private var x = Double()
    private var y = Double()
    
    public func set(dataSource: MarkerViewDataSource, x: Double, y: Double) {
        NotificationCenter.default.addObserver(self, selector: #selector(frameSet),
                                               name: NSNotification.Name(rawValue: "scollViewAction"),
                                               object: nil)
        self.dataSource = dataSource
        self.x = x
        self.y = y
        dataSource.scrollView.addSubview(self)
    }
    
    @objc private func frameSet() {
        let positionX = x * dataSource.zoomScale
        let positionY = y * dataSource.zoomScale
        let ratioLength = dataSource.rationHeight > dataSource.ratioWidth ? dataSource.rationHeight : dataSource.ratioWidth
        let scaleLength = dataSource.zoomScaleHeight > dataSource.zoomScaleWidth ? dataSource.zoomScaleHeight : dataSource.zoomScaleWidth
        
        if dataSource.zoomScale > 1.0 {
            self.frame = CGRect(x: positionX, y: positionY, width: scaleLength, height: scaleLength)
        } else {
            self.frame = CGRect(x: positionX, y: positionY, width: ratioLength, height: ratioLength)
        }
        
        self.backgroundColor = UIColor.red
    }
}
