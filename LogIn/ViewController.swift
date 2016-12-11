//
//  ViewController.swift
//  LogIn
//
//  Created by admin on 01/10/16.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //check if user is logged in and load view
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if !isUserLoggedIn {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }
    }
    
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        
        //logout user
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
}

