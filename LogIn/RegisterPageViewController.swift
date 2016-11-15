//
//  RegisterPageViewController.swift
//  LogIn
//
//  Created by admin on 01/10/16.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatpasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtnClick(_ sender: AnyObject) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let repeatPassword = repeatpasswordTextField.text;
        
        //check empty fields
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (repeatPassword?.isEmpty)!) {
            
            //display alert message
            displayAlert(message: "All fields are required.");
            return;
        }
        
        //check if passwords match
        if (userPassword != repeatPassword) {
            //display alert message
            displayAlert(message: "Passwords do not match.");
        }
        //store data
        
        //display confirmation message
    }
    
    func displayAlert(message: String){
        let myAlert = UIAlertController(title:"Alert", message: message, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }

   

}
