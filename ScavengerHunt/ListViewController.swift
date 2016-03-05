//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit


// this is going to run because of delegation -> which is smt like a event triggered paradigm
class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // make an array of items, this is my data source
    let myManager = ItemsManager()
    
    // for getting camera
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        // because we are using simulater, we don't have a camera so we have this branching
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        // who can answer all the delegate question: this same class
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // if we tap a cell
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
            dismissViewControllerAnimated(true, completion: { () -> Void in
                // we use self in here explicitely and not in other cases because we are in a block of the class
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    // camera work ends
    
    // numberofRowsInSection for letting the data source know how many rows we need
    // get the number of rows in the mentioned section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of items in your itemsList i.e your story board in this case
        return myManager.itemsList.count
    }
    
    // change the cellForRowAtIndexPath with a cell from dequeueReusableCellWithIdentifier
    
    // the queue is only taking the strucuture of the cell and not the text. so we just take that cell and then later put our data again, thats why we set the text of the cell imediately after getting the cell
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get me a cell with that particular index path with that particular class name
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        // set the cells text/label as the text from my data source; question mark means optional
        let item = myManager.itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        if (item.completed) {
            // add check if we are complete
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            // for loading items in case we had the accessories and image set for not checked items
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        return cell

    }
    
    // get the dat from textbox and save it
    // we have set the action of our segue to be unwindToList, so this is that function
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            // get the name of the source view from which the segue originated
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem {
                myManager.itemsList += [newItem]
                // save
                myManager.save()
//                why are we doing this?
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
}

/* process runs by
get the section number (default = 1)
get the index number for the section (default = 1)
using the recyclable queue -> put the leaving cell in the queue
then the section number and index number are put in indexPath which is a struct

*/