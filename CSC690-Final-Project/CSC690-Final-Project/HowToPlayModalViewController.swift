import UIKit

// You can access this modal while in the game to remind yourself
// of the rules without interupting the game
class HowToPlayModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // Button for closing the presented modal with the rules
    @IBAction func CloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

