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
    var hadmatched: [Int]!
    
    
    @IBOutlet weak var cardsView: CardsView!{
        didSet{
            cardsView.currentCards = game.currentCards
            cardsView.selectedCards = game.selectedCards;
        }
    }
    @IBAction func dealCards(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            dealcards();
        default: break;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dealcards(){
        for _ in 1...3{
            let _ = game.appendCard()
        }
        updateCardsView()
        
    }
    func updateCardsView(){
        cardsView.currentCards = game.currentCards
        cardsView.selectedCards = game.selectedCards;
        cardsView.updateview()
    }


}

