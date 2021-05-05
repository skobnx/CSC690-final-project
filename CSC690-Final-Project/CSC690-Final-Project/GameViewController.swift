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
    
    let model = GameModel()
    
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

        NotificationCenter.default.addObserver(self, selector: #selector(updateBoss), name: Notification.Name("boss_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer), name: Notification.Name("player_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtons), name: Notification.Name("buttons_updated"), object: nil)
        
        model.generatePlayer(playerType: self.player_type)
        model.generateBoss()
        model.generateButtons()
    }
    
    @objc func updateBoss(){
        self.boss_type = model.boss_type
        self.boss_image.image = model.boss_image
    }
    
    @objc func updatePlayer(){
        self.player_image.image = model.player_image
        if self.player_type == 1{
            Character.text = "Samurai"
        } else if self.player_type == 2{
            Character.text = "Mage"
        }
    }
    @objc func updateButtons(){
        self.button_one.setImage(model.button_one_image, for: UIControl.State.normal)
        self.button_two.setImage(model.button_two_image, for: UIControl.State.normal)
        self.button_three.setImage(model.button_three_image, for: UIControl.State.normal)
    }

}
