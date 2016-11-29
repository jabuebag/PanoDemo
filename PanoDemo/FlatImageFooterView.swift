//
//  FlatImageFooterView.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-29.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureLabel()
        updateLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        
        countLabel.textAlignment = .center
        self.addSubview(countLabel)
    }
    
    func updateLabel() {
        
        let countString = "test"
        
        countLabel.attributedText = NSAttributedString(string: countString, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17), NSForegroundColorAttributeName: UIColor.white])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countLabel.frame = self.bounds
    }
}
