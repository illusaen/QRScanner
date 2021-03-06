//
//  ContentView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var messages: [String] = []
    @State private var isCapturing: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                QRView(messages: $messages, isCapturing: $isCapturing)
                VStack(spacing: 16) {
                    QRMessagesView(messages: $messages)
                    Button(action: {
                            isCapturing.toggle()
                        if isCapturing { messages = [] }
                    }) {
                        Image(isCapturing ? "Stop" : "Start")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(isCapturing ? .red : .green)
                            .frame(width: 24, height: 24)
                            .background(Color.clear)
                            .border(Color.clear)
                            .brightness(-0.25)
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 4))
                    .shadow(radius: 2)
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
