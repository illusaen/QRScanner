//
//  QRView.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import SwiftUI
import AVFoundation

struct QRView: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> QRViewController {
        let viewController = QRViewController()
        return viewController
    }
    
    func updateNSViewController(_ nsViewController: QRViewController, context: Context) {
        
    }
    
    typealias NSViewControllerType = QRViewController
    
}

class PreviewView: NSView, CALayerDelegate {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.configure()
    }
    
    func configure() {
        self.wantsLayer = true
    }
    
    override func makeBackingLayer() -> CALayer {
        let layer = AVCaptureVideoPreviewLayer()
        layer.delegate = self
        layer.needsDisplayOnBoundsChange = true
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

class QRViewController: NSViewController {
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepare()
        (self.view as! PreviewView).videoPreviewLayer.session = self.captureSession
        self.toggleSession(true)
        
    }
    
    override func loadView() {
        self.view = PreviewView()
    }
}

extension QRViewController {
    func toggleSession(_ on: Bool) {
        if on {
            self.captureSession.startRunning()
        } else {
            self.captureSession.stopRunning()
        }
    }
    
    func prepare() {
        self.captureSession.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(.externalUnknown, for: .video, position: .unspecified)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            self.captureSession.canAddInput(videoDeviceInput)
            else { return }
        self.captureSession.addInput(videoDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Video buffer"))
        guard self.captureSession.canAddOutput(videoOutput) else { return }
        self.captureSession.sessionPreset = .photo
        self.captureSession.addOutput(videoOutput)
        
        self.captureSession.commitConfiguration()
    }
}

extension QRViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
                let ciImage = CIImage(cvPixelBuffer: imageBuffer)
                if let messages = QRScanner.qrDecode(ciImage), messages.count > 0 {
                    self.toggleSession(false)
//                    self.delegate?.decoded(messages.joined(separator: ", "))
                    print(messages)
                }
    }
}
