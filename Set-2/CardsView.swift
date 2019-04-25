//
//  CardsView.swift
//  Set-2
//
//  Created by dingyiyi on 2019/4/5.
//  Copyright © 2019 dingyiyi. All rights reserved.
//

import UIKit

class CardsView: UIView {
    
    // game data
    var currentCards = [Card]()
    var selectedCards = [Int]()
    var hadmatched = (cards: [Int](),matched: false)
    var matchedBoundaryColor = UIColor.black
    var traitchange = false
    lazy var grid = Grid(layout: .dimensions(rowCount: 12/columnNum, columnCount: columnNum),frame: bounds)
    
    override func draw(_ rect: CGRect) {
        if traitchange{
            let tmp = calcRowColumn(totalcards: currentCards.count)
            grid = Grid(layout: .dimensions(rowCount: tmp.0,columnCount: tmp.1),frame: bounds)
            traitchange = false
        }
        for cardindex in currentCards.indices{
            let features = calcfeatures(for: currentCards[cardindex])
            let str = centeredAttributedString(features.title, fontsize: 30, textcolor: features.titleColor)
            let card = UIBezierPath(roundedRect: grid[cardindex]!.zoom(by: cardZoomRatio), cornerRadius: (grid[cardindex]?.cornerRad)! )
            features.backgroundColor.setFill()
            card.fill()
            if selectedCards.contains(cardindex) {
                UIColor.black.setStroke()
                card.lineWidth = 5.0
                card.stroke()
            }
            if hadmatched.cards.contains(cardindex){
                matchedBoundaryColor.setStroke()
                card.lineWidth = 7.0
                card.stroke()
            }
            str.draw(in: grid[cardindex]!.offsetBy(dx: 0, dy: grid[cardindex]!.size.height/2 - 15))
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        traitchange = true
    }
    
    private func centeredAttributedString(_ string: String, fontsize: CGFloat, textcolor: UIColor) -> NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontsize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font, .foregroundColor: textcolor])
    }
    private func calcfeatures(for card: Card) -> (title: String, titleColor: UIColor, backgroundColor: UIColor){
        var titlecnt = 0
        var tmptitle = ""
        var title: String = ""
        var titleColor: UIColor
        var backgroundColor: UIColor
        
        switch card.number {
        case .one:
            titlecnt = 1
        case .two:
            titlecnt = 2
        case .three:
            titlecnt = 3
        }
        switch card.shape {
        case .circle:
            tmptitle = "●"
        case .square:
            tmptitle = "■"
        case .triangle:
            tmptitle = "▲"
        }
        for _ in 1...titlecnt{
            title += tmptitle
        }
        
        switch card.shading {
        case .blue:
            backgroundColor = UIColor.blue
        case .green:
            backgroundColor = UIColor.green
        case .purple:
            backgroundColor = UIColor.purple
        }
        switch card.color {
        case .red:
            titleColor = UIColor.red
        case .orange:
            titleColor = UIColor.orange
        case .yellow:
            titleColor = UIColor.yellow
        }
        return (title, titleColor, backgroundColor)
    }
    private func calcRowColumn(totalcards: Int) -> (Int, Int){
        let row = totalcards%columnNum==0 ? totalcards/columnNum : totalcards/columnNum + 1
        let column = columnNum
        return (row, column)
    }
    
    func updateview(with recalculating: Bool){
        if recalculating {
            grid.dimensions = calcRowColumn(totalcards: currentCards.count)
        }
        setNeedsDisplay()
    }
    func initiate(){
        currentCards = [Card]()
        selectedCards = [Int]()
        hadmatched = (cards: [Int](),matched: false)
        matchedBoundaryColor = UIColor.black
    }
}
extension CardsView{
    private var cardZoomRatio: CGFloat {return 0.9 }
    var columnNum: Int  {return Int(bounds.width/100)}
}

extension CGRect{
    var cornerRad: CGFloat{
        return self.size.width * 0.1
    }

    func zoom(by scale: CGFloat) -> CGRect{
        let newwidth = width * scale
        let newheight = height * scale
        return insetBy(dx: (width-newwidth)/2, dy: (height-newheight)/2)
    }
}
