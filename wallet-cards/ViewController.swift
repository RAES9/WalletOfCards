//
//  ViewController.swift
//  wallet-cards
//
//  Created by Edwin Rivas on 2/5/20.
//  Copyright © 2020 Edwin Rivas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WalletDelegate {
    var cardsArray = NSMutableArray() as! [NSDictionary]
    let WC = WalletOfCards()
    @IBOutlet weak var wallet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        let card1 = [
            "color" : UIColor.blue,
            "title" : "DISPONIBLE",
            "ammount" : "$20,000.00",
            "name" : "TARJETA (123)"
            ] as [String : Any]
        let card2 = [
            "color" : UIColor.black,
            "title" : "DISPONIBLE",
            "ammount" : "$10,000.00",
            "name" : "TARJETA (456)"
        ] as [String : Any]
        let card3 = [
            "color" : UIColor.brown,
            "title" : "DISPONIBLE",
            "ammount" : "$5,000.00",
            "name" : "TARJETA (789)"
        ] as [String : Any]
        cardsArray.append(card1 as NSDictionary)
        cardsArray.append(card2 as NSDictionary)
        cardsArray.append(card3 as NSDictionary)
        WC.delegate = self
        WC.destitaionController = "testView"
        WC.createWallet()
    }
    
    func setViewFromWallet() -> UIView {
        return self.wallet
    }
    
    func setNumbersOfCards() -> NSInteger {
        return cardsArray.count
    }
    
    func jsonArrayToCards() -> [NSDictionary] {
        return cardsArray
    }
    func detailCardSelected(cardSelected: NSDictionary, index : NSInteger) {
        print("tapped card with index ", index)
        print(cardSelected)
    }
}

