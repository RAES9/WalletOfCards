//
//  WalletOfCards.swift
//  wallet-cards
//
//  Created by Edwin Rivas on 2/5/20.
//  Copyright © 2020 Edwin Rivas. All rights reserved.
//

import Foundation
import UIKit

protocol WalletDelegate: class{
    func setViewFromWallet() -> UIView
    func setNumbersOfCards() -> NSInteger
    func jsonArrayToCards() -> [NSDictionary]
    func detailCardSelected(cardSelected : NSDictionary, index : NSInteger)
}

class WalletOfCards{
    public let padding = 20
    private var counter = 0
    public let heightCardSaved = 80
    public let heightReal = 230
    private var myCustomView: CardDetailViewController?
    public var delegate: ViewController?
    private var afterPosition = NSInteger()
    public var destitaionController = NSString()
    private var currentCard = UIView()
    init(){
        self.destitaionController = ""
    }
    
    func createWallet(){
        afterPosition = Int((delegate?.setViewFromWallet().frame.size.height)!)
        creatingWalletWith(detail: (delegate?.jsonArrayToCards())!)
    }
    
    private func creatingWalletWith(detail : [NSDictionary]){
        for x in detail{
            newCard(view: (delegate?.setViewFromWallet())!, color: x.value(forKey: "color") as! UIColor, nam: x.value(forKey: "name") as! String, amm: x.value(forKey: "ammount") as! String, tit: x.value(forKey: "title") as! String, count: (delegate?.setNumbersOfCards())!)
        }
    }

