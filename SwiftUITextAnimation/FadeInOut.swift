//
//  FadeInOut.swift
//  SwiftUITextAnimation
//
//  Created by 福田正知 on 2022/01/20.
//

import SwiftUI

struct FadeInOut: View {
    @State var characters = Array("縁日の古著屋多き夜寒かな")
    @State var charactersTwo = Array("正岡子規")
    @State var opacity: Double = 0
    
    
    var body: some View {
        VStack{
            Text("Fade In and Out")
                .fontWeight(.heavy)
                .padding()
        
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    Text(String(self.characters[num]))
                        .font(.title)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( Double(num) * 0.05 ),
                                   value: opacity)
                }
            }
            .onAppear {
                opacity = 1
            }
            .onTapGesture {
                opacity = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    opacity = 1
                }
            }
        }
    }
}

struct FadeInOut_Previews: PreviewProvider {
    static var previews: some View {
        FadeInOut()
    }
}
