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
                VStack(spacing: 8) {
                    Text(message ?? "")
                        .frame(width: geometry.size.width * 0.25 - 16, height: geometry.size.height - 76)
                        .border(Color.accentColor.opacity(0.2), width: 4)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(4)
                    Button(action: { isCapturing.toggle() }) {
                        Image(isCapturing ? "Stop" : "Start")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(isCapturing ? .red : .green)
                            .frame(width: 48, height: 48)
                            .background(Color.clear)
                            .border(Color.clear)
                            .brightness(-0.25)
                    }
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
