//
//  ContentView.swift
//  Memorize
//
//  Created by Class Demo on 5/10/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojiSet1 = ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"] + ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"]
    let emojiSet2 = ["🚗","🚎","🛻","🛵","🚛","🚑","🚜","🏎️"] + ["🚗","🚎","🛻","🛵","🚛","🚑","🚜","🏎️"]
    let emojiSet3 = ["🍊","🍋","🍌","🍇","🍑","🍎","🍏","🍓"] + ["🍊","🍋","🍌","🍇","🍑","🍎","🍏","🍓"]
    let emojis = ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"] + ["👻", "🎃", "🕷️", "👹", "💀", "🕸️", "🧙", "🙀"]
    
    @State var cardCount: Int
        init() {
            _cardCount = State(initialValue: emojis.count)
        }
    
    var body: some View {
        VStack {
            Text("Memorize")
                .foregroundColor(.blue)
                .font(.largeTitle)
                .bold()
            Spacer()
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    
    var cardCountAdjusters: some View {
        HStack {
            Spacer()
            halloweenTheme
            Spacer()
            carTheme
            Spacer()
            fruitTheme
            Spacer()
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "moon.stars.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func themeAdjuster(by offset: String, symbol: String, name: String) -> some View {
        Button(action: {
            // กระทำที่นี่เมื่อปุ่มถูกกด
        }) {
            VStack {
                Image(systemName: symbol)
                Text(name)
                    .font(.footnote)
            }
        }
    }

    var halloweenTheme: some View {
        themeAdjuster(by: "halloween", symbol: "moon.stars.fill" , name: "Halloween")
    }
    var carTheme: some View {
        themeAdjuster(by: "car", symbol: "car.side.fill" , name: "Car")
    }
    var fruitTheme: some View {
        themeAdjuster(by: "fruit", symbol: "applelogo" , name: "Fruit")
    }
    
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}
