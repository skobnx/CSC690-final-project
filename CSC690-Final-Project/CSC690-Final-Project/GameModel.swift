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
    func check_game_status(){
        
    }
    
    // function for preforming the boss attack
    func boss_attack(){
        print("Boss attacked")
        var dmg = 0
        let crit = Int.random(in: 1 ..< 101)
        if crit <= 20{
            dmg = (self.boss?.attack ?? 0)*2
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }else{
            dmg = (self.boss?.attack ?? 0)
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }
        NotificationCenter.default.post(name: Notification.Name("player_heath_updated"), object: nil)
    }
    
    func preform_attack(){
        print("Attacked")
        let attack_value = (self.player?.attack ?? 1) * self.multiplier
        self.multiplier = 1  // reset the multiplier
        self.boss?.takeDmg(dmg_amt: attack_value)
        self.boss_dmg_taken = attack_value
        NotificationCenter.default.post(name: Notification.Name("boss_heath_updated"), object: nil)
        if (self.boss?.health ?? 0) <= 0{
            print("Boss is dead")
            NotificationCenter.default.post(name: Notification.Name("boss_died"), object: nil)

        }
        else{
            self.boss_attack()
        }

    }
    
    func preform_defend(){
        print("Defended")
        self.boss_attack()
    }
    
    func preform_heal(){
        print("Healed")
        self.boss_attack()
    }
    
    func preform_special(){
        print("Used special attack")
        self.boss_attack()
    }
    
    func preform_prep(){
        print("prepared")
        // maybe sleep? idk
        sleep(1)
        self.boss_attack()
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
