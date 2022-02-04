//
//  Blur.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/21.
//

import SwiftUI

struct Blur: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Blur Animation")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            VStack(alignment: .leading) {
                BlurView(text: "どうしようもない", textSize: 38, startTime: 0.41)
                BlurView(text: "わたしが", textSize: 38, startTime: 1.85)
                BlurView(text: "歩いている", textSize: 38, startTime: 2.76)
                BlurView(text: "種田山頭火", textSize: 16, startTime: 3.76)
                        .padding(.top, 30)
            }
        }
    }
}

struct BlurView: View {
    let characters: Array<String.Element>
    let baseTime: Double
    let textSize: Double
    @State var blurValue: Double = 10
    @State var opacity: Double = 0
    
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
                    .blur(radius: blurValue)
                    .opacity(opacity)
                    .animation(.easeInOut.delay( Double(num) * 0.15 ),
                               value: blurValue)
            }
        }.onTapGesture {
            if blurValue == 0 {
                blurValue = 10
                opacity = 0.01
            } else {
                blurValue = 0
                opacity = 1
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


struct Blur_Previews: PreviewProvider {
    static var previews: some View {
        Blur()
    }
}

