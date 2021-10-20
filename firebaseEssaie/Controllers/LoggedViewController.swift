//
//  LoggedViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import UIKit
import Firebase
import Foundation

class LoggedViewController: UIViewController {

    private let user = Auth.auth().currentUser
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabelName()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBOutlet weak var changeEmailField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deleteIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    private func updateLabelName() {
        let username = user?.email
        if let username = username {
            userLabel.text = "Welcome ! \(username)"
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        submitButton.isHidden = shown
    }
    
    private func toggleDeleteIndicator(show: Bool) {
        deleteIndicator.isHidden = !show
        deleteButton.isHidden = show
    }
    

    @IBAction func changeEmailButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        var email: String = ""
        if let unwrappedField = changeEmailField.text {
            email = unwrappedField
        }
        
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            self.toggleActivityIndicator(shown: false)
            if error == nil {
                self.changeEmailField.text = ""
                self.userLabel.text = "Welcome ! \(String(describing: self.user!.email!))"
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        toggleDeleteIndicator(show: true)
        user?.delete(completion: { error in
            if let error = error {
                print("errkr")
            } else {
                self.toggleDeleteIndicator(show: false)
                print("account delete")
            }
        })
    }
}
