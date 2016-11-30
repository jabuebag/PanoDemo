//
//  FlatImageFooterView.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-29.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    let vrBtn = UIButton()
    var panoModel: PanoModel?
    var controller: UIViewController?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureBtn()
        updateBtn()
        
        vrBtn.addTarget(self, action: #selector(vrAction), for: .touchUpInside)
    }
    
    init(frame: CGRect, panoModel: PanoModel) {
        super.init(frame: frame)
        
        self.panoModel = panoModel
        
        configureBtn()
        updateBtn()
        
        vrBtn.addTarget(self, action: #selector(vrAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBtn() {
        
        self.addSubview(vrBtn)
    }
    
    func updateBtn() {
        
        vrBtn.setTitle("vr", for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        vrBtn.frame = self.bounds
    }
    
    func vrAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sphereView: SphereViewController = storyboard.instantiateViewController(withIdentifier: "SphereViewController") as! SphereViewController
        sphereView.panoModel = self.panoModel
        controller?.present(sphereView, animated: true, completion: nil)
    }
}
