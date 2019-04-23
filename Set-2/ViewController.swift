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
    @IBAction func selectCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let coor = sender.location(in: cardsView)
            selectcard(at: coor);
            
        default: break;
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
    func selectcard(at point: CGPoint){
        let coor = cardsView.grid.rowAndColumn(at: point)
        let index = coor.row*3 + coor.column
        
        if let selected = game.selectedCards.firstIndex(of: index){
            //deselect card
            game.selectedCards.remove(at: selected)
            
        }
        else {
            //select card
            game.selectedCards.append(index)
        }
        cardsView.selectedCards = game.selectedCards;
        cardsView.updateview(with: false)
        
    }
    func updateCardsView(){
        cardsView.currentCards = game.currentCards
        cardsView.selectedCards = game.selectedCards;
        cardsView.updateview(with: true)
    }

}

extension Grid{
    func rowAndColumn(at point: CGPoint) -> (row: Int, column: Int){
        
        let boundingSize = CGSize(
            width: CGFloat(dimensions.columnCount) * cellSize.width,
            height: CGFloat(dimensions.rowCount) * cellSize.height
        )
        let offset = (
            dx: (frame.size.width - boundingSize.width) / 2,
            dy: (frame.size.height - boundingSize.height) / 2
        )
        let column = Int( (point.x - offset.dx) / cellSize.width )
        let row    = Int( (point.y - offset.dy) / cellSize.height )

        return (row, column)
    }
}
