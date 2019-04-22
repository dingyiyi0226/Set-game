//
//  ViewController.swift
//  Set-2
//
//  Created by dingyiyi on 2019/4/2.
//  Copyright © 2019 dingyiyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Set()
    
    @IBOutlet weak var cardsView: CardsView!{
        didSet{
            cardsView.currentCards = game.currentCards
            cardsView.selectedCards = game.selectedCards;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    


}

