//
//  ViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import SwiftGifOrigin

class ViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImage.image = UIImage.gif(url: "https://cutewallpaper.org/21/anime-scenery-cherry-blossoms/Anime-Cherry-Blossom-Cute-Wallpaper-Ryanmartinproductions.com.gif")
        self.navigationItem.hidesBackButton = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            //print(auth)
            //print(user)
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
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var wrongEmailLabel: UILabel!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        goButton.isHidden = shown
    }
    
    @IBAction func goButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        var email = emailTextField.text!
        var password = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.toggleActivityIndicator(shown: false)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInIfHaveAccountViewController") as? LogInIfHaveAccountViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        
        print(email)
        print(password)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInIfHaveAccountViewController") as? LogInIfHaveAccountViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}

