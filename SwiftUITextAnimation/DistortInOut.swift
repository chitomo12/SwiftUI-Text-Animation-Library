//
//  ScaleInOut.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2022/01/19.
//

import SwiftUI

struct DistortInOut: View {
    let characters = Array("秋空を二つに断てり椎大樹")
    @State var scaleSwitch: Bool = false
    @State var TextOffsetX: CGFloat = 0
    
    var body: some View {
        VStack{
            Text("Distort In and Out").padding()
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    Text(String(self.characters[num]))
                        .font(.custom("HiraMinProN-W3", fixedSize: 24))
                        .offset(x: TextOffsetX, y: 0)
                        .scaleEffect(x: 1, y: scaleSwitch ? 0 : 1)
                        .animation(.easeInOut.delay( Double(num) * 0.05 ), value: TextOffsetX)
                        .animation(.easeInOut.delay( Double(num) * 0.05 ), value: scaleSwitch)
                }
            }
            .onTapGesture {
                scaleSwitch.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    TextOffsetX = -500
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    TextOffsetX = 500
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    TextOffsetX = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        scaleSwitch.toggle()
                    }
                }
            }
        }
    }
}

struct ScaleInOut_Previews: PreviewProvider {
    static var previews: some View {
        DistortInOut()
    }
}
