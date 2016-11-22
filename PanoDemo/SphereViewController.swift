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
        panoramaView?.setImage("test13.jpg")
        panoramaView?.touchToPan = false          // Use touch input to pan
        panoramaView?.orientToDevice = true     // Use motion sensors to pan
        panoramaView?.pinchToZoom = false         // Use pinch gesture to zoom
        panoramaView?.showTouches = false         // Show touches
        panoramaView?.setVRModeExt(true)
        self.view = panoramaView
        
//        let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
//        btn.backgroundColor = UIColor.green
//        btn.setTitle("Click Me", for: .normal)
//        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        btn.tag = 1
//        self.view.addSubview(btn)
    }
    
    func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            //do anything here
        }
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        panoramaView?.draw()
    }
}
