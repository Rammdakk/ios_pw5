//
//  UIViewFade.swift
//  riziganshinPW4
//
//  Created by Рамиль Зиганшин on 06.10.2022.
//

import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = { (finished: Bool) -> Void in
    }) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.2, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = { (finished: Bool) -> Void in
    }) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }

}



