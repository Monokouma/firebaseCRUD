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
    @IBOutlet weak var gifBackground: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var creationDatelabel: UILabel!
    
    
    
    //MARK: -Life cycle controller
    override func viewDidLoad() {
        super.viewDidLoad()
        gifBackground.image = UIImage.gif(url: "https://nextshark.com/wp-content/uploads/2018/01/001.gif")
        updateLabelName()
        updateEmail()
        updateAvatar()
        updateDateLabel()
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
    @IBAction func settingsButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func disconnectButton(_ sender: UIButton) {
        do {
        try! Auth.auth().signOut()
        print(Auth.auth().currentUser)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisteringViewController") as? RegisteringViewController
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
            usernameLabel.text = username
        }
    }
    
    private func updateEmail() {
        let email = user?.email
        if let email = email {
            emailLabel.text = email
        }
    }
    
    private func updateDateLabel() {
        let date = user?.metadata
        let meta = date?.creationDate
        if let meta = meta {
            let formatter = DateFormatter()
            formatter.dateFormat = "YY/MM/dd"
            let formatDate = formatter.string(from: meta)
            print(formatDate)
            creationDatelabel.text = formatDate
        }
    }
    
    private func updateAvatar() {
        let avatar = user?.photoURL
        if let avatar = avatar {
            let test = avatar
            let result = String(test.absoluteString.dropFirst(8))
            let url = URL(string: result)
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.avatarImage.image = image
                        }
                    }
                }
            }
        }
    }
    
    
}
