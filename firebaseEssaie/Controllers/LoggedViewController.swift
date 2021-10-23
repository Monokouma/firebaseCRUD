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
        gifBackground.image = UIImage.gif(url: "https://nextshark.com/wp-content/uploads/2018/01/001.gif")
        updateLabelName()
        self.navigationItem.hidesBackButton = true
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 60
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var gifBackground: UIImageView!
    
    private func updateLabelName() {
        let username = user?.displayName
        if let username = username {
            userLabel.text = "Welcome ! \(username)"
        }
    }
    
    
    
}
