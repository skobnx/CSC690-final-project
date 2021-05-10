import UIKit
import Foundation

class GameModel {
    // track the number of turns in the game
    var turns = 0
    // When the card "Prepare" is selected
    // this multiplier += 1 and then the next action will be doubled.
    // After the action is taken, multiplier resets to 1.
    var multiplier = 1
    // holds boss charge state
    var boss_charged: Bool = false
    // the amount the player will heal with the heal action
    var amount_to_heal = 0
    // the amount the player healed when action was taken
    var amount_restored = 0
    // the amount of damage the boss took
    var player_dmg_taken = 0
    // the amount of damage the player took
    var boss_dmg_taken = 0
    
    // player & boss type and images
    var player_type = 0
    var boss_type = 0
    var player_image: UIImage? = nil
    var boss_image: UIImage? = nil
    
    // holds the player object
    var player: Player? = nil
    
    // holds the boss object
    var boss: Boss? = nil
    
    // Hold the types and images for the buttons
    var button_one_type = 0
    var button_two_type = 0
    var button_three_type = 0
    var button_one_image: UIImage? = nil
    var button_two_image: UIImage? = nil
    var button_three_image: UIImage? = nil
    
    // function for generating a random boss to fight
    // should only need to call this once
    func generateBoss(){
        // flip a coin for boss type
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
    
    // function for generating the action buttons
    func generateButtons(){
        var array = [1, 2, 3, 4, 5]
        array.shuffle()
        // select 3 numbers out a randomized array
        // actions cannot be repeated
        let card1 = array[0]
        let card2 = array[1]
        let card3 = array[2]
        // set the action buttons to the selected actions
        self.button_one_type = card1
        self.button_two_type = card2
        self.button_three_type = card3
        self.button_one_image = self.getButtonImage(num: card1)
        self.button_two_image = self.getButtonImage(num: card2)
        self.button_three_image = self.getButtonImage(num: card3)
        NotificationCenter.default.post(name: Notification.Name("buttons_updated"), object: nil)
    }
    
    // function for cheking if game is over by the player being dead.
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
        // random # between 1 & 100
        let crit = Int.random(in: 1 ..< 101)
        // check if boss is already charged
        // if boss is charged this attack will do 3x
        if self.boss_charged{
            dmg = (self.boss?.attack ?? 0)*3
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
            self.boss_charged = false
            NotificationCenter.default.post(name: Notification.Name("boss_uncharged"), object: nil)
        }
        // if boss isnt charged, check if crit was rolled
        // 15% chance
        else if crit <= 15{
            dmg = (self.boss?.attack ?? 0)*2
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }else{// if didnt crit then just deal normal attack dmg
            dmg = (self.boss?.attack ?? 0)
            self.player_dmg_taken = self.player?.takeDmg(dmg_amt: dmg) ?? 0
        }
        // check if the player died
        if self.check_player_hp(){
            NotificationCenter.default.post(name: Notification.Name("player_died"), object: nil)

        }else{
            NotificationCenter.default.post(name: Notification.Name("player_heath_updated"), object: nil)
        }
    }
    
    // function for prefoming the boss action
    func boss_move(){
        // if not charged then roll a number between 1-100
        if boss_charged == false{
            let boss_will_charge = Int.random(in: 1 ..< 101)
            // if that number <= 15 then the boss will charge this turn. 15% chance
            if boss_will_charge <= 15{
                self.boss_charged = true
                NotificationCenter.default.post(name: Notification.Name("boss_charged"), object: nil)
            }else{
                // if boss didnt charge then preform attack
                self.boss_preform_attack()
            }
        }else{
            // if boss is already charged then preform attack
            self.boss_preform_attack()
        }
    }
    
    // function for preforming player attack action
    func preform_attack(){
        // increase turn counter
        self.turns += 1
        // multiply attack value by current multiplier
        let attack_value = (self.player?.attack ?? 1) * self.multiplier
        self.multiplier = 1  // reset the multiplier
        // deal damage to the boss
        self.boss?.takeDmg(dmg_amt: attack_value)
        self.boss_dmg_taken = attack_value
        NotificationCenter.default.post(name: Notification.Name("boss_heath_updated"), object: nil)
        // check to see if the boss is dead
        if (self.boss?.health ?? 0) <= 0{
            NotificationCenter.default.post(name: Notification.Name("boss_died"), object: nil)
        }
        // if boss isnt dead, then the boss moves
        else{
            self.boss_move()
        }
    }
    
    // function for preforming player defend action
    func preform_defend(){
        // increase turn counter
        self.turns += 1
        // increase the player's defense
        self.player?.increase_defense()
        // boss attacks
        self.boss_move()
        // reset the player's defense
        self.player?.decrease_defense()
        NotificationCenter.default.post(name: Notification.Name("player_defended"), object: nil)
    }
    
    // function for preforming player heal action
    func preform_heal(){
        // increase turn counter
        self.turns += 1
        // heals random amount between 7 and 11
        self.amount_to_heal = Int.random(in: 7 ..< 12)
        // multiply healing amount by current multiplier
        self.amount_restored = self.amount_to_heal*self.multiplier
        self.player?.heal(heal_amt: self.amount_restored)
        self.multiplier = 1  // reset the multiplier
        NotificationCenter.default.post(name: Notification.Name("player_healed"), object: nil)
        self.boss_move()
    }
    
    // function for preforming player special action
    func preform_special(){
        // increase turn counter
        self.turns += 1
        // attack dmg is cut in half for special attack
        // multiply halfed dmg by current multiplier
        let attack_dmg: Int = ((self.player?.attack ?? 1)/2) * self.multiplier
        self.multiplier = 1  // reset the multiplier
        // roll a number between 1 - 100
        let will_stun_boss = Int.random(in: 1 ..< 101)
        // deal dmg to the boss
        self.boss?.takeDmg(dmg_amt: attack_dmg)
        self.boss_dmg_taken = attack_dmg
        NotificationCenter.default.post(name: Notification.Name("boss_heath_updated"), object: nil)
        if (self.boss?.health ?? 0) <= 0{
            NotificationCenter.default.post(name: Notification.Name("boss_died"), object: nil)
        } else{
            // if the number is <= 60 then boss isnt stunned and attacks
            if will_stun_boss <= 60{
                self.boss_move()
            }else{
                // 40% chance to stun boss
                // condition if boss is stunned
                // boss loses its charge
                if self.boss_charged{
                    NotificationCenter.default.post(name: Notification.Name("boss_uncharged"), object: nil)
                }
                self.boss_charged = false
                NotificationCenter.default.post(name: Notification.Name("boss_stunned"), object: nil)
            }
        }
    }
    
    // function for preforming player prep action
    func preform_prep(){
        // increase turn counter
        self.turns += 1
        // increase multiplier
        self.multiplier += 1
        NotificationCenter.default.post(name: Notification.Name("player_prepared"), object: nil)
        self.boss_move()
    }
    
    // function for returning the correct buttom image
    // given a button type number
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
