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
    
    var btnVRMode: UIButton?
    var btnVRReturn: UIButton?
    // VR mode status
    var isVRMode:Bool = false
    
    override func viewDidLoad() {
        panoramaView?.setImage("test13.jpg")
        panoramaView?.touchToPan = false
        panoramaView?.orientToDevice = true
        panoramaView?.pinchToZoom = false
        panoramaView?.showTouches = false
        panoramaView?.setVRModeExt(false)
        self.view = panoramaView
        
        // add change to VR mode button
        addVRModeBtn()
        // add return back from VR mode button
        addVRReturnBtn()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        panoramaView?.draw()
    }
    
    func addVRModeBtn() {
        btnVRMode = UIButton(frame: CGRect(x: self.view.frame.size.width-100, y: self.view.frame.size.height-50, width: 100, height: 50))
        btnVRMode?.setTitle("VR Mode", for: .normal)
        btnVRMode?.addTarget(self, action: #selector(toVRMode), for: .touchUpInside)
        self.view.addSubview(btnVRMode!)
    }
    
    func toVRMode(sender: UIButton!) {
        // panoramaView?.pinchToZoom = false
        // panoramaView?.touchToPan = false
        panoramaView?.setVRModeExt(true)
        isVRMode = true
        btnVRMode?.isHidden = true
        btnVRReturn?.isHidden = false
    }
    
    func addVRReturnBtn() {
        btnVRReturn = UIButton(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: 50))
        btnVRReturn?.setTitle("return", for: .normal)
        btnVRReturn?.addTarget(self, action: #selector(outVRMode), for: .touchUpInside)
        btnVRReturn?.isHidden = true
        self.view.addSubview(btnVRReturn!)
    }
    
    func outVRMode(sender: UIButton!) {
        // panoramaView?.pinchToZoom = false
        // panoramaView?.touchToPan = false
        panoramaView?.setVRModeExt(false)
        isVRMode = false
        btnVRMode?.isHidden = false
        btnVRReturn?.isHidden = true
    }
}
