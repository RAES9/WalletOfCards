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
}