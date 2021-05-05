//
//  Boss.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/5/21.
//

import Foundation

class Boss{
    var type: Int
    var health: Int
    var attack: Int
    
    init(type: Int){
        self.type = type
        var hp = 0
        var atk = 0
        // case 1: Dragon
        if type == 1{
            hp = 10//testing
            atk = 10
        }
        // case 2: Wolf
        else if type == 2{
            hp = 500
            atk = 10
        }
        self.health = hp
        self.attack = atk
    }
    
    // function for taking damage
    func takeDmg(dmg_amt: Int){
        self.health = self.health - dmg_amt
    }
    
}
