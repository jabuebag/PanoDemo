//
//  PanoramaViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-19.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class PanoramaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let motionView:PanoramaView = PanoramaView(frame: self.view.bounds)
        motionView.setImage(UIImage(named:"London_Tower_Bridge_Sunset_Cityscape_Panorama")!)
        self.view.addSubview(motionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}