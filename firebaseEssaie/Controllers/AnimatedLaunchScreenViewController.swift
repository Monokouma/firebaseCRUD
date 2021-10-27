//
//  AnimatedLaunchScreenViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 21/10/2021.
//

import UIKit
import SwiftGifOrigin
import Firebase
import FirebaseAuth

class AnimatedLaunchScreenViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?

    
    //MARK: -@IBOutlet
    @IBOutlet weak var gifImage: UIImageView!
    
    
    //MARK: -Life cycle controller
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5eeea355389655.59822ff824b72.gif")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        isNewUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    
    //MARK: -Functions
    fileprivate func isNewUser() {
        if Auth.auth().currentUser != nil {
            userLoggedWelcome()
        } else {
            userNotLoggedWelcome()
        }
    }
    
    
    fileprivate func userNotLoggedWelcome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisteringViewController") as? RegisteringViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    fileprivate func userLoggedWelcome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
