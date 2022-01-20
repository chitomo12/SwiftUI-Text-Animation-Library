//
//  Block.swift
//  WaveAnimation
//
//  Created by 福田正知 on 2022/01/19.
//

import SwiftUI

struct Block: View {
    @State var characters = Array("秋空を二つに断てり椎大樹")
    
    @State var rectHeight: CGFloat = 0
    @State var rectOpacity: Double = 1
    
    @State var pathWidth: CGFloat = 100
    @State var pathHeight: CGFloat = 50
    @State var rectOffsetX: CGFloat = 0
    
    @State var rectScale: Double = 0
    @State var rectAnchor: UnitPoint = .leading
    
    @State var textOpacity: Double = 0.0
    
    let baseTime: Double = 1.0
    
    var body: some View {
        ZStack {
            Color(cgColor: CGColor(red: 255/256, green: 92/256, blue: 40/256, alpha:1)).ignoresSafeArea()
            
            VStack(alignment: .leading){
                Text("Block Reveal Animation")
                    .fontWeight(.heavy)
                ZStack {
                    Text(String(characters))
                        .font(.title)
                        .opacity(textOpacity)
                        .background(GeometryReader{ geometry -> Text in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                rectHeight = geometry.frame(in: .local).height
                                pathWidth = geometry.frame(in: .local).width
                                pathHeight = geometry.frame(in: .local).height
                            }
                            return Text("")
                        })
                    Rectangle()
                        .offset(x: rectOffsetX, y: 0)
                        .scale(x: rectScale, y: 1, anchor: rectAnchor)
                        .frame(width: pathWidth, height: pathHeight, alignment: .center)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 + baseTime) {
                                withAnimation(.easeInOut) {
                                    rectScale = 1
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + baseTime) {
                                textOpacity = 1.0
                                rectAnchor = .trailing
                                withAnimation(.easeInOut){
                                    rectScale = 0.0
                                }
                            }
                        }
                }
                .frame(height: rectHeight)
                .onTapGesture {
                    rectAnchor = .leading
                    textOpacity = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut) {
                            rectScale = 1
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        textOpacity = 1.0
                        rectAnchor = .trailing
                        withAnimation(.easeInOut){
                            rectScale = 0.0
                        }
                    }
                }
                Image("sampleImage1")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(height: 200)
                    .clipped()
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                
                HStack{
                    Spacer()
                    Button(action: {
                        blockAnimation()
                    }, label: {
                        Text("Push to Animate")
                    })
                    Spacer()
                }.padding()
            }.padding()
            
        }
        
    }
    
    func blockAnimation(){
        rectAnchor = .leading
        textOpacity = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut) {
                rectScale = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            textOpacity = 1.0
            rectAnchor = .trailing
            withAnimation(.easeInOut){
                rectScale = 0.0
            }
        }
    }
}

struct Block_Previews: PreviewProvider {
    static var previews: some View {
        Block()
    }
}
