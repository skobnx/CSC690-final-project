//
//  Player.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/5/21.
//

import Foundation

class Player{
    var type: Int
    var health: Int
    var attack: Int
    var defense: Int
    
    init(type: Int){
        self.type = type
        var hp = 0
        var atk = 0
        var def = 0
        // case 1: samurai
        if type == 1{
            hp = 100
            atk = 10
            def = 5
        }
        // case 2: mage
        else if type == 2{
            hp = 75
            atk = 20
            def = 2
        }
        self.health = hp
        self.attack = atk
        self.defense = def
    }
    
    // function for taking damage
    func takeDmg(dmg_amt: Int){
        let dmg_taken = dmg_amt - self.defense
        self.health = self.health - dmg_taken
    }
    
    // function for restoring health
    func heal(heal_amt: Int){
        self.health = self.health + heal_amt
    }
    
}
