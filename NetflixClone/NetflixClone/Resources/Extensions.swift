//
//  Extensions.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 10/28/23.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
