//
//  HypeLabel.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/12/20.
//

import UIKit

/// Regular Hype Label
class HypeLabel: UILabel {
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateFontTo(font: FontNames.latoRegular)
        self.textColor = .mainText
    }
    
    //MARK: - Class Funcitons
    func updateFontTo(font: String) {
        let size = self.font.pointSize
        self.font = UIFont(name: font, size: size)
    }
}//END OF CLASS

/// Light Hype Label
class HypeLabelLight: HypeLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateFontTo(font: FontNames.latoLight)
        self.textColor = .subtleText
    }
}//END OF CLASS

/// Bold Hype Label
class HypeLabelBold: HypeLabel {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateFontTo(font: FontNames.latoBold)
    }
}//END OF CLASS
