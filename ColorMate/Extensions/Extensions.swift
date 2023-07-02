//
//  Extensions.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 17/06/23.
//

import UIKit

struct RGBA{
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat = 1.0
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> RGBA {

        guard let cgImage = cgImage, let pixelData = cgImage.dataProvider?.data else { return RGBA(red: 0, green: 0, blue: 0) }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let bytesPerPixel = cgImage.bitsPerPixel / 8
        // adjust the pixels to constrain to be within the width/height of the image
        let y = pos.y > 0 ? pos.y - 1 : 0
        let x = pos.x > 0 ? pos.x - 1 : 0
        let pixelInfo = ((Int(self.size.width) * Int(y)) + Int(x)) * bytesPerPixel

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)

        return RGBA(red: r, green: g, blue: b)
    }
}
