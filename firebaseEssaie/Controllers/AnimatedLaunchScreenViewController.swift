//
//  AnimatedLaunchScreenViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 21/10/2021.
//

import UIKit
import SwiftGifOrigin

class AnimatedLaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gifImage.image = UIImage.gif(url: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5eeea355389655.59822ff824b72.gif")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        callMainView()
        
    }
    
    func callMainView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }

    @IBOutlet weak var gifImage: UIImageView!
    

}
