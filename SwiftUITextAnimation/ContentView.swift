//
//  ContentView.swift
//  SwiftUITextAnimationApp
//
//  Created by 福田正知 on 2021/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    var body: some View {
        ZStack{
//            WaveForm(color: .purple, amplify: 100.0)
            Spinner()
        }
        .ignoresSafeArea()
    }
}

struct Spinner: View {
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
                    .trim(from: 0.1,
                          to: 0.8)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .padding(.top,100)
                
                Rectangle()
                    .trim(from: animationSwitch ? start : start2,
                          to: end)
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .padding(.top, 50)
                    .animation(.spring(response: responseValue,
                                       dampingFraction: dampingValue,
                                       blendDuration: blendDuration)
                                .repeatForever(autoreverses: true),
                               value: animationSwitch)

                Rectangle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .rotationEffect(animationSwitch ? rotation : rotation + .degrees(90))
                    .padding(.top, 50)
                    .animation(.spring(response: responseValue,
                                       dampingFraction: dampingValue,
                                       blendDuration: blendDuration)
                                .repeatForever(autoreverses: false),
                               value: animationSwitch)
                
                Circle()
                    .trim(from: start, to: end)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .foregroundColor(Color(hue: 0.713, saturation: 0.582, brightness: 1.0))
                    .rotationEffect(animationSwitch ? rotation : rotation + .degrees(360))
                    .scaleEffect(animationSwitch ? 0.3 : 0.3)
                    .animation(.spring(response: responseValue,
                                       dampingFraction: dampingValue,
                                       blendDuration: blendDuration)
                                .repeatForever(autoreverses: false),
                               value: animationSwitch)
            }
            
            Text("response: \(responseValue)")
            Slider(value: $responseValue).padding(.horizontal)
            
            Text("dampingFraction: \(dampingValue)")
            Slider(value: $dampingValue).padding(.horizontal)
            
            Text("dampingFraction: \(blendDuration)")
            Slider(value: $blendDuration).padding(.horizontal)
            
            Button(action:{
                animationSwitch.toggle()
            }){
                Text("Tap Here").padding(.bottom, 100)
            }
        }
    }
}

struct WaveForm: View{
    
    var color: Color
    var amplify: CGFloat
    
    var body: some View {
        TimelineView(.animation) { timeLine in
            Canvas{ context, size in
                
                let timeNow = timeLine.date.timeIntervalSinceReferenceDate
                
                let angle = timeNow.remainder(dividingBy: 2)
                let offset = angle * size.width
                
                context.draw(Text("\(offset)"), at: CGPoint(x: size.width / 2, y: 100))
                
                context.translateBy(x: offset, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                context.translateBy(x: -size.width, y:0)
                
                context.fill(getPath(size: size), with: .color(color))
                context.translateBy(x: size.width * 2, y: 0)
                context.fill(getPath(size: size), with: .color(color))
            }
        }
    }
    
    func getPath(size: CGSize) -> Path {
        return Path{ path in
            let midHeight = size.height / 2
            let width = size.width
            path.move(to: CGPoint(x: 0, y: midHeight))
            path.addCurve(to: CGPoint(x: width, y: midHeight),
                          control1: CGPoint(x: width * 0.5, y: midHeight + amplify),
                          control2: CGPoint(x: width * 0.5, y: midHeight - amplify))
            
            path.addLine(to: CGPoint(x: width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            
        }
    }
}

