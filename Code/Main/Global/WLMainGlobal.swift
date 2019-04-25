//
//  WLMainGlobal.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

@objc public class WLMainGlobal: NSObject {
    
    @objc public static let `default`: WLMainGlobal = WLMainGlobal()
    
    private override init() { }
    
    @objc public var styleConfig: WLMainStyleConfig!
}

extension WLMainGlobal {
    // 配置style
    @objc public static func creatMainConfig(_ config: WLMainStyleConfig) {
        
        WLMainGlobal.default.styleConfig = config
    }
}
