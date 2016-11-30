//
//  PictureStitchController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-28.
//  Copyright © 2016 Kris Yang. All rights reserved.
//
import UIKit

class PictureStitchController: UIViewController {
    
    @IBOutlet weak var originImg: UIImageView!
    @IBOutlet weak var fadeImg: UIImageView!
    @IBOutlet weak var fadeBtn: UIButton!
    
    let imageUtil = ImageUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originImg.image = UIImage(cgImage: imageUtil.createFadeImage(500, 1, true)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fadeAction(_ sender: Any) {
        
    }
    
}
