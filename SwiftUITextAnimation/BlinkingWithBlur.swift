//
//  Blinking.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/22.
//

import SwiftUI

struct BlinkingWithBlurSample: View {
    let textSize: Double = 30
    
    var body: some View {
        VStack{
            BlinkingWithBlur(text: "Demain, dès l’aube,",
                             fontName: "Didot",
                             textSize: textSize,
                             startTime: 0.1)
            BlinkingWithBlur(text: "à l'heure",
                             fontName: "Didot",
                             textSize: textSize,
                             startTime: 0.3)
            BlinkingWithBlur(text: "où blanchit la campagne",
                             fontName: "Didot",
                             textSize: textSize,
                             startTime: 0.5)
            BlinkingWithBlur(text: "Je partirai. Vois-tu,",
                             fontName: "Didot",
                             textSize: textSize,
                             startTime: 0.7)
            BlinkingWithBlur(text: "je sais que tu m'attends.",
                             fontName: "Didot",
                             textSize: textSize,
                             startTime: 0.9)
            
            BlinkingWithBlur(text: "Victor Hugo",
                             fontName: "Didot",
                             textSize: 24,
                             startTime: 2.5)
                .padding(.top,100)
        }
    }
}

struct BlinkingWithBlur: View {
    let characters: Array<String.Element>
    let fontName: String
    let baseTime: Double
    let textSize: Double
    
    @State var blurValue: Double = 10
    @State var opacity: Double = 0
    
    init(text:String, fontName: String, textSize: Double, startTime: Double) {
        self.characters = Array(text)
        self.fontName = fontName
        self.textSize = textSize
        self.baseTime = startTime
    }
    
    var body: some View {
        
        HStack(spacing: 0.5){
            ForEach(0..<characters.count) { num in
                ZStack{
                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize * 1.0))
                        .blur(radius: blurValue)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 0.5 * Double.random(in: 0.003...0.55)),
                                   value: blurValue)
                    
                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize * 0.9))
                        .blur(radius: blurValue)
                        .foregroundColor(.white)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 0.5 * Double.random(in: 0.003...0.55)),
                                   value: blurValue)
                    
                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize*1.0))
                        .blur(radius: blurValue)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 1 * Double.random(in: 0.10...0.3)),
                                   value: blurValue)
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
                if blurValue == 0{
                    blurValue = 10
                    opacity = 0.01
                } else {
                    blurValue = 0
                    opacity = 1
                }
            }
        }
    }
}

struct Blinking_Previews: PreviewProvider {
    static var previews: some View {
        BlinkingWithBlurSample()
    }
}
