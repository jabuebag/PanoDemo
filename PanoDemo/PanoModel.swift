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
    var panoName: String?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, panoName: String) {
        self.name = name
        self.panoName = panoName
    }
}
