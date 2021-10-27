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
    //Text Field
    @IBOutlet weak var changeEmailField: UITextField!
    @IBOutlet weak var changePasswordField: UITextField!
    @IBOutlet weak var changeUsernameField: UITextField!
    //ImageView
    @IBOutlet weak var gifImage: UIImageView!
    //Label
    @IBOutlet weak var emailErrorOrSuccess: UILabel!
    @IBOutlet weak var passwordErrorOrSuccess: UILabel!
    @IBOutlet weak var usernameErrorOrSuccess: UILabel!
    //ActivityIndicator
    @IBOutlet weak var emailActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var deleteActivityIndicator: UIActivityIndicatorView!
    //Button
    @IBOutlet weak var emailButtonOutlet: UIButton!
    @IBOutlet weak var updateUsernameButton: UIButton!
    @IBOutlet weak var passwordButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    
    
    //MARK: -Life cycle controller
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://c.tenor.com/vVPZh-hkPDYAAAAd/sad-japan.gif")
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisteringViewController.dismissKeyboard))
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
                self.toggleActivityIndicatorEmail(shown: false)
            } else {
                updateEmail(newEmail)
                self.toggleActivityIndicatorEmail(shown: true)
            }
        }
    }
    
    @IBAction func updatePasswordButton(_ sender: UIButton) {
        dismissKeyboard()
        toggleActivityIndicatorPassword(shown: true)
        if let newPassword = changePasswordField.text {
            if newPassword.isEmpty == true || newPassword.count < 6 {
                self.passwordErrorOrSuccess.isHidden = false
                self.toggleActivityIndicatorPassword(shown: false)
            } else {
                updatePassword(newPassword)
                self.toggleActivityIndicatorPassword(shown: true)
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
                self.toggleActivityIndicatorUsername(shown: false)
            } else {
                updateUsername(changeRequest, newName)
                self.toggleActivityIndicatorUsername(shown: true)
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        toggleActivityIndicatorDelete(shown: true)
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
            print("Error")
          } else {
            print("Delete")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.toggleActivityIndicatorDelete(shown: false)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisteringViewController") as? RegisteringViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
          }
        }
    }
    
    @IBAction func backHomeButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func changeAvatarButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AvatarViewController") as? AvatarViewController
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
            self.toggleActivityIndicatorEmail(shown: false)
        }
    }
    
    fileprivate func updatePassword(_ newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            print("New password is : \(newPassword)")
            self.changePasswordField.text = ""
            self.passwordErrorOrSuccess.text = "Password changed !"
            self.passwordErrorOrSuccess.textColor = .green
            self.passwordErrorOrSuccess.isHidden = false
            self.toggleActivityIndicatorPassword(shown: false)
        }
    }
    
    fileprivate func updateUsername(_ changeRequest: UserProfileChangeRequest?, _ newName: String) {
        changeRequest?.commitChanges(completion: { error in
            print("Name changed")
            self.changeUsernameField.text = ""
            self.usernameErrorOrSuccess.text = "New username : \(newName)"
            self.usernameErrorOrSuccess.textColor = .green
            self.usernameErrorOrSuccess.isHidden = false
            self.toggleActivityIndicatorUsername(shown: false)
        })
    }
    
    private func toggleActivityIndicatorEmail(shown: Bool) {
        emailActivityIndicator.isHidden = !shown
        emailButtonOutlet.isHidden = shown
    }
    
    private func toggleActivityIndicatorPassword(shown: Bool) {
        passwordActivityIndicator.isHidden = !shown
        passwordButtonOutlet.isHidden = shown
    }
    
    private func toggleActivityIndicatorUsername(shown: Bool) {
        usernameActivityIndicator.isHidden = !shown
        updateUsernameButton.isHidden = shown
    }
    
    private func toggleActivityIndicatorDelete(shown: Bool) {
        deleteActivityIndicator.isHidden = !shown
        deleteButtonOutlet.isHidden = shown
    }
    /* /* Begin PBXResourcesBuildPhase section */
     27BF61C0271F08F90036CE9F /* Resources */ = {
         isa = PBXResourcesBuildPhase;
         buildActionMask = 2147483647;
         files = (
             270BE6932729548000B7F926 /* Media.xcassets in Resources */,
             273104382726F55600E723C2 /* pasted image 0.png in Resources */,
             2731043A2726F57C00E723C2 /* me-in-8bit.png in Resources */,
             27BF61D2271F08FB0036CE9F /* LaunchScreen.storyboard in Resources */,
             275D4D6F27284BDE0061A399 /* bdc0f3d3a06908148d59c58553bad6d98618f4ber1-1712-1712v2_128.jpg in Resources */,
             275BDD74271F0C2900C380C1 /* GoogleService-Info.plist in Resources */,
             27BF61CD271F08F90036CE9F /* Main.storyboard in Resources */,
             273104312726EFBB00E723C2 /* AppIcon.appiconset in Resources */,
             271480A82721B617001AFDDB /* 5eeea355389655.59822ff824b72.gif in Resources */,
             273104342726F4B800E723C2 /* 512x512bb.jpg in Resources */,
         );
         runOnlyForDeploymentPostprocessing = 0;
     };
/* End PBXResourcesBuildPhase section */*/
}
