//
//  ViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import Foundation
import UIKit
import FirebaseAuth

class ViewController: UIViewController {

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
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goButton: UIButton!
    
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

