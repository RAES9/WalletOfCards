//
//  CardDetailViewController.swift
//  wallet-cards
//
//  Created by Edwin Rivas on 2/6/20.
//  Copyright © 2020 Edwin Rivas. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var view_header: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view_header.layer.cornerRadius = 20
    }
    
    @IBAction func ac(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.alpha = 0.0
        }, completion: {finish in
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ViewController" as String)
            self.addChild(controller)
            controller.didMove(toParent: self)
            self.view.addSubview(controller.view)
            self.view.alpha = 1.0
        })
    }
}
