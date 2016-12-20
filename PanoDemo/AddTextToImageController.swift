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
    var rotateScaleView: UIView!
    var scaleButton: UIButton!
    var rotateButton: UIButton!
    
    // for track the gesture distance
    var xFromCenter: CGFloat = 0
    var initAngleRadian: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init UIImage
        testImg.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.width * 2/3)
        let image = UIImage(named: "addTextImage.jpg")!
        testImg.image = image
        
        // init processBtn
        processBtn.center = self.view.center
        
        // init generatedImg
        generatedImg.frame = CGRect(x: 0, y: self.view.center.y + 60, width: testImg.frame.width, height: testImg.frame.height)
        
        rotateScaleView = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 70))
        rotateScaleView.backgroundColor = UIColor.brown
        rotateScaleView.center.x = testImg.center.x
        rotateScaleView.center.y = testImg.center.y - testImg.frame.minY
        self.testImg.addSubview(rotateScaleView)
        
        // add label
        addLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 150, height: 50))
        addLabel.font = addLabel.font.withSize(30)
        addLabel.numberOfLines = 0
        addLabel.backgroundColor = UIColor.clear
        addLabel.textAlignment = .center
        addLabel.baselineAdjustment = .alignCenters
        addLabel.textColor = UIColor.red
        addLabel.text = "Add Text"
        addLabel.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        addLabel.layer.borderWidth = 1.5
        addLabel.adjustsFontSizeToFitWidth = true
        // addLabel.minimumScaleFactor = 0.5
        self.rotateScaleView.addSubview(addLabel)
        
        // add scale button
        scaleButton = UIButton(frame: CGRect(x: rotateScaleView.bounds.size.width - 20, y: rotateScaleView.bounds.size.height - 20, width: 20, height: 20))
        scaleButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
        scaleButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        rotateScaleView.addSubview(scaleButton)
        
        // add rotate button
        rotateButton = UIButton(frame: CGRect(x: rotateScaleView.bounds.size.width - 20, y: 0, width: 20, height: 20))
        rotateButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
        rotateButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        rotateScaleView.addSubview(rotateButton)
        
        // recognizer for the label dragging move
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(labelDragAction(gesture:)))
        rotateScaleView.addGestureRecognizer(dragGesture)
        testImg.isUserInteractionEnabled = true
        rotateScaleView.isUserInteractionEnabled = true
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
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            var view = gesture.view!
            let translation = gesture.translation(in: self.view)
            let dragLocation = gesture.location(in: self.view)
            if (dragLocation.x < testImg.frame.maxX && dragLocation.y < testImg.frame.maxY) {
                let translate = CGAffineTransform(translationX: translation.x, y: translation.y)
                view.transform = view.transform.concatenating(translate)
                gesture.setTranslation(CGPoint(x: 0,y :0), in: self.view)
            }
        }
    }
    
    func buttonScaleAction(gesture: UIPanGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            var scaleRate: CGFloat!
            let transition = gesture.translation(in: self.view)
            scaleRate = (rotateScaleView.frame.size.width + transition.x)/rotateScaleView.frame.size.width
            if (scaleRate > 1) {
                rotateScaleView.transform = rotateScaleView.transform.scaledBy(x: scaleRate, y: scaleRate)
                addLabel.layer.borderWidth = addLabel.layer.borderWidth/scaleRate
                scaleButton.bounds.size.width = scaleButton.bounds.size.width/scaleRate
                scaleButton.bounds.size.height = scaleButton.bounds.size.height/scaleRate
                scaleButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
                rotateButton.bounds.size.width = rotateButton.bounds.size.width/scaleRate
                rotateButton.bounds.size.height = rotateButton.bounds.size.height/scaleRate
                rotateButton.layer.cornerRadius = 0.5 * rotateButton.bounds.size.width
            } else {
                if (rotateScaleView.frame.size.width > 90) {
                    rotateScaleView.transform = rotateScaleView.transform.scaledBy(x: scaleRate, y: scaleRate)
                    addLabel.layer.borderWidth = addLabel.layer.borderWidth/scaleRate
                    scaleButton.bounds.size.width = scaleButton.bounds.size.width/scaleRate
                    scaleButton.bounds.size.height = scaleButton.bounds.size.height/scaleRate
                    scaleButton.layer.cornerRadius = 0.5 * scaleButton.bounds.size.width
                    rotateButton.bounds.size.width = rotateButton.bounds.size.width/scaleRate
                    rotateButton.bounds.size.height = rotateButton.bounds.size.height/scaleRate
                    rotateButton.layer.cornerRadius = 0.5 * rotateButton.bounds.size.width
                }
            }
            gesture.setTranslation(CGPoint(x: 0,y :0), in: self.view)
        }
    }
    
    func buttonRotateAction(gesture: UIPanGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.began) {
            let firstLocation = gesture.location(in: self.view)
            initAngleRadian = CGFloat(atan2f(Float(CGFloat(firstLocation.y - rotateScaleView.frame.midY)), Float(firstLocation.x - rotateScaleView.frame.midX)));
        }
        if (gesture.state == UIGestureRecognizerState.changed ||
            gesture.state == UIGestureRecognizerState.ended) {
            let changeLocation = gesture.location(in: self.view)
            var angle = atan2f(Float(CGFloat(changeLocation.y - rotateScaleView.frame.midY)), Float(changeLocation.x - rotateScaleView.frame.midX));
            // addLabel.transform = addLabel.transform.scaledBy(x: xScaleRate, y: yScaleRate)
            rotateScaleView.transform = rotateScaleView.transform.rotated(by: (CGFloat(angle) - CGFloat(initAngleRadian)))
            gesture.setTranslation(CGPoint(x: 0,y :0), in: self.view)
            initAngleRadian = CGFloat(angle)
        }
    }
}
