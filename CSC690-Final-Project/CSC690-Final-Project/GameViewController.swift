//
//  GameViewController.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//

import UIKit

class GameViewController: UIViewController {
    var player_type = 0
    @IBOutlet weak var Character: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        Character.text = String(player_type)
    }


}

