//
//  ViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import Foundation
import UIKit
import Firebase
import SwiftGifOrigin

class RegisteringViewController: UIViewController {
    
    //MARK: -Usefull var
    var handle: AuthStateDidChangeListenerHandle?
    
    
    //MARK: -@IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var wrongEmailLabel: UILabel!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    
    
    
    //MARK: -ViewController life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage.gif(url: "https://cutewallpaper.org/21/anime-scenery-cherry-blossoms/Anime-Cherry-Blossom-Cute-Wallpaper-Ryanmartinproductions.com.gif")
        self.navigationItem.hidesBackButton = true
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisteringViewController.dismissKeyboard))
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
    
    
    //MARK: -@IBAction
    @IBAction func goButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        dismissKeyboard()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        checkCredentials(email, password)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        dismissKeyboard()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInIfHaveAccountViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }
    
    
    //MARK: -@objc functions
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
    
    
    //MARK: -functions
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        goButton.isHidden = shown
    }
    
    fileprivate func connect(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.toggleActivityIndicator(shown: false)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInIfHaveAccountViewController") as? SignUpViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                self.wrongEmailLabel.isHidden = true
                self.wrongPasswordLabel.isHidden = true
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            } else {
                self.toggleActivityIndicator(shown: false)
                self.wrongEmailLabel.isHidden = false
                self.wrongEmailLabel.text = "Wrong email format please write a correct adress (Ex: test@test.com)"
            }
        }
    }
    
    fileprivate func checkCredentials(_ email: String, _ password: String) {
        if email.isEmpty == true {
            self.toggleActivityIndicator(shown: false)
            self.wrongEmailLabel.isHidden = false
            self.emailTextField.text = ""
            self.wrongEmailLabel.text = "Email can't be empty"
        } else if password.isEmpty {
            self.toggleActivityIndicator(shown: false)
            self.passwordTextField.text = ""
            self.wrongPasswordLabel.isHidden = false
            self.wrongPasswordLabel.text = "Password can't be empty"
        } else if password.count < 6 {
            self.toggleActivityIndicator(shown: false)
            
            self.passwordTextField.text = ""
            self.wrongPasswordLabel.isHidden = false
            self.wrongPasswordLabel.text = "Password must be more than 6 characters"
        } else {
            self.toggleActivityIndicator(shown: true)
            print("Passed !")
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            connect(email, password)
        }
    }
}
