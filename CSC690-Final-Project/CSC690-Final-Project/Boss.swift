import Foundation

// Class defining a boss type object
class Boss{
    var type: Int
    var health: Int
    var attack: Int
    
    // init the boss stats based on the type.
    init(type: Int){
        self.type = type
        var hp = 0
        var atk = 0
        // case 1: Dragon
        if type == 1{
            hp = 90
            atk = 11
        }
        // case 2: Wolf
        else if type == 2{
            hp = 100
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
