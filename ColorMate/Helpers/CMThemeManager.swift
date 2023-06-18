//
//  CMThemeManager.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit

protocol CMAppTheme{
    var primaryBackgroundColor: UIColor{get set}
    var secondaryBackgroundColor: UIColor{get set}
    var tertiaryBackgroundColor: UIColor{get set}
    var primaryLabelColor: UIColor{get set}
    var secondaryLabelColor: UIColor{get set}
    var tertiaryLabelColor: UIColor{get set}
    var primaryFillColor: UIColor{get set}
    var secondaryFillColor: UIColor{get set}
    var tertiaryFillColor: UIColor{get set}
}

class CMDefaultTheme: CMAppTheme{
    var primaryBackgroundColor: UIColor = .systemBackground
    
    var secondaryBackgroundColor: UIColor = .secondarySystemBackground
    
    var tertiaryBackgroundColor: UIColor = .tertiarySystemBackground
    
    var primaryLabelColor: UIColor = .label
    
    var secondaryLabelColor: UIColor = .secondaryLabel
    
    var tertiaryLabelColor: UIColor = .tertiaryLabel
    
    var primaryFillColor: UIColor = .systemFill
    
    var secondaryFillColor: UIColor = .secondarySystemFill
    
    var tertiaryFillColor: UIColor = .tertiarySystemFill
}

class CMThemeManager{
    private init(){}
    
    static var shared = CMThemeManager()
    
    var availableAppThemes: [CMAppTheme] = []
    var currentTheme: CMAppTheme = CMDefaultTheme()
    
    public func applyTheme(_ theme: CMAppTheme){
        NotificationCenter.default.post(name: NSNotification.Name(CMNotifications.themeChanged.rawValue), object: theme)
    }
    
    public func applyRandomTheme(){
        let randomThemeIndex = Int.random(in: 0..<availableAppThemes.count)
        let newTheme = availableAppThemes[randomThemeIndex]
        
        NotificationCenter.default.post(name: NSNotification.Name(CMNotifications.themeChanged.rawValue), object: newTheme)
    }
}
