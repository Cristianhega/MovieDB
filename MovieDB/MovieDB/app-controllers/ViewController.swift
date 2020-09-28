//
//  ViewController.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "listID") as! ListView
        self.navigationController?.pushViewController(detailViewController, animated: false)
        //view.navigationController?.pushViewController(detailViewController, animated: false)
    }


}

