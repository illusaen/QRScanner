//
//  QRView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

protocol QRViewControllerDelegate {
    func decoded(_ message: String)
}

struct QRView: NSViewControllerRepresentable {
    @Binding var message: String?
    @Binding var isCapturing: Bool
    
    func makeNSViewController(context: Context) -> QRViewController {
        let viewController = QRViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateNSViewController(_ nsViewController: QRViewController, context: Context) {
        nsViewController.toggleSession(isCapturing)
    }
    
    typealias NSViewControllerType = QRViewController
    
    class Coordinator: QRViewControllerDelegate {
        var parent: QRView
        
        init(_ parent: QRView) {
            self.parent = parent
        }
        
        func decoded(_ message: String) {
            self.parent.message = message
            self.parent.isCapturing = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
