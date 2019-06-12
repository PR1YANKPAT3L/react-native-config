//
//  ViewController.swift
//  Test
//
//  Created by Stijn Willems on 12/06/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import UIKit
import RNConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var boolLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let configuration = try RNConfigurationModelFactory.readCurrentBuildConfiguration()
            urlLabel.text = configuration.example_url.url.absoluteString
            boolLabel.text = "isDebug: \(configuration.exampleBool)"
        } catch {
            print(error)
        }
    }


}

