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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    @IBAction func goButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        var email = emailField.text!
        var password = passwordField.text!
        
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
                self!.presentHome()
            } else {
                print("marche pas")
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        submitButton.isHidden = shown
    }
    
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

}
