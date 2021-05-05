//
//  GameModel.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/4/21.
//
import UIKit
import Foundation

class GameModel {
    var player_type = 0
    var boss_type = 0
    var player_image: UIImage? = nil
    var boss_image: UIImage? = nil
    
    // holds the player object
    var player: Player? = nil
    
    // Hold the types of buttons
    var button_one_type = 0
    var button_two_type = 0
    var button_three_type = 0
    var button_one_image: UIImage? = nil
    var button_two_image: UIImage? = nil
    var button_three_image: UIImage? = nil
    
    // function for generating a random boss to fight
    func generateBoss(){
        self.boss_type = Int.random(in: 1 ..< 3)
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
        self.button_one_image = self.getButtonImage(num: card1)
        self.button_two_image = self.getButtonImage(num: card2)
        self.button_three_image = self.getButtonImage(num: card3)
        NotificationCenter.default.post(name: Notification.Name("buttons_updated"), object: nil)
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
