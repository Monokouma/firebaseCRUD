//
//  BackgroundViewController.swift
//  firebaseEssaie
//
//  Created by Monokouma on 21/10/2021.
//

import UIKit

class BackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        backgroundImage.image = UIImage.gif(url: "https://i.pinimg.com/originals/2d/44/e9/2d44e965dff94b7aa7a51fb42f25faf8.gif")
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func goToRegisterButton(_ sender: UIButton) {
    }
    
}
