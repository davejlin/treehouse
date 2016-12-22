//
//  DetailViewController.swift
//  TodoCoreData
//
//  Created by Lin David, US-205 on 10/24/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.textField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        guard let item = item else { fatalError("Cannot show detail without an item")
        }
        
        textField.text = item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        if let item = item {
            item.text = textField.text
            DataController.sharedInstance.saveContext()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
