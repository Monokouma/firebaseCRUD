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

    //MARK: -Usefull var
    private let user = Auth.auth().currentUser
    private var handle: AuthStateDidChangeListenerHandle?
    
    
    //MARK: -@IBOutlet
    @IBOutlet weak var disconnectButtonOutlet: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var gifBackground: UIImageView!
    
    
    //MARK: -Life cycle controller
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
    
   
    //MARK: -@IBAction
    @IBAction func settingsButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func disconnectButton(_ sender: UIButton) {
        do {
        try! Auth.auth().signOut()
        print(Auth.auth().currentUser)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        } catch {
            print("error")
        }
    }
    
    
    //MARK: -@Objc Functions
    @objc func dismissKeyboard() {
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
    
    
    //MARK: -Function
    private func updateLabelName() {
        let username = user?.displayName
        if let username = username {
            userLabel.text = "Welcome ! \(username)"
        }
    }
}
