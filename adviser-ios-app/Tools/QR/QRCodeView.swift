//
//  QRCodeView.swift
//  LearnRXSwift
//
//  Created by HDCF003 on 2019/9/9.
//  Copyright © 2019 HDCF003. All rights reserved.
//

import UIKit

class QRCodeView: UIView {

    private lazy var maskLayer:CALayer = {
        let maskLayer =  CALayer()
        return maskLayer
    }()
    private lazy var gradientLayer:CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        return gradientLayer
    }()
    
    init(frame: CGRect,content:String,colors:[UIColor]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.addSublayer(maskLayer)
        self.layer.addSublayer(gradientLayer)
        self.maskLayer.frame = self.bounds
        self.gradientLayer.frame = self.bounds
        self.gradientLayer.colors = colors.map{$0.cgColor}
        
        let qrcodeImage = createQRCodeImage(content: content, size: CGSize(width: self.bounds.width, height: self.bounds.height))
        self.maskLayer.contents =  genQRCodeImageMask(qrcodeImage)?.cgImage
        self.gradientLayer.mask = self.maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension QRCodeView {
    
    func createQRCodeImage(content: String, size: CGSize) -> UIImage {
        
        let stringData = content.data(using: String.Encoding.utf8)
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValuesForKeys(["inputImage" : (qrFilter?.outputImage)!,"inputColor0":CIColor.init(cgColor: UIColor.black.cgColor),"inputColor1":CIColor.init(cgColor: UIColor.white.cgColor)])
        
        let qrImage = colorFilter?.outputImage
        let cgImage = CIContext(options: nil).createCGImage(qrImage!, from: (qrImage?.extent)!)
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = .none
        context!.scaleBy(x: 1.0, y: -1.0)
        context?.draw(cgImage!, in: (context?.boundingBoxOfClipPath)!)
        let codeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return codeImage!
    }
    
    func genQRCodeImageMask(_ image: UIImage?) -> UIImage? {
        if image != nil {
            
            let bitsPerComponent: Int = 8
            let bytesPerPixel: Int = 4
            let width = Int(image?.size.width ?? 0)
            let height = Int(image?.size.height ?? 0)
            let imageData =  malloc(width * height * bytesPerPixel).assumingMemoryBound(to: UInt8.self)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let imageContext = CGContext(data: imageData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerPixel * width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
            UIGraphicsPushContext(imageContext!)
            
            imageContext?.translateBy(x: 0, y: CGFloat(height))
            imageContext?.scaleBy(x: 1, y: -1)
            image?.draw(in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
            for row in 0..<height {
                for col in 0..<width {
                    let offset: Int = row * width * bytesPerPixel + col * bytesPerPixel
                    let r: UInt8 = imageData[offset + 1]
                    let alpha: UInt8 = r > 100 ? 0 : 255
                    imageData[offset] = alpha
                }
            }
            let cgMaskImage = imageContext!.makeImage()
            let maskImage = UIImage(cgImage: cgMaskImage!)
            UIGraphicsPopContext()
            free(imageData)
            return maskImage
        }
        return nil
    }
}
