//
//  QRView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI

struct QRView: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> QRViewController {
        let viewController = QRViewController()
        return viewController
    }
    
    func updateNSViewController(_ nsViewController: QRViewController, context: Context) {
        
    }
    
    typealias NSViewControllerType = QRViewController
    
}
