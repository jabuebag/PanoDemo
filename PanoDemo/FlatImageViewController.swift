//
//  FlatImageViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-29.
//  Copyright © 2016 Kris Yang. All rights reserved.
//
import UIKit
import GSImageViewerController

class FlatImageViewController: UIViewController {
    
    @IBOutlet weak var originImg: UIImageView!
    @IBOutlet weak var aspectFitImg: UIImageView!
    @IBOutlet weak var otherWayImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originImg.image = UIImage(named: "office.jpg")
        var originTapGesture = UITapGestureRecognizer(target: self, action: "originImgTap")
        originImg.addGestureRecognizer(originTapGesture)
        var aspectFitTapGesture = UITapGestureRecognizer(target: self, action: "fitImgTap")
        aspectFitImg.image = UIImage(named: "office.jpg")
        aspectFitImg.addGestureRecognizer(aspectFitTapGesture)
        otherWayImg.image = UIImage(named: "office.jpg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func originImgTap() {
        let imageInfo   = GSImageInfo(image:originImg.image!, imageMode: .aspectFill)
        let transitionInfo = GSTransitionInfo(fromView: originImg)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        present(imageViewer, animated: true, completion: nil)
    }
    
    func fitImgTap() {
        let imageInfo   = GSImageInfo(image:originImg.image!, imageMode: .aspectFit)
        let transitionInfo = GSTransitionInfo(fromView: originImg)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        present(imageViewer, animated: true, completion: nil)
    }
    
}
