//
//  ImageProcessController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-22.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class ImageProcessController: UIViewController {
    
    @IBOutlet weak var topReflectionImg: UIImageView!
    @IBOutlet weak var originImg: UIImageView!
    @IBOutlet weak var bottomReflectionImg: UIImageView!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var resizeBtn: UIButton!
    @IBOutlet weak var sitichBtn: UIButton!
    @IBOutlet weak var stitchedImg: UIImageView!
    @IBOutlet weak var loadImgBtn: UIButton!
    @IBOutlet weak var localLoadImg: UIImageView!
    
    var imageUtil = ImageUtil()
    fileprivate let reflectionHeight: CGFloat = 1.00
    fileprivate var upsideDown: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bottomReflectionAction(_ sender: Any) {
        upsideDown = true
        let reflectionHeight = Int((self.originImg.image?.size.height)! * self.reflectionHeight)
        self.bottomReflectionImg.image = imageUtil.reflectedImage(originImg, withHeight: reflectionHeight, upsideDown: upsideDown)
    }
    
    @IBAction func topReflectionAction(_ sender: Any) {
        upsideDown = false
        let reflectionHeight = Int((self.originImg.image?.size.height)! * self.reflectionHeight)
        self.topReflectionImg.image = imageUtil.reflectedImage(originImg, withHeight: reflectionHeight, upsideDown: upsideDown)
    }
    
    @IBAction func resizeAction(_ sender: Any) {
        originImg.image = imageUtil.resizeImageWithFixedRatio(image: originImg.image!, newWidth: 4096.0)
    }
    
    @IBAction func stitchAction(_ sender: Any) {
        var stitichPhotos: [UIImage] = []
        stitichPhotos.append(topReflectionImg.image!)
        stitichPhotos.append(originImg.image!)
        stitichPhotos.append(bottomReflectionImg.image!)
        stitchedImg.image = imageUtil.stitchImages(images: stitichPhotos, isVertical: true)
        imageUtil.saveToFile(image: stitchedImg.image!)
    }
    
    @IBAction func loadAction(_ sender: Any) {
        localLoadImg.image = imageUtil.readFromFile(fileName: "testsave1.jpg")
    }
}
