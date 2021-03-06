//
//  QRMessageView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

struct QRMessagesView: View {
    @Binding var messages: [String]

    var body: some View {
        List(messages, id: \.self) { message in
            Link(message, destination: URL(string: message)!)
                .border(Color.accentColor.opacity(0.2), width: 4)
                .background(Color.accentColor.opacity(0.2))
                .cornerRadius(4)
                .font(.title)
        }
    }
}
