//
//  ChooseNameViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 22/10/2021.
//

import UIKit
import Firebase
import SwiftGifOrigin


class ChooseNameViewController: UIViewController {

    //MARK: -@IBOutlet
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    
    
    //MARK: -ViewController life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gifImage.image = UIImage.gif(url: "https://lh3.googleusercontent.com/TxZSz1tPYcR--umTqbKDJvYm3MHxcix5uIAp4TCLIveCtP6abFs8J3J09sBRveD2HRkBjbH6Sv0bk6H55TiTxJhial6uE6xTq6A96Q=w600")
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: -@IBAction
    @IBAction func usernameButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        let username = usernameField.text
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if let username = username {
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                self.toggleActivityIndicator(shown: false)
                self.presentHome()
                print(Auth.auth().currentUser?.displayName)
            }
        }
    }
    
    
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
    
    
    //MARK: -Functions
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        submitButton.isHidden = shown
    }
    
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
