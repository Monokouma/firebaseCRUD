//
//  AnimatedLaunchScreenViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 21/10/2021.
//

import UIKit
import SwiftGifOrigin

class AnimatedLaunchScreenViewController: UIViewController {

    
    //MARK: -@IBOutlet
    @IBOutlet weak var gifImage: UIImageView!
    
    
    //MARK: -Life cycle controller
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.image = UIImage.gif(url: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5eeea355389655.59822ff824b72.gif")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        callMainView()
    }
    
    
    //MARK: -Functions
    func callMainView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
}
