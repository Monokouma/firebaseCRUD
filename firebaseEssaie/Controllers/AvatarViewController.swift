//
//  AvatarViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 25/10/2021.
//

import UIKit
import Firebase
import SwiftGifOrigin

class AvatarViewController: UIViewController {

    //MARK: -Usefull Variable
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    //MARK: -View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: -@IBAction
    @IBAction func imageOneTapped(_ sender: UITapGestureRecognizer) {
        changeRequest?.photoURL = URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Purple30/v4/e1/27/30/e127305d-97be-eb78-f9c7-a3dc9ac061a9/source/512x512bb.jpg")
        changeRequest?.commitChanges { error in
          print(error)
            print(Auth.auth().currentUser?.photoURL)
            self.presentHome()
        }
    }
    
    @IBAction func imageTwoTapped(_ sender: UITapGestureRecognizer) {
        print("img2")
    }
    
    @IBAction func imageThreeTapped(_ sender: UITapGestureRecognizer) {
        print("img3")
    }
    
    @IBAction func imageFourTapped(_ sender: UITapGestureRecognizer) {
        print("img4")
    }
    
    
    //MARK: -Functions
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
