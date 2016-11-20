//
//  SphereViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-19.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit
import PanoramaView

class SphereViewController: GLKViewController {
    
    var panoramaView = PanoramaView()
    
    override func viewDidLoad() {
        panoramaView?.setImage("office21.jpg")
        panoramaView?.touchToPan = false          // Use touch input to pan
        panoramaView?.orientToDevice = true     // Use motion sensors to pan
        panoramaView?.pinchToZoom = true         // Use pinch gesture to zoom
        panoramaView?.showTouches = true         // Show touches
        self.view = panoramaView
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        panoramaView?.draw()
    }
}
