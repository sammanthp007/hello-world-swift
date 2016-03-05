//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

// UIKit also has foundation included
import UIKit

class ScavengerHuntItem: NSObject {
    init(name: String) {
        self.name = name
        
    }
    let name: String
    var photo: UIImage?
    var completed: Bool {
        return photo != nil
    }
}
