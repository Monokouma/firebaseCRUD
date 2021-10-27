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
        gifImage.image = UIImage.gif(url: "https://i.pinimg.com/originals/2d/44/e9/2d44e965dff94b7aa7a51fb42f25faf8.gif")
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisteringViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: -@IBAction
    @IBAction func usernameButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        dismissKeyboard()
        let username = usernameField.text
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if let username = username {
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                self.toggleActivityIndicator(shown: false)
                self.usernameField.text = ""
                self.presentAvatar()
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
                self.view.frame.origin.y -= keyboardSize.height - 180
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
    
    private func presentAvatar() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AvatarViewController") as? AvatarViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
