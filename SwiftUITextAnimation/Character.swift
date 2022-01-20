//
//  Character.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2021/12/21.
//

import SwiftUI

struct Character: View {
    @State var characters = Array("秋空を二つに断てり椎大樹")
    @State var switchOne: Bool = false
    @State var switchOne_Two: Bool = false
    @State var offsetXOne: CGFloat = 0
    @State var switchTwo: Bool = false
    @State var switchThree: Bool = false
    @State var switchFour: Bool = false
    @State var offsetYFive: CGFloat = 50
    @State var fiveOpacity: CGFloat = 0
    @State var fifthGroupOpacity: CGFloat = 1.0
    
    var body: some View {
        NavigationView{
            VStack{
                CharacterAnimationView(text: "Code With Animation")
                    .padding()
                
//                HStack(spacing:0){
//                    ForEach(0..<characters.count) { num in
//                        Text(String(self.characters[num]))
//                            .font(.title)
//                            .offset(x: offsetXOne, y: 0)
//                            .scaleEffect(x: 1, y: switchOne_Two ? 0 : 1)
//                            .animation(.easeInOut.delay( Double(num) * 0.05 ))
//                    }
//                }.onTapGesture {
//                    switchOne_Two.toggle()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        offsetXOne = -500
//                        switchOne.toggle()
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                        offsetXOne = 500
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                        offsetXOne = 0
//                        switchOne.toggle()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                            switchOne_Two.toggle()
//                        }
//                    }
//                }
                
                HStack(spacing:0){
                    ForEach(0..<characters.count) { num in
                        Text(String(self.characters[num]))
                            .font(.title)
                            .opacity(switchTwo ? 0 : 1)
                            .animation(.easeInOut.delay( Double(num) * 0.05 ))
                    }
                }.onTapGesture {
                    switchTwo.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        switchTwo.toggle()
                    }
                }
                
                
                HStack(spacing: 1){
                    ForEach(0..<characters.count) { num in
                        Text(String(self.characters[num]))
                            .font(.title)
                        //                        .opacity(switchThree ? 0 : 1)
                            .rotation3DEffect(Angle(degrees: switchThree ? 360 : 0), axis: (0.0, 1.0, 0.0))
                            .animation(.easeInOut.delay( Double(num) * 0.05 ).repeatCount(1, autoreverses: true))
                    }
                    
                }.onTapGesture {
                    switchThree.toggle()
                    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    //                    switchThree.toggle()
                    //                }
                }
                
                HStack(spacing:0){
                    ForEach(0..<characters.count) { num in
                        Text(String(self.characters[num]))
                            .font(.title)
                            .scaleEffect(switchFour ? 0 : 1)
                            .animation(.easeInOut.delay( Double(num) * 0.05 ))
                    }
                }.onTapGesture {
                    switchFour.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        switchFour.toggle()
                    }
                }
                
                HStack(spacing:0){
                    ForEach(0..<characters.count) { num in
                        Text(String(self.characters[num]))
                            .font(.title)
                            .scaleEffect(switchFour ? 0 : 1)
                            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5).delay( Double(num) * 0.05 ))
                    }
                }.onAppear {
                    switchFour.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        switchFour.toggle()
                    }
                }
                
                HStack(spacing:0){
                    ForEach(0..<characters.count) { num in
                        Text(String(self.characters[num]))
                            .font(.title)
                            .offset(x: 0.0, y: offsetYFive)
                            .opacity(fiveOpacity)
                            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5).delay( Double(num) * 0.1 ))
                            .onAppear {
                                offsetYFive = 50
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    fiveOpacity = 1
                                    offsetYFive = 0
                                }
                            }
                    }.opacity(fifthGroupOpacity)
                }
                
                NavigationLink(destination: Block()) {
                    Text("Block Sample")
                }
                NavigationLink(destination: Bounce()) {
                    Text("Bounce")
                }
            }
        }
    }
}

struct CharacterAnimationView: View {
    //    var text: String
    @State var dragValue = CGSize.zero
    @State var characters: Array<String.Element>
    
    init(text: String){
        self.characters = Array(text)
    }
    
    var body: some View {
        HStack(spacing: 1){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .font(.body)
                    .offset(self.dragValue)
                    .animation(.easeInOut.delay( Double(num) * 0.05 ))
            }
            
        }.gesture(
            DragGesture()
                .onChanged{ self.dragValue = $0.translation }
                .onEnded{ _ in
                    self.dragValue = CGSize(width: 0, height: 0)
                }
        )
    }
    
}

struct Character_Previews: PreviewProvider {
    static var previews: some View {
        Character()
    }
}
