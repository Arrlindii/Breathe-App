//
//  CardStackView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 09.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

enum CardPosition {
    case top, bottomn
}

struct Card: Identifiable {
    var id: Int
    var isDragging: Bool = false
    var percentPresented: CGFloat = 0.0
    var position: CardPosition = .bottomn {
        didSet {
            self.percentPresented = (position == .top) ? 1.0 : 0.0
        }
    }
}

struct DraggableCardView<Content: View>: View {
    var contentView: Content
    @Binding var card: Card
    
    private let minimumY: CGFloat = 0
    private let maximumY: CGFloat = UIScreen.main.bounds.height*0.67
    
    var body: some View {
        let dragGesture = DragGesture().onChanged({ value in
            self.card.isDragging = true
            
            
            var offsetY = value.location.y - value.startLocation.y
            
            if offsetY < 0 { //Draging from bottom to the top
                offsetY = value.location.y - abs(offsetY)
            }
            
            let y = min(self.maximumY, max(self.minimumY, offsetY))
            self.card.percentPresented = 1 - (y/(self.maximumY - self.minimumY))
        }).onEnded { _ in
            self.card.isDragging = false
            
            withAnimation(.easeIn(duration: 0.2)) {
                self.card.position = (self.card.percentPresented < 0.5) ? .bottomn :  .top
            }
        }
        
        return
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(Color.darkGrayColor)
                .overlay(self.contentView)
                .overlay(RoundedRectangle(cornerRadius: 8.0)
                .strokeBorder(Color.textGray, style: StrokeStyle.init(lineWidth: 0.5)))
                .offset(x: 0, y: (1 - self.card.percentPresented)*(maximumY - minimumY))
                .gesture(dragGesture)
    }
}

struct CardStackView<Content: View>: View {
    @Binding var cards: [Card]
    var onCardSelected: ((Card) -> Void)
    var cardContentViews: [Content]
    
    private var bottomnCards: [Card] {
        return cards.filter {
            $0.position == .bottomn
        }
    }
    
    private var topCards: [Card] {
        return cards.filter {
            $0.position == .top
        }
    }

    var animationDuration: Double
    
    var body: some View {
        ZStack {
            ForEach(0..<self.cards.count) { i in
                self.cardAt(i)
            }
        }
    }

    func cardAt(_ i: Int) -> some View {
        let card = cards[i]
        let scale = self.cardScale(card)
        let offset = self.cardOffset(card)
        var zIndex = 0
        
        let cardView = DraggableCardView(contentView: cardContentViews[i],
                                         card: self.$cards[i])
        .onTapGesture {
            self.onCardSelected(card)
        }
        
        if card.isDragging {
            zIndex = self.cards.count
        } else {
            zIndex = (card.position == .top) ? (self.cards.count - i - 1) : 0
        }
           
        return cardView
            .padding(.horizontal, 30)
            .padding(.vertical, (UIScreen.main.bounds.height*0.4)/2)
            .offset(y: offset)
            .scaleEffect(scale)
            .zIndex(Double(zIndex)
        )
    }
    
    func cardScale(_ card: Card) -> CGFloat {
        let topIndex = self.topCards.firstIndex(where: {$0.id == card.id})
        let bottomIndex = self.bottomnCards.firstIndex(where: {$0.id == card.id})
        
        if let index = bottomIndex {
            return 1 - CGFloat(bottomnCards.count - index)*0.03
        } else if let index = topIndex {
            return 1 - CGFloat(index)*0.05
        }
        return 1
    }
    
    func cardOffset(_ card: Card) -> CGFloat {
        let topIndex = self.topCards.firstIndex(where: {$0.id == card.id})
         let bottomIndex = self.bottomnCards.firstIndex(where: {$0.id == card.id})
         
         if let index = bottomIndex {
             return CGFloat(index)
         } else if let index = topIndex {
             return 20*CGFloat(index)
         }
         return 0
    }
    
    
}
