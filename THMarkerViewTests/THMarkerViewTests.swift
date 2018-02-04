//
//  THMarkerViewTests.swift
//  THMarkerViewTests
//
//  Created by Seong ho Hong on 2018. 2. 4..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import XCTest
@testable import THMarkerView

class THMarkerViewTests: XCTestCase {
    var scrollView = UIScrollView()
    var markerArray = [THMarkerView]()
    
    var size = CGSize(width: 20, height: 20)
    var point = CGPoint(x:1500, y:1500)
    
    override func setUp() {
        super.setUp()
        let marker = THMarkerView()
        marker.frame.size = size
        marker.set(origin: point, zoomScale: 2.0, scrollView: scrollView)
        
        marker.delegate = self
        scrollView.delegate = self
        
        marker.index = markerArray.count
        markerArray.append(marker)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSet() {
        XCTAssertEqual(markerArray[0].frame.size, size)
        XCTAssertEqual(markerArray[0].frame.origin.x, scrollView.zoomScale*point.x)
        XCTAssertEqual(markerArray[0].frame.origin.y, scrollView.zoomScale*point.y)
        XCTAssertEqual(markerArray[0].index, 0)
    }
}

extension THMarkerViewTests: UIScrollViewDelegate {
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        markerArray.map { marker in
            marker.framSet()
        }
    }
}

extension THMarkerViewTests: THMarkerViewDelegate {
    func tapEvent(marker: THMarkerView) {
        
    }
}
