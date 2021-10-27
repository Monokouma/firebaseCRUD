//
//  LogInIfHaveAccountViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import UIKit
import Firebase
import Foundation

class SignUpViewController: UIViewController {

    //MARK: -Usefull var
    var handle: AuthStateDidChangeListenerHandle?

    
    //MARK: -@IBOutlet
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var wrongCredentials: UILabel!
    @IBOutlet weak var gifImage: UIImageView!
    
    
    //MARK: -ViewController life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://animesher.com/orig/1/151/1514/15144/animesher.com_inspiration-japanese-background-1514485.gif")
        self.navigationItem.hidesBackButton = false
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
        var email = emailField.text!
        var password = passwordField.text!
        connect(email, password)
    }
    
    @IBAction func bckButton(_ sender: Any) {
        dismissKeyboard()
    }
    
    
    //MARK: -@objc functions
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
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
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        submitButton.isHidden = shown
    }
    
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func presentChangeName() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChooseNameViewController") as? ChooseNameViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    fileprivate func connect(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self!.toggleActivityIndicator(shown: false)
            guard let strongSelf = self else { return }
            if authResult != nil {
                print("if")
                let newUser = Auth.auth().currentUser!
                if newUser.displayName != nil {
                    self!.presentHome()
                    self!.emailField.text = ""
                    self!.passwordField.text = ""
                } else {
                    self!.presentChangeName()
                    self!.emailField.text = ""
                    self!.passwordField.text = ""
                }
            } else {
                self!.wrongCredentials.isHidden = false
                print("marche pas")
                self!.emailField.text = ""
                self!.passwordField.text = ""
            }
        }
    }
}
