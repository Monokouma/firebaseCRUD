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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gifImage.image = UIImage.gif(url: "https://lh3.googleusercontent.com/TxZSz1tPYcR--umTqbKDJvYm3MHxcix5uIAp4TCLIveCtP6abFs8J3J09sBRveD2HRkBjbH6Sv0bk6H55TiTxJhial6uE6xTq6A96Q=w600")

    }
    
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBAction func usernameButton(_ sender: Any) {
        let username = usernameField.text
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if let username = username {
            print(username)
            
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                self.presentHome()
                print(Auth.auth().currentUser?.displayName)
            }
            
        }
    }
    
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
   
}
