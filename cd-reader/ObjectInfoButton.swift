//
//  ObjectInfoButton.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 9/22/24.
//

import Foundation
import SwiftUI

class ObjectInfoButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 20
    }
}
