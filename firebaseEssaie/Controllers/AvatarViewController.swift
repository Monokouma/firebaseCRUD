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
    
    
    //MARK: -@IBOutlet
    @IBOutlet weak var gifImage: UIImageView!
    
    
    //MARK: -View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://c.tenor.com/3F5XmYhEARwAAAAC/chill-japan.gif")
    }
    
    
    //MARK: -@IBAction
    @IBAction func imageOneTapped(_ sender: UITapGestureRecognizer) {
        changeRequest?.photoURL = URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Purple30/v4/e1/27/30/e127305d-97be-eb78-f9c7-a3dc9ac061a9/source/512x512bb.jpg")
        changeRequest?.commitChanges { error in
            self.presentHome()
        }
    }
    
    @IBAction func imageTwoTapped(_ sender: UITapGestureRecognizer) {
        changeRequest?.photoURL = URL(fileURLWithPath: "https://pm1.narvii.com/7116/bdc0f3d3a06908148d59c58553bad6d98618f4ber1-1712-1712v2_128.jpg")
        changeRequest?.commitChanges { error in
            self.presentHome()
        }
    }
    
    @IBAction func imageThreeTapped(_ sender: UITapGestureRecognizer) {
        changeRequest?.photoURL = URL(fileURLWithPath: "https://lh5.googleusercontent.com/2c0vL4mfm1qdFmSllV_TUOX6IEYmCv4WbbNtdlFHtYL9aCjkJfHo1oPOv4MIDLV1dRAcwLT76TLP9n_Vl663hl7w7uu-1Qti7D0WzNRbsk7hWS1uGroB_7mKCswxJt1zWfXbL6te")
        changeRequest?.commitChanges { error in
            self.presentHome()
        }
    }
    
    @IBAction func imageFourTapped(_ sender: UITapGestureRecognizer) {
        changeRequest?.photoURL = URL(fileURLWithPath: "https://danielweppeler.de/wp-content/uploads/2020/07/me-in-8bit.png")
        changeRequest?.commitChanges { error in
            self.presentHome()
        }
    }
    
    
    //MARK: -Functions
    private func presentHome() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoggedViewController") as? LoggedViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
