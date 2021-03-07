//
//  QRMessageView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

fileprivate let ICON_SIZE: CGFloat = 16
fileprivate let PADDING_WIDTH: CGFloat = 4

struct QRMessagesView: View {
    @Binding var messages: [String]

    var body: some View {
        ForEach(messages, id: \.self) { message in
            Link(destination: URL(string: message)!) {
                HStack(spacing: 0) {
                    Image("url")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ICON_SIZE, height: ICON_SIZE)
                        .foregroundColor(.white)
                        .padding(PADDING_WIDTH)
                        .background(Color.black)
                        .clipShape(Circle())
                        .padding(PADDING_WIDTH * 2)
                    Text(message)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            }
            .padding()
            .border(Color.accentColor.opacity(0.2), width: PADDING_WIDTH)
            .cornerRadius(PADDING_WIDTH)
        }
        .listRowBackground(Color.clear)
        .padding()
        .background(Color.accentColor.opacity(0.25))
        .cornerRadius(PADDING_WIDTH)
    }
}
