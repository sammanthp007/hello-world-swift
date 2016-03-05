//
//  AddViewController.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

// changed the name of the main controller
class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // @IBAAction - this is a method i care about when i am createing my views
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /* In adviewcontroller, I have binded the text field, followingly, to create a ScavengerHuntItem? and also binded the Done button to an unwindToList method by dragging the done button the orange marker, which is actually an exit method and we also have unwind method connect to it. The unwind method is then modified in the listviewcontroller using that unwindToList custom list
*/
    
    // This creates a weak item(stays on even after the view closes), stores the item in the text field in the weak item
    @IBOutlet weak var textField: UITextField!
    var newItem: ScavengerHuntItem?
    
    // Prepare before we close the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                newItem = ScavengerHuntItem(name: name)
            }
        }
    }
    
}

