//
//  AddTextToImageController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-12-13.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class AddTextToImageController: UIViewController {
    
    @IBOutlet weak var testImg: UIImageView!
    @IBOutlet weak var generatedImg: UIImageView!
    @IBOutlet weak var processBtn: UIButton!
    
    var label: UILabel!
    
    // for track the gesture distance
    var xFromCenter: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(testImg.frame.origin.x)
        
        let image = UIImage(named: "addTextImage.jpg")!
        testImg.image = image
        
        label = UILabel(frame: CGRect(x: testImg.frame.origin.x, y: testImg.frame.origin.y, width: testImg.bounds.size.width/2, height: testImg.bounds.size.height/2))
        label.font = label.font.withSize(30)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.red
        label.text = "Here is the TEXT!"
        self.view.addSubview(label)
        label.transform = label.transform.rotated(by: CGFloat.pi * 45 / 180)
        label.transform = label.transform.scaledBy(x: 1.2, y: 1.2)
        label.transform = label.transform.translatedBy(x: 20, y: 20)
        
        // recognizer for the dragging move
        var gesture = UIPanGestureRecognizer(target: self, action: #selector(dragAction(gesture:)))
        // get a lot of event all the drag gesture's path
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        // testImg.image = generateImageWithText(imageView: imageView, label: label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func processBtnAction(_ sender: Any) {
        generatedImg.image = generateImageWithText(imageView: testImg, label: label)
    }
    
    func generateImageWithText(imageView: UIImageView, label: UILabel) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
        var context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        imageView.layer.render(in: context!)
        // context!.translateBy(x: label.frame.origin.x, y: label.frame.origin.y - imageView.frame.origin.y)
        context!.concatenate(label.transform)
        label.layer.render(in: context!)
        context!.restoreGState()
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
    func dragAction(gesture: UIPanGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            var label = gesture.view!
            let translation = gesture.translation(in: self.testImg)
//            var newFrame = label.frame
//            newFrame.origin.x += translation.x
//            newFrame.origin.y += translation.y
//            label.frame = newFrame
            label.transform = label.transform.translatedBy(x: translation.x, y: translation.y)
            gesture.setTranslation(CGPoint(x: 0,y :0), in: self.testImg)
        }
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        // translation vector origin -> destination
        
        let translation = gesture.translation(in: self.testImg) // get the translation
        var label = gesture.view! // the view inside the gesture
        
        xFromCenter += translation.x
        
        var scaledValue = min(100 / abs(xFromCenter), 1)
        
        // move the label with the translation
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        
        // reset the translation that now, is already applied to the label
        gesture.setTranslation(CGPoint(x: 0,y :0), in: self.testImg)
        
        
        // the rotation variable clockwise and pass the angle in radians 1 = 60º
        var rotation:CGAffineTransform = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        // the scale variable to enlarge objects
        var stretch:CGAffineTransform = rotation.scaledBy(x: scaledValue, y: scaledValue)
        
        label.transform = stretch
        
        
        if label.center.x < 100 {
            
            print("Not chosen !!")
            
        } else if label.center.x > self.view.bounds.width - 100 {
            
            print("Chosen !!")
        }
        
        if gesture.state == UIGestureRecognizerState.ended {
            
            // restore the inital value before drag the item
            label.center = CGPoint(x: self.testImg.bounds.width / 2, y: self.testImg.bounds.height / 2)
            scaledValue = min(abs(xFromCenter)/100, 1)
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: scaledValue, y: scaledValue)
            
            label.transform = stretch
        }
        
    }
}
