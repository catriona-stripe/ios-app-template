//
//  ViewController.swift
//  SwiftAppTemplate
//
//  Created by Catriona Scott on 4/25/19.
//  Copyright © 2019 Catriona Scott. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainViewController = MainViewController()
        pushViewController(mainViewController, animated: false)
    }
    
}
