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
    
    var isVRMode:Bool = false
    
    var panoModel: PanoModel?
    
    override func viewDidLoad() {
        panoramaView?.setImage("test12.jpg")
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
        btnVRMode?.setTitle("Mode", for: .normal)
        btnVRMode?.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        self.view.addSubview(btnVRMode!)
    }
    
    func changeMode(sender: UIButton!) {
        if isVRMode {
            panoramaView?.setVRModeExt(false)
            isVRMode = false
        } else {
            panoramaView?.setVRModeExt(true)
            isVRMode = true
        }
    }
    
    func addVRReturnBtn() {
        btnVRReturn = UIButton(frame: CGRect(x: 0, y: self.view.frame.size.height-50, width: 100, height: 50))
        btnVRReturn?.setTitle("return", for: .normal)
        btnVRReturn?.addTarget(self, action: #selector(dissmissView), for: .touchUpInside)
        self.view.addSubview(btnVRReturn!)
    }
    
    func dissmissView(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil);
    }
}
