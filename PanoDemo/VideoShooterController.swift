//
//  VideoShooterController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-23.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class VideoShooterController: UIViewController {
    
    @IBOutlet weak var projectImg: UIImageView!
    
    let jabueUtil = JabueUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var firstImg: UIImage = UIImage(named: "haha.jpg")!
        projectImg.image = jabueUtil.reflectedImage(firstImg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
