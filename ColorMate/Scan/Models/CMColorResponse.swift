//
//  CMColorResponse.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/06/23.
//

import Foundation

struct CMColorResponse : Codable {
    let hex : Hex
    let rgb : Rgb
    let name : Name
    let image : Image
}

struct Hex: Codable{
    let value : String
    let clean : String
}

struct Rgb: Codable{
    let r : Int
    let g : Int
    let b : Int
    let value : String
}

struct Name: Codable{
    let value: String
    let closest_named_hex: String
}

struct Image: Codable{
    let bare: String
    let named: String
}
