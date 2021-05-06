//
//  PlayerSelectViewController.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//

import UIKit

class PlayerSelectViewController: UIViewController {

    var player_type = 0
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController else { return }
            gameViewController.player_type = player_type
    }
    
    @IBAction func SamuraiButton(_ sender: Any) {
        self.player_type = 1
    }
    
    @IBAction func MagicButton(_ sender: Any) {
        self.player_type = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


}