    private func newCard(view : UIView, color : UIColor, nam : String, amm : String, tit : String, count : NSInteger){
        let v = UIView()
        counter += 1
        afterPosition = afterPosition - (heightCardSaved * (count - 1))
        v.frame = CGRect(x: (Int(view.frame.width) / 2) - ((Int(view.frame.width) - (self.padding * 2)) / 2), y: self.afterPosition * 2, width: Int(view.frame.width) - (self.padding * 2), height: self.heightReal)
        v.backgroundColor = color
        v.layer.cornerRadius = 20
        let image = UIView()
        image.frame = CGRect(x: 20, y: 20, width: v.frame.size.width / 5, height: v.frame.size.height / 8)
        image.backgroundColor = UIColor.white
        let name = UILabel()
        name.frame = CGRect(x: image.frame.size.width + 36, y: 20, width:  v.frame.size.width / 3, height: v.frame.size.height / 8)
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        name.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        name.textColor = UIColor.white
        name.text = nam
        let ammount = UILabel()
        ammount.frame = CGRect(x: v.frame.size.width - ((v.frame.size.width / 3) + 20), y: 20, width:  v.frame.size.width / 3, height: v.frame.size.height / 8)
        ammount.lineBreakMode = .byWordWrapping
        ammount.numberOfLines = 0
        ammount.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        ammount.textColor = UIColor.white
        ammount.text = amm
        ammount.textAlignment = .center
        let title = UILabel()
        title.frame = CGRect(x: v.frame.size.width - ((v.frame.size.width / 3) + 20), y: 12, width:  v.frame.size.width / 3, height: 11)
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 11.0)
        title.textColor = UIColor.white
        title.text = tit
        title.textAlignment = .center
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: v.frame.size.width, height: v.frame.size.height))
        button.tag = counter - 1
        button.addTarget(self, action: #selector(tappedButton(sender:)) , for: .touchUpInside)
        v.addSubview(image)
        v.addSubview(name)
        v.addSubview(ammount)
        v.addSubview(title)
        v.addSubview(button)
        v.tag = counter
        UIView.animate(withDuration: 1, animations: {
            view.addSubview(v)
            v.frame = CGRect(x: (Int(view.frame.width) / 2) - ((Int(view.frame.width) - (self.padding * 2)) / 2), y: self.afterPosition - self.heightCardSaved, width: Int(view.frame.width) - (self.padding * 2), height: self.heightReal)
        })
        afterPosition = Int((delegate?.setViewFromWallet().frame.size.height)!)
        afterPosition = afterPosition + (heightCardSaved * counter)
    }
    
    func saveCurrentCard(){
        UIView.animate(withDuration: 0.5, animations: {
            for view in self.currentCard.subviews{
                view.alpha = 1.0
            }
            self.currentCard.layer.cornerRadius = (self.currentCard.frame.size.width / 3) / 2
            self.currentCard.frame = CGRect(x: ((self.delegate?.setViewFromWallet().frame.width)! / 2) - ((self.currentCard.frame.size.width / 3) / 2), y: 0 - (UIScreen.main.bounds.height - (self.delegate?.setViewFromWallet().frame.height)!), width: self.currentCard.frame.size.width / 3, height: self.currentCard.frame.size.width / 3)
            for view in self.currentCard.subviews{
                view.alpha = 0.0
            }
        })
    }
    
    @objc func tappedButton(sender: UIButton!)
    {
        let cardSelected = delegate?.setViewFromWallet().viewWithTag(sender.tag + 1)
        self.currentCard = cardSelected!
        cardSelected?.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.5, animations: {
            for view in cardSelected!.subviews{
                view.alpha = 1.0
            }
            cardSelected?.layer.cornerRadius = ((cardSelected?.frame.size.width)! / 3) / 2
            cardSelected?.frame = CGRect(x: ((self.delegate?.setViewFromWallet().frame.width)! / 2) - (((cardSelected?.frame.size.width)! / 3) / 2), y: (cardSelected?.frame.origin.y)!, width: (cardSelected?.frame.size.width)! / 3, height: (cardSelected?.frame.size.width)! / 3)
            for view in cardSelected!.subviews{
                view.alpha = 0.0
            }
        }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            cardSelected?.frame.origin.y = 0 - (UIScreen.main.bounds.height - (self.delegate?.setViewFromWallet().frame.height)!)
        }, completion: {finish in
            self.delegate?.setViewFromWallet().bringSubviewToFront(cardSelected!)
            UIView.animate(withDuration: 1, animations: {
                for view in (self.delegate?.setViewFromWallet().subviews)!{
                    if view.tag != sender.tag{
                        view.frame = CGRect(x: (Int(view.frame.width) / 2) - ((Int(view.frame.width) - (self.padding * 2)) / 2), y: self.afterPosition * 2, width: Int(view.frame.width) - (self.padding * 2), height: self.heightReal)
                    }
                }
                cardSelected?.frame.origin.y = 0 - (UIScreen.main.bounds.height - (self.delegate?.setViewFromWallet().frame.height)!)
                cardSelected?.frame.origin.x = 0
                cardSelected?.frame.size.width = UIScreen.main.bounds.width
                cardSelected?.frame.size.height = UIScreen.main.bounds.height + 50
            }, completion: {finish in
                UIView.animate(withDuration: 1, animations: {
                    cardSelected?.layer.cornerRadius = 0
                }, completion: {finish in
                    UIView.animate(withDuration: 1, animations: {
                        if(self.destitaionController.isEqual(to: "")){
                            cardSelected?.alpha = 1.0
                            cardSelected?.alpha = 0.0
                        }else{
                            let controller = self.delegate?.storyboard!.instantiateViewController(withIdentifier: self.destitaionController as String)
                            self.delegate?.addChild(controller!)
                            controller!.didMove(toParent: self.delegate!)
                            controller!.view.frame = CGRect(x: 0, y: 0, width: (cardSelected?.frame.width)!, height: (cardSelected?.frame.height)!)
                            controller!.view.alpha = 0.0
                            cardSelected?.addSubview(controller!.view)
                            controller!.view.alpha = 1.0
                        }
                    }, completion: nil)
                })
            })
        })
        self.delegate?.detailCardSelected(cardSelected: (delegate?.jsonArrayToCards())![sender.tag], index: sender.tag)
    }
}


