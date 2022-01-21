//
//  TrimTest.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2021/12/20.
//

import SwiftUI

struct TrimTest: View {
    @State var start: CGFloat = 0.0
    @State var start2: CGFloat = 1.0
    @State var end: CGFloat = 0.5
    @State var end2: CGFloat = 0.9
    var rotation: Angle = .degrees(0)
    @State var animationSwitch: Bool = false
    @State var responseValue: Double = 0.5
    @State var dampingValue: Double = 0.5
    @State var blendDuration: Double = 0.5
    
    var body: some View {
        VStack{
            Group{
                Rectangle()
                    .trim(from: start,
                          to: animationSwitch ? 0.75 : end)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .padding(.top,100)
                
                Rectangle()
                    .trim(from: animationSwitch ? 0.0 : 0.0,
                          to: animationSwitch ? 1 : 0)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .padding(.top, 50)
                    .animation(.spring(response: responseValue,
                                       dampingFraction: dampingValue,
                                       blendDuration: blendDuration)
                                .repeatForever(autoreverses: true),
                               value: animationSwitch)
            }
            
            HStack{
                Text("start: \(start)")
                Slider(value: $start).padding(.horizontal)
            }
            
            HStack{
                Text("end: \(end)")
                Slider(value: $end).padding(.horizontal)
            }
            
            HStack{
                Text("response: \(responseValue)")
                Slider(value: $responseValue).padding(.horizontal)
            }
            
            HStack{
                Text("dampingFraction: \(dampingValue)")
                Slider(value: $dampingValue).padding(.horizontal)
            }
            HStack{
                Text("dampingFraction: \(blendDuration)")
                Slider(value: $blendDuration).padding(.horizontal)
            }
            Button(action:{
                animationSwitch.toggle()
            }){
                Text("Tap Here").padding(.bottom, 100)
            }
        }.padding()
    }
}

struct TrimTest_Previews: PreviewProvider {
    static var previews: some View {
        TrimTest()
    }
}
