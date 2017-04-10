//
//  EditWaypointViewController.swift
//  Trax
//
//  Created by Younoussa Ousmane Abdou on 4/10/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class EditWaypointViewController: UIViewController, UITextFieldDelegate {
    
    var waypointToEdit: EditableWaypoint? { didSet { updateUI() } }
    
    private func updateUI() {
        
        if nameTextField != nil && infoTextField != nil {
            nameTextField.text = waypointToEdit?.name
            infoTextField.text = waypointToEdit?.info
        }
    }
    
    // MARK: UITextField Observers
    private var ntfObserver: NSObjectProtocol?
    private var itfObserver: NSObjectProtocol?
    
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    // MARK: Actions

    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopListeningToTextFields()
    }
    
    // I create this function to avoid copying when removing observers
    private func removeObserver(observer: NSObjectProtocol?) {
        
        NotificationCenter.default.removeObserver(observer as Any)
    }
    
    // Instructor's part
    private func stopListeningToTextFields() {
        
        if let observer = ntfObserver {
            
            removeObserver(observer: observer)
        }
        
        if let observer = itfObserver {
            
            removeObserver(observer: observer)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        listenToTextField()
    }
    
    private func listenToTextField() {
        
        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main
        
        ntfObserver = center.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                         object: nameTextField,
                                         queue: mainQueue) { Notification in
                                            
                                            if let waypoint = self.waypointToEdit {
                                                waypoint.name = self.nameTextField.text
                                            }
        }
        
        itfObserver = center.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                         object: infoTextField,
                                         queue: mainQueue) { notification in
                                            
                                            if let waypoint = self.waypointToEdit {
                                                waypoint.info = self.infoTextField.text
                                            }
        }
    }
    
    // MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
