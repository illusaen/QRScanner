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
        VStack {
            QRView(messages: $messages, isCapturing: $isCapturing)
                .overlay(ToggleButtonView(messages: $messages, isCapturing: $isCapturing), alignment: .bottomTrailing)
            QRMessagesView(messages: $messages)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
