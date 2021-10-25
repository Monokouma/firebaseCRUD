//
//  SettingsViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 25/10/2021.
//

import UIKit
import Firebase
import SwiftGifOrigin

class SettingsViewController: UIViewController {

    
    //MARK: -@IBOutlet
    @IBOutlet weak var changeEmailField: UITextField!
    @IBOutlet weak var changePasswordField: UITextField!
    @IBOutlet weak var changeUsernameField: UITextField!
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var emailErrorOrSuccess: UILabel!
    @IBOutlet weak var passwordErrorOrSuccess: UILabel!
    @IBOutlet weak var usernameErrorOrSuccess: UILabel!
    
    
    //MARK: -Life cycle controller
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://c.tenor.com/vVPZh-hkPDYAAAAd/sad-japan.gif")
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MRK: -@IBAction
    @IBAction func updateEmailButton(_ sender: UIButton) {
        dismissKeyboard()
        if let newEmail = changeEmailField.text {
            if newEmail.isEmpty == true {
                self.emailErrorOrSuccess.isHidden = false
            } else {
                updateEmail(newEmail)
            }
        }
    }
    
    @IBAction func updatePasswordButton(_ sender: UIButton) {
        dismissKeyboard()
        if let newPassword = changePasswordField.text {
            if newPassword.isEmpty == true || newPassword.count < 6 {
                self.passwordErrorOrSuccess.isHidden = false
            } else {
                updatePassword(newPassword)
            }
        }
    }
    
    @IBAction func updateDisplayName(_ sender: UIButton) {
        dismissKeyboard()
        if let newName = changeUsernameField.text {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = newName
            if newName.isEmpty == true {
                self.usernameErrorOrSuccess.isHidden = false
            } else {
                updateUsername(changeRequest, newName)
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
            print("Error")
          } else {
              print("Delete")
          }
        }
    }
    
    @IBAction func backHomeButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //MARK: -@objc func
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    //MARK: -Functions
    fileprivate func updateEmail(_ newEmail: String) {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
            self.changeEmailField.text = ""
            self.emailErrorOrSuccess.text = "New email address saved !"
            self.emailErrorOrSuccess.textColor = .green
            self.emailErrorOrSuccess.isHidden = false
        }
    }
    
    fileprivate func updatePassword(_ newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            print("New password is : \(newPassword)")
            self.changePasswordField.text = ""
            self.passwordErrorOrSuccess.text = "Password changed successfully"
            self.passwordErrorOrSuccess.textColor = .green
            self.passwordErrorOrSuccess.isHidden = false
        }
    }
    
    fileprivate func updateUsername(_ changeRequest: UserProfileChangeRequest?, _ newName: String) {
        changeRequest?.commitChanges(completion: { error in
            print("Name changed")
            self.changeUsernameField.text = ""
            self.usernameErrorOrSuccess.text = "New username : \(newName)"
            self.usernameErrorOrSuccess.textColor = .green
            self.usernameErrorOrSuccess.isHidden = false
        })
    }
}
