//
//  PanoModel.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-25.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class PanoModel {
    
    var name: String
    var originImg: UIImage?
    var processedImg: UIImage?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, originImg: UIImage) {
        self.name = name
        self.originImg = originImg
    }
    
    init(name: String, originImg: UIImage, processedImg: UIImage) {
        self.name = name
        self.originImg = originImg
        self.processedImg = processedImg
    }
}
