//
//  ContentView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String?
    @State private var isCapturing: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                QRView(message: $message, isCapturing: $isCapturing)
                VStack(spacing: 16) {
                    Text(message ?? "")
                        .frame(width: geometry.size.width * 0.25 - 16, height: geometry.size.height - 96)
                        .border(Color.accentColor.opacity(0.2), width: 4)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(4)
                        .font(.title)
                    Button(action: { isCapturing.toggle() }) {
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
