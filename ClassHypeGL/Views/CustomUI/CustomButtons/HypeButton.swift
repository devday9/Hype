//
//  HypeButton.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/12/20.
//

import UIKit

class HypeButton: UIButton {
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    //MARK: - Class Functions
    func setupViews() {
        updateFontTo(font: FontNames.latoRegular)
        self.backgroundColor = .greenAccent
        self.setTitleColor(.mainText, for: .normal)
        self.addCornerRadius()
    }
    
    func updateFontTo(font: String) {
        guard let size = self.titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: font, size: size)
    }
}//END OF CLASS
