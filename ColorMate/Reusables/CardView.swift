//
//  CardView.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/07/23.
//

import Foundation
import UIKit

class CMCardView: UIView{
    
    init(backgroundColor: UIColor = .white,
         cornerRadius: Double = 8.0,
         shadowColor: CGColor = UIColor.black.cgColor,
         shadowOpacity: Float = 0.2,
         shadowOffset: CGSize = CGSize(width: 0, height: 2),
         shadowRadius: Double = 4.0){
        super.init(frame: .zero)
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
