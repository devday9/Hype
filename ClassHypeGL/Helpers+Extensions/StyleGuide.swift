//
//  StyleGuide.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/12/20.
//

import UIKit

struct FontNames {
    static let latoBold = "Lato-Bold"
    static let latoLight = "Lato-Light"
    static let latoRegular = "Lato-Regular"
}

extension UIColor {
    static let borderHighlight = UIColor(named: "borderHighlight")!
    static let purpleAccent = UIColor(named: "purpleAccent")!
    static let greenAccent = UIColor(named: "greenAccent")!
    static let spaceBlack = UIColor(named: "spaceBlack")!
    static let subtleText = UIColor(named: "subtleText")!
    static let spaceGray = UIColor(named: "spaceGray")!
    static let cardGray = UIColor(named: "cardGray")!
    static let mainText = UIColor(named: "mainText")!
}//END OF EXTENSION

extension UIView {
    
    func addCornerRadius(radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 5, color: UIColor = .borderHighlight) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func rotate(by radians: CGFloat = (-CGFloat.pi / 2)) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}//END OF EXTENSION
