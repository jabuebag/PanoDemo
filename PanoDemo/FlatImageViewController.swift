//
//  FlatImageViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-29.
//  Copyright © 2016 Kris Yang. All rights reserved.
//
import UIKit
import GSImageViewerController
import ImageViewer

extension UIImageView: DisplaceableView {}

class FlatImageViewController: UIViewController, GalleryItemsDatasource, GalleryDisplacedViewsDatasource {
    
    @IBOutlet weak var originImg: UIImageView!
    @IBOutlet weak var aspectFitImg: UIImageView!
    @IBOutlet weak var otherWayImg: UIImageView!
    @IBOutlet weak var fadeEffectImg: UIImageView!
    
    let imageUtil = ImageUtil()
    var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originImg.image = UIImage(named: "office.jpg")
        var originTapGesture = UITapGestureRecognizer(target: self, action: "originImgTap")
        originImg.addGestureRecognizer(originTapGesture)
        var aspectFitTapGesture = UITapGestureRecognizer(target: self, action: "fitImgTap")
        aspectFitImg.image = imageUtil.maskImage(image: UIImage(named: "half1.jpg")!, withMask: UIImage(named: "half2.jpg")!)
        aspectFitImg.addGestureRecognizer(aspectFitTapGesture)
        var otherTapGesture = UITapGestureRecognizer(target: self, action: "otherImgTap")
        otherWayImg.image = UIImage(named: "halfhalf.jpg")
        otherWayImg.addGestureRecognizer(otherTapGesture)
        var fadeTapGesture = UITapGestureRecognizer(target: self, action: "fadeImgTap")
        fadeEffectImg.image = UIImage(named: "fadetest.jpg")
        fadeEffectImg.addGestureRecognizer(fadeTapGesture)
        
        imageViews += [originImg, aspectFitImg, otherWayImg, fadeEffectImg]
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
//        let imageInfo   = GSImageInfo(image:aspectFitImg.image!, imageMode: .aspectFit)
//        let transitionInfo = GSTransitionInfo(fromView: originImg)
//        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
//        present(imageViewer, animated: true, completion: nil)
        guard let displacedViewIndex = imageViews.index(of: aspectFitImg) else { return }
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        // let footerView = CounterView(frame: frame)
        let galleryViewController = GalleryViewController(startIndex: displacedViewIndex, itemsDatasource: self, displacedViewsDatasource: self, configuration: galleryConfiguration())
        // galleryViewController.footerView = footerView
        galleryViewController.launchedCompletion = { print("LAUNCHED") }
        galleryViewController.closedCompletion = { print("CLOSED") }
        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
        self.presentImageGallery(galleryViewController)
    }
    
    func otherImgTap() {
        guard let displacedViewIndex = imageViews.index(of: otherWayImg) else { return }
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        // let footerView = CounterView(frame: frame)
        let galleryViewController = GalleryViewController(startIndex: displacedViewIndex, itemsDatasource: self, displacedViewsDatasource: self, configuration: galleryConfiguration())
        // galleryViewController.footerView = footerView
        galleryViewController.launchedCompletion = { print("LAUNCHED") }
        galleryViewController.closedCompletion = { print("CLOSED") }
        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
        self.presentImageGallery(galleryViewController)
    }
    
    func fadeImgTap() {
        guard let displacedViewIndex = imageViews.index(of: fadeEffectImg) else { return }
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        // let footerView = CounterView(frame: frame)
        let galleryViewController = GalleryViewController(startIndex: displacedViewIndex, itemsDatasource: self, displacedViewsDatasource: self, configuration: galleryConfiguration())
        // galleryViewController.footerView = footerView
        galleryViewController.launchedCompletion = { print("LAUNCHED") }
        galleryViewController.closedCompletion = { print("CLOSED") }
        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
        self.presentImageGallery(galleryViewController)
    }
    
    
    func itemCount() -> Int {
        
        return 1
    }
    
    func provideDisplacementItem(atIndex index: Int) -> DisplaceableView? {
        
        print(index)
        return imageViews[index]
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let image = imageViews[index].image ?? UIImage(named: "0")!
            
        return GalleryItem.image { $0(image) }
    }
    
    func galleryConfiguration() -> GalleryConfiguration {
        
        return [
            
            GalleryConfigurationItem.pagingMode(.standard),
            GalleryConfigurationItem.presentationStyle(.displacement),
            GalleryConfigurationItem.hideDecorationViewsOnLaunch(false),
            
            // GalleryConfigurationItem.swipeToDismissHorizontally(false),
            // GalleryConfigurationItem.toggleDecorationViewsBySingleTap(false),
            
            GalleryConfigurationItem.overlayColor(UIColor(white: 0.035, alpha: 1)),
            GalleryConfigurationItem.overlayColorOpacity(1),
            GalleryConfigurationItem.overlayBlurOpacity(1),
            GalleryConfigurationItem.overlayBlurStyle(UIBlurEffectStyle.light),
            
            GalleryConfigurationItem.maximumZoolScale(8),
            GalleryConfigurationItem.swipeToDismissThresholdVelocity(500),
            
            GalleryConfigurationItem.doubleTapToZoomDuration(0.15),
            
            GalleryConfigurationItem.blurPresentDuration(0.5),
            GalleryConfigurationItem.blurPresentDelay(0),
            GalleryConfigurationItem.colorPresentDuration(0.25),
            GalleryConfigurationItem.colorPresentDelay(0),
            
            GalleryConfigurationItem.blurDismissDuration(0.1),
            GalleryConfigurationItem.blurDismissDelay(0.4),
            GalleryConfigurationItem.colorDismissDuration(0.45),
            GalleryConfigurationItem.colorDismissDelay(0),
            
            GalleryConfigurationItem.itemFadeDuration(0.3),
            GalleryConfigurationItem.decorationViewsFadeDuration(0.15),
            GalleryConfigurationItem.rotationDuration(0.15),
            
            GalleryConfigurationItem.displacementDuration(0.55),
            GalleryConfigurationItem.reverseDisplacementDuration(0.25),
            GalleryConfigurationItem.displacementTransitionStyle(.springBounce(0.7)),
            GalleryConfigurationItem.displacementTimingCurve(.linear),
            
            GalleryConfigurationItem.statusBarHidden(true),
            GalleryConfigurationItem.displacementKeepOriginalInPlace(false),
            GalleryConfigurationItem.displacementInsetMargin(50)
        ]
    }
    
}

// Some external custom UIImageView we want to show in the gallery
class FLSomeAnimatedImage: UIImageView {
}
