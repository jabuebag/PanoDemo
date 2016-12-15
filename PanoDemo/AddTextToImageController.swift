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
    
    var addLabel: UILabel!
    
    // for track the gesture distance
    var xFromCenter: CGFloat = 0
    var initAngleRadian: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init UIImage
        let image = UIImage(named: "addTextImage.jpg")!
        testImg.image = image
        
        // add label
        print(testImg.frame.midX)
        addLabel = UILabel(frame: CGRect(x: testImg.frame.size.width/2 - 100, y: testImg.frame.size.height/2 - 50, width: 100, height: 50))
        addLabel.font = addLabel.font.withSize(30)
        addLabel.backgroundColor = UIColor.clear
        addLabel.textAlignment = .center
        addLabel.textColor = UIColor.red
        addLabel.text = "Here"
        addLabel.layer.borderColor = UIColor.black.cgColor
        addLabel.layer.borderWidth = 1.0
        addLabel.layer.cornerRadius = 8
        self.testImg.addSubview(addLabel)
        
        // add scale button
        let scaleButton = UIButton(frame: CGRect(x: addLabel.bounds.size.width - 11, y: addLabel.bounds.size.height - 11, width: 10, height: 10))
        scaleButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
        scaleButton.backgroundColor = UIColor.black
        addLabel.addSubview(scaleButton)
        
        // add rotate button
        let rotateButton = UIButton(frame: CGRect(x: addLabel.bounds.size.width - 12, y: 0, width: 10, height: 10))
        rotateButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
        rotateButton.backgroundColor = UIColor.gray
        addLabel.addSubview(rotateButton)
        
        // recognizer for the label dragging move
        let labelGesture = UIPanGestureRecognizer(target: self, action: #selector(labelDragAction(gesture:)))
        addLabel.addGestureRecognizer(labelGesture)
        testImg.isUserInteractionEnabled = true
        addLabel.isUserInteractionEnabled = true
        
        // scale button gesture
        let scaleGesture = UIPanGestureRecognizer(target: self, action: #selector(buttonScaleAction(gesture:)))
        scaleButton.addGestureRecognizer(scaleGesture)
        scaleButton.isUserInteractionEnabled = true
        
        // rotate button gesture
        let rotateGesture = UIPanGestureRecognizer(target: self, action: #selector(buttonRotateAction(gesture:)))
        rotateButton.addGestureRecognizer(rotateGesture)
        rotateButton.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func processBtnAction(_ sender: Any) {
        generatedImg.image = generateImageWithText(imageView: testImg, label: addLabel)
    }
    
    func generateImageWithText(imageView: UIImageView, label: UILabel) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
        var context = UIGraphicsGetCurrentContext()
        imageView.layer.render(in: context!)
        
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
    func labelDragAction(gesture: UIPanGestureRecognizer) {
        // label.transform = label.transform.rotated(by: CGFloat.pi * 45 / 180)
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            var label = gesture.view!
            let translation = gesture.translation(in: self.testImg)
            label.transform = label.transform.translatedBy(x: translation.x, y: translation.y)
            gesture.setTranslation(CGPoint(x: 0,y :0), in: self.testImg)
        }
    }
    
    func buttonScaleAction(gesture: UIPanGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            var xScaleRate: CGFloat!
            var yScaleRate: CGFloat!
            let transition = gesture.translation(in: self.testImg)
            xScaleRate = (addLabel.frame.size.width + transition.x)/addLabel.frame.size.width
            yScaleRate = (addLabel.frame.size.height + transition.y)/addLabel.frame.size.height
            addLabel.transform = addLabel.transform.scaledBy(x: xScaleRate, y: yScaleRate)
            gesture.setTranslation(CGPoint(x: 0,y :0), in: self.testImg)
        }
    }
    
    func buttonRotateAction(gesture: UIPanGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.began) {
            let firstLocation = gesture.location(in: self.testImg)
            initAngleRadian = CGFloat(atan2f(Float(CGFloat(firstLocation.y - addLabel.frame.midY)), Float(firstLocation.x - addLabel.frame.midX)));
        }
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            let changeLocation = gesture.location(in: self.testImg)
            var angle = atan2f(Float(CGFloat(changeLocation.y - addLabel.frame.midY)), Float(changeLocation.x - addLabel.frame.midX));
            addLabel.transform = addLabel.transform.rotated(by: (CGFloat(angle) - CGFloat(initAngleRadian)))
            initAngleRadian = CGFloat(angle)
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
