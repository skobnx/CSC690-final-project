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
    
    // Hold the types of buttons
    var button_one_type = 0
    var button_two_type = 0
    var button_three_type = 0
    
    @IBOutlet weak var boss_image: UIImageView!
    @IBOutlet weak var player_image: UIImageView!
    @IBOutlet weak var Character: UILabel!
    @IBOutlet weak var button_one: UIButton!
    @IBOutlet weak var button_two: UIButton!
    @IBOutlet weak var button_three: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        if player_type == 1{
            Character.text = "Samurai"
        } else if player_type == 2{
            Character.text = "Mage"
        }
        self.generatePlayer()
        self.generateBoss()
        self.generateButtons()
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

    func generateButtons(){
        var array = [1, 2, 3, 4, 5]
        array.shuffle()
        let card1 = array[0]
        let card2 = array[1]
        let card3 = array[2]
        let button_one_image = self.getButtonImage(num: card1)
        let button_two_image = self.getButtonImage(num: card2)
        let button_three_image = self.getButtonImage(num: card3)
        self.button_one.setImage(button_one_image, for: UIControl.State.normal)
        self.button_two.setImage(button_two_image, for: UIControl.State.normal)
        self.button_three.setImage(button_three_image, for: UIControl.State.normal)
    }
    
    func getButtonImage(num: Int) -> UIImage{
        switch num {
        case 1:
            //return attack
            return #imageLiteral(resourceName: "attack_card")
        case 2:
            //return defend
            return #imageLiteral(resourceName: "defend_card")
        case 3:
            //return heal
            return #imageLiteral(resourceName: "heal_card")
        case 4:
            //return special
            return #imageLiteral(resourceName: "special_card")
        case 5:
            //return prepare
            return #imageLiteral(resourceName: "prepare_card")
        default:
            return #imageLiteral(resourceName: "empty_button")
        }
    }

}
