import UIKit

// This is the view controller for presenting the rules from the home
// screen of the app.
class howToPlayViewController: UIViewController {

    // imageview for the rules
    @IBOutlet weak var rules_view: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        // load the rules image and set the imageview to the rules image.
        let rules_img = #imageLiteral(resourceName: "rules")
        self.rules_view.image = rules_img
    }

}

