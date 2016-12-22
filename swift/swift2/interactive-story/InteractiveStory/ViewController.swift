//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Lin David, US-205 on 9/23/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextFieldToStartAdventureVerticalContraint: NSLayoutConstraint!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    enum Error: ErrorType {
        case NoName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyBoardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyBoardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" {
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw Error.NoName
                    }
                    
                    if let pageController = segue.destinationViewController as? PageController {
                        pageController.page = Adventure.story(name)
                    }
                }
            } catch Error.NoName {
                let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start your story!", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
                
                presentViewController(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    
    func keyBoardWillShow(notification: NSNotification) {
        if let userInfoDictionary = notification.userInfo, let keyboardFrameValue = userInfoDictionary[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.CGRectValue()
            
            UIView.animateWithDuration(0.8) {
                self.nameTextFieldToStartAdventureVerticalContraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.8) {
            self.nameTextFieldToStartAdventureVerticalContraint.constant = 25
            self.view.layoutIfNeeded()
        }
    }
    

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

