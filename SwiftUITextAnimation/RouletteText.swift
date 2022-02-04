//
//  RouletteText.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/02/04.
//

import SwiftUI

struct RouletteText: View {
    var body: some View {
        VStack(alignment:.leading){
            RouletteCharacters(text: "To be or", delay: 0.3)
            RouletteCharacters(text: "not to be,", delay: 1.3)
            RouletteCharacters(text: "that is the", delay: 1.8)
            RouletteCharacters(text: "question.", delay: 2.3)
        }
        .padding()
    }
}

struct RouletteCharacters: View {
    let characters: Array<String.Element>
    let fontSize: Float = 78
    var delay: Double
    
    init(text: String, delay: Double){
        self.characters = Array(text)
        self.delay = delay
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    RouletteCharacter(characters: String(characters),
                                      finalCharacter: String(characters[num]),
                                      number: num,
                                      fontSize: fontSize,
                                      baseTime: delay)
                }
                Spacer()
            }
        }
    }
}

struct RouletteCharacter: View {
    @State var characters: Array<String.Element>
    @State var finalCharacter: String
    @State var separatedCharacter: String
    @State var timer: Timer!
    @State var number: Int
    @State var fontSize: Float
    @State var baseTime: Double
    @State var opacity: Double = 0
    var speedDuration: Double = 0.2
    
    init(characters: String, finalCharacter: String, number: Int, fontSize: Float, baseTime: Double){
        self.characters = Array(characters)
        self.finalCharacter = finalCharacter
        self.separatedCharacter = finalCharacter
        self.number = number
        self.fontSize = fontSize
        self.baseTime = baseTime
    }
    
    var body: some View {
        Text(String(separatedCharacter))
            .font(.custom("Arial", size: CGFloat(fontSize)))
            .fontWeight(.heavy)
            .foregroundColor(Color(CGColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)))
            .opacity(opacity)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + (baseTime / 4) + speedDuration * Double(1 + number)){
                    withAnimation(.linear(duration: 0.2)) {
                        opacity = 1
                    }
                }
                startTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + (baseTime + speedDuration * Double(1 + number))) {
                    stopTimer()
                    separatedCharacter = finalCharacter
                }
        }
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05,
                                          repeats: true, block: { _ in
            // shuffle and set characters.
            separatedCharacter = String(characters[Int.random(in: 0..<characters.count)])
        })
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

struct Roulette_Previews: PreviewProvider {
    static var previews: some View {
        RouletteText()
    }
}
