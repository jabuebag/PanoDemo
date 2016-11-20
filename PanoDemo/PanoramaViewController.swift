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
        let motionView:PanoramaViewer = PanoramaViewer(frame: self.view.bounds)
        motionView.setImage(UIImage(named:"F16pano.jpg")!)
        self.view.addSubview(motionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
