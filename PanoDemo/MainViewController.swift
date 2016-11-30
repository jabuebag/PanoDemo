//
//  MainViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-25.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit
import ImageViewer

// extension UIImageView: DisplaceableView {}

class MainViewController: UIViewController, GalleryItemsDatasource, GalleryDisplacedViewsDatasource, UITableViewDelegate, UITableViewDataSource {
    
    var panoArray: [PanoModel] = []
    var panoImageViewArray: [UIImageView] = []
    
    var tapedImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        var officePano = PanoModel(name: "office.jpg", panoName: "officePro.jpg")
        var diningPano = PanoModel(name: "dining.jpg", panoName: "dining.jpg")
        panoArray.append(officePano)
        panoArray.append(diningPano)
        
        //var officeUIImgView = UIImageView(image: UIImage(named: "office.jpg"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return panoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PanoCell", for: indexPath) as! MainTableViewCell
        cell.panoImg.image = UIImage(named: panoArray[indexPath.row].name)
        cell.panoModel = panoArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let touchedCell = tableView.cellForRow(at: indexPath) as? MainTableViewCell
        tapedImageView = touchedCell?.panoImg
        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        let footerView = CounterView(frame: frame, panoModel: (touchedCell?.panoModel)!)
        let galleryViewController = GalleryViewController(startIndex: 0, itemsDatasource: self, displacedViewsDatasource: self, configuration: galleryConfiguration())
        galleryViewController.footerView = footerView
        footerView.controller = galleryViewController
        self.presentImageGallery(galleryViewController)
    }
    
    func itemCount() -> Int {
        
        return 1
    }
    
    func provideDisplacementItem(atIndex index: Int) -> DisplaceableView? {
        
        return tapedImageView
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let image = tapedImageView?.image ?? UIImage(named: "0")!
        
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
