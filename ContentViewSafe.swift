//
//  ContentView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 30.09.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

struct DraggableCardView: View {
    @State var offset: CGPoint = CGPoint.zero
    @Binding var isVisible: Bool
    @Binding var isDragging: Bool
    var color: Color
    var contentView: CardContentView
    var cardSize = CGSize(width: 300, height: 450)
    
    private let minimumY: CGFloat = 0
    private var maximumY: CGFloat {
        get {
            UIScreen.main.bounds.height*0.6
        }
    }

    var percentChanged:CGFloat {
        get {
            return self.offset.y/(maximumY - minimumY)
        }
    }
    
    var body: some View {
        let dragGesture = DragGesture().onChanged({ value in
            self.isDragging = true
              
            var offsetY = value.location.y - value.startLocation.y
            
            if offsetY < 0 { //Draging from bottom to the top
                offsetY = value.location.y - abs(offsetY)
            }
            
            let y = min(self.maximumY, max(self.minimumY, offsetY))
            let changedPoints = CGPoint(x: 0, y: y)
            self.offset = changedPoints
        }).onEnded { _ in
            if self.percentChanged > 0.5 {
                //Push it to the bottomn
                withAnimation(.easeIn(duration: 0.2)) {
                    self.offset = CGPoint(x: 0, y: self.maximumY)
                    self.isVisible = false
                }
            } else {
                //Push it to the top again
                withAnimation(.easeIn(duration: 0.2)) {
                    self.offset = CGPoint.zero
                    self.isVisible = true
                }
            }
            self.isDragging = false
        }
        
        return RoundedRectangle(cornerRadius: 5.0)
            .foregroundColor(self.color)
            .overlay(contentView)
            .overlay(RoundedRectangle(cornerRadius: 5.0)
                .strokeBorder(Color.white))
            .frame(width: cardSize.width, height: cardSize.height)
            .offset(x: 0, y: self.offset.y)
            .gesture(dragGesture)
    }
}

struct CardContentView: View {
    var body: some View {
        Text("Classic")
        .foregroundColor(Color.white)
    }
}

//Mark: Model
struct Card {
    var id: Int
    @Binding var visibillity: Bool
    @Binding var isDragging: Bool
}

extension Card: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class CardStack {
//    var allCards: [Card] = []
//    var topCards: [Card] {
//        return allCards.filter {$0.visibillity == true}
//    }
//    var bottomCards: [Card] {
//        return allCards.filter {$0.visibillity == false}
//    }
//
//    init(cards: [Card]) {
//        self.allCards = cards
//    }
//
//    func cardZIndex(_ card: Card) {
//        if topCards.contains(card) {
//            return topCards.index(of: card)
//        } else {
//            return
//        }
//    }
}
//

struct CardStackView: View {
    @State var visibillity: [Bool] = [false, false, false, false]
    @State var isDragging: [Bool] = [false, false, false, false]
    
    private var cards: [Card] {
        return [
            Card(id: 1, visibillity: $visibillity[0], isDragging: $isDragging[0]),
            Card(id: 2, visibillity: $visibillity[1], isDragging: $isDragging[1]),
            Card(id: 3, visibillity: $visibillity[2], isDragging: $isDragging[2]),
            Card(id: 4, visibillity: $visibillity[3], isDragging: $isDragging[3]),
        ]
    }
        
    
    var body: some View {
        ZStack {
            ForEach(0..<cards.count) { i in
                return self.cardAt(i)
            }
        }
    }
    
    func cardAt(_ i: Int) -> some View {
        let scale = 1 - CGFloat(i)*0.05
        let offset = 20*CGFloat(i)
        let card = self.cards[i]
        let cardView = DraggableCardView(isVisible: card.$visibillity, isDragging: card.$isDragging ,color: card.visibillity ? Color.red : Color.yellow, contentView: CardContentView())
        
        if card.isDragging {
            return cardView
            .offset(x: 0, y: offset)
            .scaleEffect(scale)
            .zIndex(Double(cards.count))
        } else {
            return cardView
            .offset(x: 0, y: offset)
            .scaleEffect(scale)
            .zIndex(visibillity[i] ? Double(self.cards.count - i - 1) : 0)
        }
    }
}

struct ContentView : View {
    var body: some View {
      CardStackView()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .background(Color.gray)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
