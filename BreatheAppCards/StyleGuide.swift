

//
//  StyleGuide.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 16.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

extension Color {
    static let textGray = Color.init(red: 91/255, green: 91/255, blue: 91/255)
    static let lightTextGray = Color.init(red: 197/255, green: 197/255, blue: 197/255)
    static let darkGreenColor = Color.init(red: 9/255, green: 25/255, blue: 23/255)
    
    static let darkGrayColor = Color.init(red: 20/255, green: 20/255, blue: 20/255)
    static let mintGreenColor = Color.init(red: 56/255, green: 199/255, blue: 191/255)
    static let darkMintColor = Color.init(red: 47/255, green: 245/255, blue: 220/255)
    static let grayGreenColor = Color.init(red: 34/255, green: 68/255, blue: 65/255)
    static let customGreenColor = Color.init(red: 33/255, green: 194/255, blue: 154/255)
}

extension Font {
    static let headerText = Font.system(size: 46, weight: .bold)
    static let largeBodyText = Font.system(size: 24, weight: .regular)
    static let bodyText = Font.system(size: 16, weight: .regular)
    static let detailText = Font.system(size: 14, weight: .regular)
}

extension Date {
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MMM dd."
        return formatter.string(from: self)
    }
}
