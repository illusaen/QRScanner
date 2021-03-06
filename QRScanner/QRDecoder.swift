//
//  QRDecoder.swift
//  QRScanner
//
//  Created by Wendy Chen on 3/6/21.
//

import CoreImage

class QRScanner {
    private static func findQRCode(_ image: CIImage) -> [CIFeature]? {
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: CIContext(), options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        else { return nil }
        
        let orientationKey = kCGImagePropertyOrientation as String
        let orientation = image.properties[orientationKey] ?? 1
        
        return detector.features(in: image, options: [CIDetectorImageOrientation : orientation])
    }
    
    static func qrDecode(_ image: CIImage) -> [String]? {
        guard let features = findQRCode(image) else { return nil }
        
        return features.compactMap { (feature) -> String? in
            guard let qrFeature = feature as? CIQRCodeFeature,
                  let str = qrFeature.messageString
            else { return nil }
            
            return str
        }
    }
}
