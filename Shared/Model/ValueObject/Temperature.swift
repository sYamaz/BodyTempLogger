//
//  TemperatureStore.swift
//  BodyTempLogger (iOS)
//
//  Created by Shun Yamazaki on 2021/10/21.
//

import Foundation

/// 入力中の体温を保持する構造体です
struct Temperature{
    /// 小数点以下
    let lower:Int
    
    /// 小数点以上
    let higher:Int
}

extension Temperature{
    public func lower(_ val:Int) -> Self{
        return .init(lower: val, higher: self.higher)
    }
    
    public func higher(_ val:Int) -> Self{
        return .init(lower: self.lower, higher: val)
    }
}
