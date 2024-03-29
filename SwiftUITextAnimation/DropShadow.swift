//
//  DropShadow.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/22.
//

import SwiftUI

struct DropShadowSample: View {
    var body: some View{
        VStack {
            DropShadow(text: "行秋や芒痩せたる影法師",
                       textSize: 26,
                       startTime: 0.1)
            DropShadow(text: "寺田寅彦",
                       textSize: 24,
                       startTime: 0.1)
                    .padding()
        }
    }
}

struct DropShadow: View {
    let characters: String
    let baseTime: Double
    let textSize: Double
    @State var shadowSize: Double = 0
    @State var offsetX: Double = 0
    @State var offsetY: Double = 0
    
    init(text:String, textSize: Double, startTime: Double) {
        self.characters = text
        self.textSize = textSize
        self.baseTime = startTime
    }
    
    var body: some View {
        Text(characters)
            .font(.custom("HiraMinProN-W3", fixedSize: textSize))
            .offset(x: offsetX, y: offsetY)
            .animation(.easeInOut, value: offsetX)
            .shadow(color: .black.opacity(0.8),
                    radius: shadowSize, x: shadowSize, y: shadowSize)
            .animation(.easeInOut, value: shadowSize)
            .onTapGesture {
                animate(delayTime: 0.0)
            }
            .onAppear{
                animate(delayTime: 0.2)
            }
    }
    
    func animate(delayTime: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 + delayTime) {
            shadowSize = 0
            self.offsetX = 2
            self.offsetY = 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 + delayTime) {
            shadowSize = 6
            self.offsetX = -6
            self.offsetY = -6
        }
    }
}

struct DropShadow_Previews: PreviewProvider {
    static var previews: some View {
        DropShadowSample()
    }
}
