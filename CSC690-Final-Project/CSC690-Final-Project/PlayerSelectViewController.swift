import UIKit

// view controller for the player select screen
class PlayerSelectViewController: UIViewController {
    
    // holds the player type variable to be passed to the game
    var player_type = 0
    
    // on segue, depending on what button is selected the type of player chosen is determined
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController else { return }
            gameViewController.player_type = player_type
    }
    
    // button for playing as a samurai class
    @IBAction func SamuraiButton(_ sender: Any) {
        self.player_type = 1
    }
    
    // button for playing as a mage class
    @IBAction func MagicButton(_ sender: Any) {
        self.player_type = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


}

