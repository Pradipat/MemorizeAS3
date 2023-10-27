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
    
    @State private var emojis: [String]
    @State var cardCount: Int

        init() {
            let initialEmojis = emojiSet1
            
            self._emojis = State(initialValue: initialEmojis)
            self._cardCount = State(initialValue: initialEmojis.count)
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
                    .aspectRatio(2.1/3, contentMode: .fit)
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
    
    func themeAdjuster(by offset: String, symbol: String, name: String) -> some View {
        Button(action: {
            switch offset {
            case "emojiSet1":
                emojis = emojiSet1
            case "emojiSet2":
                emojis = emojiSet2
            case "emojiSet3":
                emojis = emojiSet3
            default:
                break
            }
            cardCount = emojis.count
            emojis.shuffle()
        }) {
            VStack {
                Image(systemName: symbol)
                Text(name)
                    .font(.footnote)
            }
        }
    }

    var halloweenTheme: some View {
        themeAdjuster(by: "emojiSet1", symbol: "moon.stars.fill" , name: "Halloween")
    }
    var carTheme: some View {
        themeAdjuster(by: "emojiSet2", symbol: "car.side.fill" , name: "Car")
    }
    var fruitTheme: some View {
        themeAdjuster(by: "emojiSet3", symbol: "applelogo" , name: "Fruit")
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
