import UIKit

class ViewController: UIViewController {
    // action for unwinding back to the home screen
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Hide the navigation controller for the whole application
        // navigation is handled with custom navigation buttons
        self.navigationController?.isNavigationBarHidden = true
    }

}

