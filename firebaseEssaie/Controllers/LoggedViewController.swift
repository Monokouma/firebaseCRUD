//
//  LoggedViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 19/10/2021.
//

import UIKit
import Firebase
import Foundation

class LoggedViewController: UIViewController {

    private let user = Auth.auth().currentUser
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifBackground.image = UIImage.gif(url: "https://nextshark.com/wp-content/uploads/2018/01/001.gif")
        updateLabelName()
        self.navigationItem.hidesBackButton = true
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
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
    
    @IBOutlet weak var changeEmailField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var deleteIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gifBackground: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    private func updateLabelName() {
        let username = user?.email
        if let username = username {
            userLabel.text = "Welcome ! \(username)"
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        submitButton.isHidden = shown
    }
    
    private func toggleDeleteIndicator(show: Bool) {
        deleteIndicator.isHidden = !show
        deleteButton.isHidden = show
    }
    

    @IBAction func changeEmailButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        var email: String = ""
        if let unwrappedField = changeEmailField.text {
            email = unwrappedField
        }
        
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            self.toggleActivityIndicator(shown: false)
            if error == nil {
                self.changeEmailField.text = ""
                self.userLabel.text = "Welcome ! \(String(describing: self.user!.email!))"
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        toggleDeleteIndicator(show: true)
        user?.delete(completion: { error in
            if let error = error {
                print("errkr")
            } else {
                self.toggleDeleteIndicator(show: false)
                print("account delete")
            }
        })
    }
    
    @IBAction func goAwayButtonTapped(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BackgroundViewController") as? BackgroundViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func backToRegister(_ sender: Any) {
    }
    
}
