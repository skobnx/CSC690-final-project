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
            hp = 50
            atk = 15
            def = 2
        }
        self.health = hp
        self.attack = atk
        self.defense = def
    }
    
    func increase_defense(){
        self.defense = self.defense*2
    }
    
    func decrease_defense(){
        self.defense = self.defense/2
    }
    
    // function for taking damage
    func takeDmg(dmg_amt: Int) -> Int{
        if dmg_amt <= self.defense{
            return 0// no damage was taken
        }else{
            let dmg_taken = dmg_amt - self.defense
            self.health = self.health - dmg_taken
            return dmg_taken
        }
    }
    
    // function for restoring health
    func heal(heal_amt: Int){
        self.health = self.health + heal_amt
    }
    
}
