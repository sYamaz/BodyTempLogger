//
//  ThemeColor.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/21.
//

import Foundation
struct ThemeColor: Codable{
    let r:Double
    let g:Double
    let b:Double
    let opacity:Double
    
    init(r:Double, g:Double, b:Double){
        self.r = r
        self.g = g
        self.b = b
        self.opacity = 0
    }
    
    init(r:Double, g:Double, b:Double, opacity:Double){
        self.r = r
        self.g = g
        self.b = b
        self.opacity = opacity
    }
}
