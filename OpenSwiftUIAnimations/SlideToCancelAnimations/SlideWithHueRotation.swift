//
//  SlideWithRotation.swift
//  SwiftUICallingKit
//

import SwiftUI

struct SlideWithHueRotation: View {
    @State private var counter: Int = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isSliding: Bool = false
    @State private var isShimmering = false
    let letters = Array("Slide to cancel")
    
    let slideGently = Animation.easeOut(duration: 0.5).delay(2).repeatForever(autoreverses: false).delay(-0.67)
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                HStack {
                    HStack{
                        Image(systemName: "mic.fill")
                            .font(.title)
                            .bold()
                            .opacity(isSliding ? 0 : 1)
                            .foregroundColor(Color(.systemRed))
                            .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isSliding)
                        
                        Text("\(counter)")
                            .monospacedDigit()
                            .onReceive(timer) { _ in
                                counter += 1
                            }
                    }
                    
                    Spacer()
                    
                    HStack {
                        HStack(spacing: 0) {
                            ForEach(0..<letters.count, id: \.self) { slide in
                                Text(String(letters[slide]))
                                    .foregroundColor(.blue)
                                    .hueRotation(.degrees(isSliding ? 320 : 0))
                                    .opacity(isSliding ? 0 : 1)
                                    .animation(.easeInOut(duration: 0.5).delay(2).repeatForever(autoreverses: false).delay(Double(-slide) / 20), value: isSliding)
                            }
                            
                        }
                        
                        Image(systemName: "chevron.left")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .scaleEffect(isSliding ? 0.25 : 1)
                            .opacity(isSliding ? 0 : 1)
                            .offset(x: isSliding ? -50 : 1)
                            .animation(slideGently, value: isSliding)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "mic")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                .background(Color(.systemGray4))
                .cornerRadius(32)
                
                LockAnimationView()
            }
            .onAppear {
                isShimmering.toggle()
                isSliding = true
            }
        }
        .padding()
    }
}

struct SlideWithHueRotation_Previews: PreviewProvider {
    static var previews: some View {
        SlideWithHueRotation()
            .preferredColorScheme(.dark)
    }
}
