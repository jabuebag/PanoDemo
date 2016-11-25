//
//  JabueUtil.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-23.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class JabueUtil {
    
    fileprivate func CreateGradientImage(_ pixelsWide: Int, _ pixelsHigh: Int, _ upsideDown: Bool) -> CGImage? {
        var colors: [CGFloat] = [0.0, 1.0, 0.3, 1.0]
        var theCGImage: CGImage? = nil
        
        // gradient is always black-white and the mask must be in the gray colorspace
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        // create the bitmap context
        let gradientBitmapContext = CGContext(data: nil, width: pixelsWide, height: pixelsHigh,
                                              bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        
        // define the start and end grayscale values (with the alpha, even though
        // our bitmap context doesn't support alpha the gradient requires it)
        if (!upsideDown) {
            colors = [1.0, 1.0, 0.3, 0.0]
        }
        
        // create the CGGradient and then release the gray color space
        let grayScaleGradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2)
        
        // create the start and end points for the gradient vector (straight down)
        let gradientStartPoint = CGPoint.zero
        let gradientEndPoint = CGPoint(x: 0, y: CGFloat(pixelsHigh))
        
        // draw the gradient into the gray bitmap context
        gradientBitmapContext?.drawLinearGradient(grayScaleGradient!, start: gradientStartPoint,
                                                  end: gradientEndPoint,  options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        // convert the context into a CGImageRef and release the context
        theCGImage = gradientBitmapContext?.makeImage()
        
        // return the imageref containing the gradient
        return theCGImage
    }
    
    fileprivate func panoramaBitmapContext(_ pixelsHigh: Int) -> CGContext? {
        let pixelsWide = pixelsHigh * 6
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // create the bitmap context
        let bitmapContext = CGContext(data: nil, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8,
                                      bytesPerRow: 0, space: colorSpace,
                                      // this will give us an optimal BGRA format for the device:
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        return bitmapContext
    }
    
    func reflectedImage(_ fromImage: UIImage) -> UIImage? {
        
        // create a bitmap graphics context the size of the image
        print(fromImage.size)
        let mainViewContentContext = panoramaBitmapContext(Int(fromImage.size.height))
        
        // create a 2 bit CGImage containing a gradient that will be used for masking the
        // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
        // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
        // let gradientMaskImage = CreateGradientImage(1, height)
        
        // create an image by masking the bitmap of the mainView content with the gradient view
        // then release the  pre-masked content bitmap and the gradient bitmap
//        mainViewContentContext?.clip(to: CGRect(x: 0.0, y: 0.0, width: (fromImage.image?.size.width)!, height: CGFloat(height)))
//        
//        // In order to grab the part of the image that we want to render, we move the context origin to the
//        // height of the image that we want to capture, then we flip the context so that the image draws upside down.
//        mainViewContentContext?.translateBy(x: 0.0, y: CGFloat(height))
//        mainViewContentContext?.scaleBy(x: 1.0, y: -1.0)
        // draw the image into the bitmap context
        mainViewContentContext?.draw(fromImage.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: fromImage.size.width, height: fromImage.size.width))
        // mainViewContentContext?.draw(fromImage.cgImage!, in: CGRect(x: 300.0, y: 0.0, width: fromImage.size.width, height: fromImage.size.width))
        
        // create CGImageRef of the main view bitmap content, and then release that bitmap context
        let reflectionImage = mainViewContentContext?.makeImage()
        
        // convert the finished reflection image to a UIImage
        let theImage = UIImage(cgImage: reflectionImage!)
        
        // image is retained by the property setting above, so we can release the original
        
        return theImage
    }
}
