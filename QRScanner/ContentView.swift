//
//  ContentView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        QRView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
