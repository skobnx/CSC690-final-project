//
//  GameViewController.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//

import UIKit

class GameViewController: UIViewController {
    // Player variables
    var player_type = 0
    var player_hp = 0
    var player_atk = 0
    var player_def = 0
    
    // Boss variables
    var boss_type = 0
    var boss_hp = 0
    var boss_atk = 0
    var boss_name = ""
    
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
    @IBOutlet weak var player_hp_label: UILabel!
    @IBOutlet weak var player_atk_label: UILabel!
    @IBOutlet weak var player_def_label: UILabel!
    @IBOutlet weak var boss_hp_label: UILabel!
    @IBOutlet weak var boss_atk_label: UILabel!
    @IBOutlet weak var boss_title: UILabel!
    @IBOutlet weak var player_move_log: UILabel!
    @IBOutlet weak var boss_move_log: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.player_move_log.text = "Game Start!"
        self.boss_move_log.text = "Please choose an action to begin."

        NotificationCenter.default.addObserver(self, selector: #selector(updateBoss), name: Notification.Name("boss_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer), name: Notification.Name("player_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtons), name: Notification.Name("buttons_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossHealth), name: Notification.Name("boss_heath_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerHealth), name: Notification.Name("player_heath_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossDead), name: Notification.Name("boss_died"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerDead), name: Notification.Name("player_died"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossCharged), name: Notification.Name("boss_charged"), object: nil)

        
        model.generatePlayer(playerType: self.player_type)
        model.generateBoss()
        model.generateButtons()
    }

    
    @IBAction func button_one_pressed(_ sender: Any) {
        // attack returns how much attacked for...
        // can display the result here
        switch button_one_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    @IBAction func button_two_pressed(_ sender: Any) {
        switch button_two_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    @IBAction func button_three_pressed(_ sender: Any) {
        switch button_three_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    
    @objc func updateBoss(){
        self.boss_type = model.boss_type
        self.boss_image.image = model.boss_image
        self.boss_hp = model.boss?.health ?? 0
        self.boss_atk = model.boss?.attack ?? 0
        self.boss_hp_label.text = String(self.boss_hp)
        self.boss_atk_label.text = String(self.boss_atk)
        // update the title on the view
        if self.boss_type == 1{
            self.boss_name = "Dragon"
            self.boss_title.text = "Dragon"
        }else if self.boss_type == 2{
            self.boss_name = "Wolf"
            self.boss_title.text = "Wolf"
        }
    }
    
    @objc func updatePlayer(){
        self.player_image.image = model.player_image
        // update the title on the view
        if self.player_type == 1{
            Character.text = "Samurai"
        } else if self.player_type == 2{
            Character.text = "Mage"
        }
        self.player_hp = model.player?.health ?? 0
        self.player_atk = model.player?.attack ?? 0
        self.player_def = model.player?.defense ?? 0
        self.player_hp_label.text = String(self.player_hp)
        self.player_atk_label.text = String(self.player_atk)
        self.player_def_label.text = String(self.player_def)
    }
    
    @objc func updateButtons(){
        self.button_one.setImage(model.button_one_image, for: UIControl.State.normal)
        self.button_two.setImage(model.button_two_image, for: UIControl.State.normal)
        self.button_three.setImage(model.button_three_image, for: UIControl.State.normal)
        self.button_one_type = model.button_one_type
        self.button_two_type = model.button_two_type
        self.button_three_type = model.button_three_type
    }

    @objc func updateBossHealth(){
        self.boss_hp = model.boss?.health ?? 0
        self.boss_hp_label.text = String(self.boss_hp)
        let boss_dmg_taken = model.boss_dmg_taken
        self.player_move_log.text = "Player deals \(boss_dmg_taken) damage to the \(self.boss_name)"
    }
    
    @objc func updatePlayerHealth(){
        self.player_hp = model.player?.health ?? 0
        self.player_hp_label.text = String(self.player_hp)
        let player_dmg_taken = model.player_dmg_taken
        self.boss_move_log.text = "\(self.boss_name) deals \(player_dmg_taken) damage to the player!"
    }
    
    @objc func updateBossDead(){
        self.boss_move_log.text = "Player has defeated \(self.boss_name)!"
    }
    
    @objc func updatePlayerDead(){
        self.player_move_log.text = "\(self.boss_name) has defeated player!"
        self.boss_move_log.text = "Better luck next time!"
        self.player_hp = model.player?.health ?? 0
        self.player_hp_label.text = String(self.player_hp)
    }
    @objc func updateBossCharged(){
        self.boss_move_log.text = "\(self.boss_name) has charged up!"
    }

    

}
