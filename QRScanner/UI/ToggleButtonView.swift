//
//  ToggleButtonView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

fileprivate let ICON_SIZE: CGFloat = 32
fileprivate let BUTTON_SIZE: CGFloat = 64
fileprivate let STROKE_WIDTH: CGFloat = 4

struct ToggleButtonView: View {
    @Binding var messages: [String]
    @Binding var isCapturing: Bool
    
    var color: Color {
        return isCapturing ? .red : .green
    }
    
    var body: some View {
        Button(action: {
            isCapturing.toggle()
            if isCapturing { messages = [] }
        }) {
            Icon(isCapturing: isCapturing)
                .stroke(color, style: StrokeStyle(lineWidth: STROKE_WIDTH, lineCap: .round, lineJoin: .round))
                .frame(width: ICON_SIZE, height: ICON_SIZE, alignment: .center)
        }
        .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
        .background(Color.black.opacity(0.5))
        .clipShape(Circle())
        .overlay(Circle().stroke(color, lineWidth: STROKE_WIDTH * 1.5))
        .shadow(radius: STROKE_WIDTH)
        .buttonStyle(BorderlessButtonStyle())
        .padding()
    }
}

struct Icon: Shape {
    var isCapturing: Bool
    
    func triangle(in rect: CGRect) -> Path {
        let heightToSideRatio: CGFloat = 0.866
        let ratioedStrokeWidth: CGFloat = STROKE_WIDTH / heightToSideRatio
        let width = (rect.maxX - ratioedStrokeWidth * 2) * heightToSideRatio
        let startX = (rect.maxX - width) / 2 + ratioedStrokeWidth / 2
        let stopX = width + startX
        
        var path = Path()
        path.move(to: CGPoint(x: startX, y: rect.minY + ratioedStrokeWidth))
        path.addLine(to: CGPoint(x: stopX, y: rect.midY))
        path.addLine(to: CGPoint(x: startX, y: rect.maxY - ratioedStrokeWidth))
        path.addLine(to: CGPoint(x: startX, y: rect.minY + ratioedStrokeWidth))
        return path
    }
    
    func square(in rect: CGRect) -> Path {
        let strokeMargin = STROKE_WIDTH / 2
        let minX = rect.minX + strokeMargin
        let minY = rect.minY + strokeMargin
        let maxX = rect.maxX - strokeMargin
        let maxY = rect.maxY - strokeMargin
        
        var path = Path()
        path.move(to: CGPoint(x: minX, y: minY))
        path.addLine(to: CGPoint(x: maxX, y: minY))
        path.addLine(to: CGPoint(x: maxX, y: maxY))
        path.addLine(to: CGPoint(x: minX, y: maxY))
        path.addLine(to: CGPoint(x: minX, y: minY))
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        return isCapturing ? square(in: rect) : triangle(in: rect)
    }
}
