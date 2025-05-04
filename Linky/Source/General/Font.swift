//
//  Font.swift
//  Linky
//
//  Created by 박성민 on 3/20/25.
//

import SwiftUI

struct AppFonts {
    static func wantedSansBold(size: CGFloat) -> Font {
        return .custom("WantedSans-Bold", size: size)
    }
        
    static func wantedSansMedium(size: CGFloat) -> Font {
        return .custom("WantedSans-Medium", size: size)
    }
        
    static func wantedSansRegular(size: CGFloat) -> Font {
        return .custom("WantedSans-Regular", size: size)
    }
        
    static func wantedSansSemiBold(size: CGFloat) -> Font {
        return .custom("WantedSans-SemiBold", size: size)
    }
}
