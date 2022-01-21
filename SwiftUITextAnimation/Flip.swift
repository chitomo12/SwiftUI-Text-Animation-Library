//
//  Flip.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/21.
//

import SwiftUI

struct Flip: View {
    
    var body: some View {
        
        VStack {
            Text("Flip Animation")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding()
            
            FlipView(text: "どうしようもないわたしが", textSize: 24, startTime: 0.0)
            
            FlipView(text: "歩いている", textSize: 24, startTime: 0.0)
                .padding()
            
            FlipView(text: "種田山頭火", textSize: 16, startTime: 0.0)
                .padding()
            
        }
    }
}

struct FlipView: View {
    @State var flipSwitch: Bool = false
    @State var characters = Array("どうしようもないわたしが歩いている")
    @State var charactersTwo = Array("種田山頭火")
    
    @State var rotateValue: Double = 0
    
    @State var baseTime: Double
    
    @State var textSize: Double
    
    init(text:String, textSize: Double, startTime: Double) {
        characters = Array(text)
        self.textSize = textSize
        baseTime = startTime
    }
    
    var body: some View {
        
        HStack(spacing: 1){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .font(.custom("HiraMinProN-W3", fixedSize: textSize))
                    .rotation3DEffect(Angle(degrees: rotateValue),
                                      axis: (0.0, 1.0, 0.0))
                    .animation(.easeInOut.delay( Double(num) * 0.05 ),
                               value: rotateValue)
            }
        }.onTapGesture {
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
                rotateValue += 360
            }
        }
    }
}

struct Flip_Previews: PreviewProvider {
    static var previews: some View {
        Flip()
    }
}
