//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit


// this is going to run because of delegation -> which is smt like a event triggered paradigm
class ListViewController : UITableViewController {
    // make an array of items, this is my data source
    var itemsList = [
        ScavengerHuntItem(name: "Cat"),
        ScavengerHuntItem(name: "Bird"),
        ScavengerHuntItem(name: "Brick")
        
    ]
    
    // numberofRowsInSection for letting the data source know how many rows we need
    // get the number of rows in the mentioned section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of items in your itemsList i.e your story board in this case
        return itemsList.count
    }
    
    // change the cellForRowAtIndexPath with a cell from dequeueReusableCellWithIdentifier
    
    // the queue is only taking the strucuture of the cell and not the text. so we just take that cell and then later put our data again, thats why we set the text of the cell imediately after getting the cell
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get me a cell with that particular index path with that particular class name
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        // set the cells text/label as the text from my data source; question mark means optional
        let item = itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        return cell

    }
    
    
    // we have set the action of our segue to be unwindToList, so this is that function
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            // get the name of the source view from which the segue originated
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem {
                itemsList += [newItem]
//                why are we doing this?
                let indexPath = NSIndexPath(forRow: itemsList.count - 1, inSection: 0)
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