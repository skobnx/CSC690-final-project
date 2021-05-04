//
//  GameViewController.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//

import UIKit

class GameViewController: UIViewController {
    var player_type = 0
    var boss_type = 0
    @IBOutlet weak var boss_image: UIImageView!
    @IBOutlet weak var player_image: UIImageView!
    @IBOutlet weak var Character: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        if player_type == 1{
            Character.text = "Samurai"
        }else if player_type == 2{
            Character.text = "Mage"
        }
        self.generatePlayer()
        self.generateBoss()
    }
    
    // function for generating a random boss to fight
    func generateBoss(){
        self.boss_type = Int.random(in: 1 ..< 3)
        if self.boss_type == 1{
            self.boss_type = 1
            let dragon_image = #imageLiteral(resourceName: "dragon")
            self.boss_image.image = dragon_image
        } else if self.boss_type == 2{
            self.boss_type = 2
            let wolf_image = #imageLiteral(resourceName: "wolf")
            self.boss_image.image = wolf_image
        }
    }
    
    // function for displaying the player image
    func generatePlayer(){
        if self.player_type == 1{
            let playerImage = #imageLiteral(resourceName: "player_samurai")
            self.player_image.image = playerImage
        } else if self.player_type == 2{
            let playerImage = #imageLiteral(resourceName: "player_magic")
            self.player_image.image = playerImage
        }
    }


}
