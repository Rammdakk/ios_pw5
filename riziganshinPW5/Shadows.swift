//
//  Shadows.swift
//  riziganshinPW4
//
//  Created by Рамиль Зиганшин on 06.10.2022.
//

import UIKit

extension CALayer {
    func applyShadow() {
        shadowColor = UIColor.green.cgColor
        shadowOpacity = 0.3
        shadowOffset = CGSize.zero
        shadowRadius = 6
    }
}

