//
//  AudioHelper.swift
//  EmoChat
//
//  Created by Nikolay Dementiev on 24.07.17.
//  Copyright © 2017 SoftServe. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
