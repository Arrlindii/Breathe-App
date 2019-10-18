

//
//  StyleGuide.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 16.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

extension Color {
    static let cardGray = Color.init(red: 20/255, green: 20/255, blue: 20/255)
    static let textGray = Color.init(red: 91/255, green: 91/255, blue: 91/255)
    static let lightTextGray = Color.init(red: 197/255, green: 197/255, blue: 197/255)
}

extension Font {
    static let headerText = Font.system(size: 46, weight: .bold)
    static let largeBodyText = Font.system(size: 24, weight: .regular)
    static let bodyText = Font.system(size: 16, weight: .regular)
    static let detailText = Font.system(size: 14, weight: .regular)
}
