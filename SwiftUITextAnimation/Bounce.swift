//
//  Bounce.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/20.
//

import SwiftUI

struct Bounce: View {
    var body: some View {
        VStack {
            Text("Bounce Animation")
                .fontWeight(.heavy)
                .padding()
            
            BounceAnimationView(text: "枯菊や日日にさめゆくいきどほり", startTime: 0.0)
                .padding()
            
            BounceAnimationView(text: "萩原朔太郎", startTime: 1.5)
                .padding()
        }
    }
}

struct BounceAnimationView: View {
    @State var characters: Array<String.Element>
    
    @State var offsetYForBounce: CGFloat = -50
    @State var opacity: CGFloat = 0
    @State var groupOpacity: CGFloat = 1
    
    @State var baseTime: Double
    
    init(text: String, startTime: Double){
        self.characters = Array(text)
        self.baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .font(.custom("HiraMinProN-W3", fixedSize: 26))
                    .offset(x: 0.0, y: offsetYForBounce)
                    .opacity(opacity)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay( Double(num) * 0.1 ), value: offsetYForBounce)
            }
            .opacity(groupOpacity)
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    opacity = 0
                    offsetYForBounce = -50
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + (0.8 + baseTime)) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
        }
    }
}

struct Bounce_Previews: PreviewProvider {
    static var previews: some View {
        Bounce()
    }
}
