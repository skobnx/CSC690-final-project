//
//  howToPlayViewController.swift
//  CSC690-Final-Project
//
//  Created by Sebastian Drake on 5/3/21.
//

import UIKit

class howToPlayViewController: UIViewController {

    @IBOutlet weak var rules_view: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        let rules_img = #imageLiteral(resourceName: "rules")
        self.rules_view.image = rules_img
    }


}

