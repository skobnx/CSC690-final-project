//
//  GameModel.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//
import UIKit
import Foundation

class GameModel {
    // When the card "Prepare" is selected
    // this multiplier becomes 2 and then the next
    // action will be doubled.
    // After the action is taken, multiplier resets to 1.
    var multiplier = 1
    var boss_charged: Bool = false
    var amount_to_heal = 0
    var amount_restored = 0

    var player_dmg_taken = 0
    var boss_dmg_taken = 0
    
    var player_type = 0
    var boss_type = 0
    var player_image: UIImage? = nil
    var boss_image: UIImage? = nil
    
    // holds the player object
    var player: Player? = nil
    
    // holds the boss object
    var boss: Boss? = nil
    
    // Hold the types of buttons
    var button_one_type = 0
    var button_two_type = 0
    var button_three_type = 0
    var button_one_image: UIImage? = nil
    var button_two_image: UIImage? = nil
    var button_three_image: UIImage? = nil
    
    // function for generating a random boss to fight
    // should only need to call this once
    func generateBoss(){
        self.boss_type = Int.random(in: 1 ..< 3)
        self.boss = Boss(type: boss_type)
        if self.boss_type == 1{
            self.boss_type = 1
            let dragon_image = #imageLiteral(resourceName: "dragon")
            self.boss_image = dragon_image
        } else if self.boss_type == 2{
            self.boss_type = 2
            let wolf_image = #imageLiteral(resourceName: "wolf")
            self.boss_image = wolf_image
        }
        NotificationCenter.default.post(name: Notification.Name("boss_created"), object: nil)
    }
    
    // function for displaying the player image
    // should only need to call this once
    func generatePlayer(playerType: Int){
        self.player_type = playerType
        self.player = Player(type: playerType)
        if self.player_type == 1{
            let playerImage = #imageLiteral(resourceName: "player_samurai")
            self.player_image = playerImage
        } else if self.player_type == 2{
            let playerImage = #imageLiteral(resourceName: "player_magic")
            self.player_image = playerImage
        }
        NotificationCenter.default.post(name: Notification.Name("player_created"), object: nil)
    }
    func generateButtons(){
        var array = [1, 2, 3, 4, 5]
        array.shuffle()
        let card1 = array[0]
        let card2 = array[1]
        let card3 = array[2]
        self.button_one_type = card1
        self.button_two_type = card2
        self.button_three_type = card3
        self.button_one_image = self.getButtonImage(num: card1)
        self.button_two_image = self.getButtonImage(num: card2)
        self.button_three_image = self.getButtonImage(num: card3)
        NotificationCenter.default.post(name: Notification.Name("buttons_updated"), object: nil)
    }
    // function for cheking if game is over
    // checks the hp for both the boss and player.
    func check_player_hp() -> Bool{
        if (self.player?.health ?? 0) <= 0{
            return true
        }else{
            return false
        }
    }
    
    // function for preforming the boss attack
    func boss_preform_attack(){
        var dmg = 0
        let crit = Int.random(in: 1 ..< 101)
        if self.boss_charged{
            dmg = (self.boss?.attack ?? 0)*3
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
            self.boss_charged = false
        }
        else if crit <= 15{
            dmg = (self.boss?.attack ?? 0)*2
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }else{
            dmg = (self.boss?.attack ?? 0)
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }
        if self.check_player_hp(){
            NotificationCenter.default.post(name: Notification.Name("player_died"), object: nil)

        }else{
            NotificationCenter.default.post(name: Notification.Name("player_heath_updated"), object: nil)
        }
    }
    
    func boss_move(){
        if boss_charged == false{
            let boss_will_charge = Int.random(in: 1 ..< 101)
            if boss_will_charge <= 15{
                self.boss_charged = true
                NotificationCenter.default.post(name: Notification.Name("boss_charged"), object: nil)
            }else{
                self.boss_preform_attack()
            }
        }else{
            self.boss_preform_attack()
        }
    }
    
    func preform_attack(){
        let attack_value = (self.player?.attack ?? 1) * self.multiplier
        self.multiplier = 1  // reset the multiplier
        self.boss?.takeDmg(dmg_amt: attack_value)
        self.boss_dmg_taken = attack_value
        NotificationCenter.default.post(name: Notification.Name("boss_heath_updated"), object: nil)
        if (self.boss?.health ?? 0) <= 0{
            NotificationCenter.default.post(name: Notification.Name("boss_died"), object: nil)
        }
        else{
            self.boss_move()
        }
    }
    
    func preform_defend(){
        self.player?.increase_defense()
        self.boss_move()
        self.player?.decrease_defense()
        NotificationCenter.default.post(name: Notification.Name("player_defended"), object: nil)
    }
    
    func preform_heal(){
        self.amount_to_heal = Int.random(in: 7 ..< 12)
        self.amount_restored = self.amount_to_heal*self.multiplier
        self.player?.heal(heal_amt: self.amount_restored)
        self.multiplier = 1
        NotificationCenter.default.post(name: Notification.Name("player_healed"), object: nil)
        self.boss_move()
    }
    
    func preform_special(){
        let attack_dmg: Int = ((self.player?.attack ?? 1)/2) * self.multiplier
        self.multiplier = 1
        let will_stun_boss = Int.random(in: 1 ..< 101)
        self.boss?.takeDmg(dmg_amt: attack_dmg)
        self.boss_dmg_taken = attack_dmg
        NotificationCenter.default.post(name: Notification.Name("boss_heath_updated"), object: nil)
        if (self.boss?.health ?? 0) <= 0{
            NotificationCenter.default.post(name: Notification.Name("boss_died"), object: nil)
        } else{
            // 40% chance to stun boss
            if will_stun_boss <= 60{
                self.boss_move()
            }else{
                // condition if boss is stunned
                // boss loses his charge
                self.boss_charged = false
                NotificationCenter.default.post(name: Notification.Name("boss_stunned"), object: nil)
            }
        }
    }
    
    func preform_prep(){
        self.multiplier += 1
        NotificationCenter.default.post(name: Notification.Name("player_prepared"), object: nil)
        self.boss_move()
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
