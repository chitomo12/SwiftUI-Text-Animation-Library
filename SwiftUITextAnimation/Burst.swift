//
//  Burst.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/20.
//

import SwiftUI

struct Burst: View {
    @State var characters = Array("縁日の古著屋多き夜寒かな")
    @State var charactersTwo = Array("正岡子規")
    @State var burstSwitch: Bool = true
    @State var charaScale: Double = 0
    
    var body: some View {
        VStack {
            Text("Burst Animation")
                .fontWeight(.heavy)
                .padding()
            
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    Text(String(self.characters[num]))
                        .font(.title)
                        .scaleEffect(charaScale)
                        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5).delay( Double(num) * 0.05 ), value: charaScale)
                }
            }.onAppear {
                if burstSwitch == true {
                    charaScale = 1
                } else {
                    charaScale = 0
                }
                burstSwitch.toggle()
            }.onTapGesture {
                if burstSwitch == true {
                    charaScale = 1
                } else {
                    charaScale = 0
                }
                burstSwitch.toggle()
            }
        }
        
    }
}

struct Burst_Previews: PreviewProvider {
    static var previews: some View {
        Burst()
    }
}
