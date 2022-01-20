//
//  ScaleInOut.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2022/01/19.
//

import SwiftUI

struct DistortInOut: View {
    @State var characters = Array("目つむりていても吾を統ぶ五月の鷹")
    @State var switchOne: Bool = false
    @State var switchOne_Two: Bool = false
    @State var offsetXOne: CGFloat = 0
    
    var body: some View {
        VStack{
            Text("Distort In and Out").padding()
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    Text(String(self.characters[num]))
                        .font(.custom("HiraMinProN-W3", fixedSize: 28))
                        .offset(x: offsetXOne, y: 0)
                        .scaleEffect(x: 1, y: switchOne_Two ? 0 : 1)
                        .animation(.easeInOut.delay( Double(num) * 0.05 ), value: offsetXOne)
                        .animation(.easeInOut.delay( Double(num) * 0.05 ), value: switchOne_Two)
                }
            }
            .onTapGesture {
                switchOne_Two.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    offsetXOne = -500
                    switchOne.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    offsetXOne = 500
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    offsetXOne = 0
                    switchOne.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        switchOne_Two.toggle()
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
