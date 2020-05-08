//
//  loginViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class loginViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil{
            let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController")
            present(signInViewController!,animated: true,completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
