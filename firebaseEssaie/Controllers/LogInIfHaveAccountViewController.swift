//
//  LogInIfHaveAccountViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import UIKit
import Firebase
import Foundation

class LogInIfHaveAccountViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://animesher.com/orig/1/151/1514/15144/animesher.com_inspiration-japanese-background-1514485.gif")
        self.navigationItem.hidesBackButton = false
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
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
                self.view.frame.origin.y -= keyboardSize.height - 60
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var wrongCredentials: UILabel!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    
    fileprivate func connect(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self!.toggleActivityIndicator(shown: false)
            guard let strongSelf = self else { return }
            
            let user = Auth.auth().currentUser
            
            if let user = user {
                let uid = user.uid
                let email = user.email
                print(uid)
                print(email!)
            }
            if authResult != nil {
                print("if")
                let newUser = Auth.auth().currentUser!
                if newUser.displayName != nil {
                    self!.presentHome()
                } else {
                    self!.presentChangeName()
                }
                
            } else {
                self!.wrongCredentials.isHidden = false
                print("marche pas")
            }
        }
    }
    
    @IBAction func goButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        var email = emailField.text!
        var password = passwordField.text!
        
        
        
        
        connect(email, password)
    }
    
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
    
    @IBAction func bckButton(_ sender: Any) {
        
    }
    
}
