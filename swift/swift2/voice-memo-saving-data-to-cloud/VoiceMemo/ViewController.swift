//
//  ViewController.swift
//  VoiceMemo
//
//  Created by Pasan Premaratne on 8/23/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.registerClass(MemoCell.self, forCellReuseIdentifier: MemoCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var recordButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Record", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.startRecording), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Stop", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.stopRecording), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Hidden initially. Appears after the record button is tapped
        button.hidden = true
        
        return button
    }()
    
    // MARK: - Audio Properties
    let sessionManager = MemoSessionManager.sharedInstance
    let recorder = MemoRecorder.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        let headerView = UIView()
        headerView.backgroundColor = .blackColor()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(recordButton)
        headerView.addSubview(stopButton)
        
        NSLayoutConstraint.activateConstraints([
            headerView.heightAnchor.constraintEqualToConstant(120.0),
            headerView.centerXAnchor.constraintEqualToAnchor(recordButton.centerXAnchor),
            headerView.centerYAnchor.constraintEqualToAnchor(recordButton.centerYAnchor),
            headerView.centerXAnchor.constraintEqualToAnchor(stopButton.centerXAnchor),
            headerView.centerYAnchor.constraintEqualToAnchor(stopButton.centerYAnchor)
            ])
        
        let stackView = UIStackView(arrangedSubviews:  [headerView, tableView])
        stackView.axis = .Vertical
        stackView.alignment = .Center
        stackView.distribution = .EqualSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activateConstraints([
            view.leftAnchor.constraintEqualToAnchor(stackView.leftAnchor),
            self.topLayoutGuide.bottomAnchor.constraintEqualToAnchor(stackView.topAnchor),
            view.rightAnchor.constraintEqualToAnchor(stackView.rightAnchor),
            view.bottomAnchor.constraintEqualToAnchor(stackView.bottomAnchor),
            // Header View
            headerView.rightAnchor.constraintEqualToAnchor(stackView.rightAnchor),
            headerView.leftAnchor.constraintEqualToAnchor(stackView.leftAnchor),
            headerView.bottomAnchor.constraintEqualToAnchor(tableView.topAnchor),
            // Table View
            tableView.rightAnchor.constraintEqualToAnchor(stackView.rightAnchor),
            tableView.leftAnchor.constraintEqualToAnchor(stackView.leftAnchor)
            ])
    }
    
    @objc func startRecording() {
        toggleRecordButton(on: false)
        
        if !sessionManager.permissionGranted {
            sessionManager.requestPermission { permissionAllowed in
                if !permissionAllowed {
                    self.displayInsufficientPermissionsAlert()
                }
            }
        }
        
        recorder.start()
    }
    
    @objc func stopRecording() {
        toggleRecordButton(on: true)
        let outputURLString = recorder.stop()
        
        presentSaveMemoAlertController { title in
            let memo = Memo(id: nil, title: title, fileURLString: outputURLString)
            self.save(memo) 
        }
    }
    
    private func toggleRecordButton(on flag: Bool) {
        recordButton.hidden = !flag
        stopButton.hidden = flag
    }
    
    private func displayInsufficientPermissionsAlert() {
        let alertController = UIAlertController(title: "Insufficient Permissions!", message: "Cannot record without permission", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func presentSaveMemoAlertController(completion: String -> Void) {
        let alertController = UIAlertController(title: "Save Memo", message: nil, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.text = "New Memo"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { alertAction in
            guard let title = alertController.textFields?.first?.text else {
                let timestamp = NSDate().timeIntervalSince1970
                let title = "Memo_\(timestamp)"
                
                completion(title)
                return
            }
            
            completion(title)
        }
        alertController.addAction(saveAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func save(memo: Memo) {
        
    }
}

















