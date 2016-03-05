//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

// UIKit also has foundation included
import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    init(name: String) {
        self.name = name
        
    }
    
//    to maintain same key and value with encoding and decoding
    let nameKey = "name"
    let photoKey = "photo"
    
    
//  we encode to save data (photo, text, bools) in one format (completely zibberish) in a location in the disk
    func encodeWithCoder(aCoder: NSCoder) {
        // NSCoder are objects that can move in the file system
        // encode the name
        aCoder.encodeObject(name, forKey: nameKey)
        // encode the photo
        if let thePhoto = photo{
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
//  decoder. It is required because in case we need to subclass this class, we need the right way to initialize it; swift has it optional
    required init?(coder aDecoder: NSCoder) {
        // decode and force cast the return as a string
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        // decode and force cast the return as UIImage
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    let name: String
    var photo: UIImage?
    var completed: Bool {
        return photo != nil
    }
}
