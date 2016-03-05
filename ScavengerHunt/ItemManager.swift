//
//  ItemManager.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import Foundation

// write those items to disks, and read
class ItemsManager {
    var itemsList = [ScavengerHuntItem]() //mutable array
    
    // returns the file path
    func archivePath() -> String? {
        // .DocumentDirectory is one of the directories within the app sandbox, anywhere, .UserDomainMask legacy stuff for other users loacation access
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/ScavengerHuntItems"
        }
        // just crash the program with that error
        assertionFailure("Could not determine where to save file.")
        return nil
    }

    //
    func save() {
        // calls the above function to get the path of our file and then archives the array to the file
        if let theArchivePath = archivePath() {
            // archive (means save it) to the file
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath) {
                print ("Saved successfully")
            } else {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
        }
    }

    
    init() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                // force cast the return type as an array of ScavengerHuntItem
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
}