//
//  WithAnimationTest.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2021/12/20.
//

import SwiftUI

struct WithAnimationTest: View {
    @State var rotation: Angle = .degrees(0)
    @State var scaleValue: Double = 1.0
    @State var offsetX: CGFloat = 0.0
    
    @State var offsetXone: CGFloat = 500
    @State var offsetXtwo: CGFloat = 500
    @State var offsetXthree: CGFloat = 500
    
    @State var rectangleAnimationSwitch: Bool = false
    @State var start: Double = 0.0
    @State var end: Double = 0.9
    
    @State var imageOffsetX: CGFloat = 0
    @State var maskAnimationSwitch: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello WithAnimation!")
                .rotationEffect(rotation)
                .scaleEffect(scaleValue)
                .offset(x: offsetX, y: 0)
                .padding()
            
            Group{
                Text("Hello Again!")
                    .font(.title)
                    .offset(x: offsetXone, y: 0)
                Text("Hello Again!")
                    .font(.title)
                    .offset(x: offsetXtwo, y: 0)
                Text("Hello Again!")
                    .font(.title)
                    .offset(x: offsetXthree, y: 0)
            }
            
            ZStack{
                Rectangle()
                    .trim(from: rectangleAnimationSwitch ? 0.4 : 0.0,
                          to: rectangleAnimationSwitch ? 0.5: 0.9)
                    .frame(width: 200, height: 50, alignment: .center)
                Text("WELCOME")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            
            Group{
                Button("Tap Here"){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        withAnimation(.spring()) {
                            rotation += .degrees(360)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            scaleValue = 2.0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.spring()) {
                            scaleValue = 1.0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(Animation.easeInOut) {
                            offsetX = 500
                        }
                    }
                }
                .padding()
                Button("Change Scale"){
                    withAnimation(.spring()) {
                        scaleValue = 3.0
                    }
                }
                Button("Tap Here 3"){
                    withAnimation(.easeInOut) {
                        offsetXone = 0
                    }
                    withAnimation(.easeInOut.delay(0.3)) {
                        offsetXtwo = 0
                    }
                    withAnimation(.easeInOut.delay(0.6)) {
                        offsetXthree = 0
                    }
                }.padding()
                Button("Tap Here 4"){
                    withAnimation(.easeInOut) {
                        start = 0.4
                        end = 0.5
                        rectangleAnimationSwitch.toggle()
                    }
                }
            }
            
            Text("SampleText")
                .font(.system(size: 30, weight: .ultraLight))
                
            
            Group{
                Image("SampleOne")
                    .frame(width: 300, height: 160, alignment: .center)
                    .offset(x: maskAnimationSwitch ? imageOffsetX * 150 : imageOffsetX * -150,
                            y: 0)
                    .mask {
                        Text("MASK\nNOW")
                            .font(.system(size: 40, weight: .heavy))
                            .multilineTextAlignment(.center)
                    }
                Slider(value: $imageOffsetX)
                Button("Tap Here 5"){
                    withAnimation(.easeInOut) {
                        maskAnimationSwitch.toggle()
                    }
                }
            }
        }
    }
}

struct WithAnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        WithAnimationTest()
    }
}
