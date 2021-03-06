//
//  Set.swift
//  Set
//
//  Created by dingyiyi on 2019/3/21.
//  Copyright © 2019 dingyiyi. All rights reserved.
//

import Foundation

struct Features{
    enum Number: Int{
        case one   = 1
        case two   = 2
        case three = 3
        
        func value() -> Int{
            switch self {
            case .one: return 1
            case .two: return 10
            case .three: return 100
            }
        }
        static var all = [Number.one, .two, .three]
    }
    enum Shape: String{
        case triangle = "▲"
        case square   = "■"
        case circle   = "●"
        func value() -> Int{
            switch self {
            case .triangle: return 1
            case .square: return 10
            case .circle: return 100
            }
        }
        
        static var all = [Shape.triangle, .square, .circle]
    }
    /// background Color
    enum Shading{
        case green
        case blue
        case purple
        func value() -> Int{
            switch self {
            case .green: return 1
            case .blue: return 10
            case .purple: return 100
            }
        }
        static var all = [Shading.green, .blue, .purple]
    }
    enum Color {
        case red
        case orange
        case yellow
        func value() -> Int{
            switch self {
            case .red: return 1
            case .orange: return 10
            case .yellow: return 100
            }
        }
        static var all = [Color.red, .orange, .yellow]
    }
}
struct Card: Equatable {
    var number:  Features.Number
    var shape:   Features.Shape
    var shading: Features.Shading
    var color:   Features.Color
}
struct CardDeck {
    private(set) var cards = [Card]()
    
    init(){
        for number in Features.Number.all{
            for shape in Features.Shape.all{
                for shading in Features.Shading.all{
                    for color in Features.Color.all{
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                       
                    }
                }
            }
        }
        
        cards.shuffle()
    }
    
    mutating func draw() -> Card?{
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        }
        else { return nil }
    }
}

struct Set {
    private var carddeck = CardDeck()
    var currentCards = [Card]()
    var selectedCards = [Int]()
    
    init(){
        for _ in 1...12{
            currentCards.append(carddeck.draw()!)
        }
    }
    
    /**
     - threecards:
     
        Int array of indices of selected three cards
     - matchedOrFirst:
     
        return true if three cards are matched or is the first card
     - Returns: (threecards: [Int]?, matchedOrFirst: Bool)
     */
    
    mutating func selectCard(at index: Int) -> (threecards: [Int]?, matched: Bool) {
        if index >= currentCards.count { return (nil, false) }
        assert(selectedCards.count < 3)
        
        if let selectedindex = selectedCards.firstIndex(of: index) {
            // deselect
            selectedCards.remove(at: selectedindex)
        }
        else{
            if selectedCards.count < 2 {
                selectedCards.append(index)
            }
            else {
                //check
                selectedCards.append(index)
                let original = selectedCards
                selectedCards.removeAll()
                
                return (original, checkMatch(for: original))
            }
        }
        return (nil, false)
    }
    mutating func removeCards(for cardarray: [Int]){
        let sortedcardarray = cardarray.sorted().reversed()
        for index in sortedcardarray{
            currentCards.remove(at: index)
        }
    }
    mutating func shuffleCards(){
        currentCards.shuffle()
        selectedCards.removeAll()
    }

    /// return true if the set is match
    private func checkMatch(for cardindexarray: [Int]) -> Bool{
        var sum = [0, 0, 0, 0]
        
        for index in cardindexarray{
            sum[0] += (currentCards[index].number.value())
            sum[1] += (currentCards[index].shape.value())
            sum[2] += (currentCards[index].shading.value())
            sum[3] += (currentCards[index].color.value())
        }
        for i in 0...3{
            if (sum[i] != 3)&&(sum[i] != 30)&&(sum[i] != 300)&&(sum[i] != 111) {
                return false
            }
        }
        return true
    }
    /// append card to the last
    mutating func appendCard() -> Bool {
        if carddeck.cards.isEmpty   {return false}
        currentCards.append(carddeck.draw()!)
        return true
    }
}

extension Int{
    var arc4random: Int{
        if self > 0      { return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 { return -Int(arc4random_uniform(UInt32(-self))) }
        else             { return 0 }
    }
}

extension Array where Element == Optional<Card> {
    var cnt: Int{
        var num = 0
        for index in self.indices{
            if self[index] != nil {num += 1}
        }
        return num
    }
}
