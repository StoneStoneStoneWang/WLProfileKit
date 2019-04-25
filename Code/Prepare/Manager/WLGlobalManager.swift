//
//  WLGlobalManager.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLThirdUtil.WLHudUtil
import WLThirdUtil.WLUMUtil

@objc public class WLGlobalManager: NSObject {
    
    @objc public static let `default`: WLGlobalManager = WLGlobalManager()
    
    private override init() { WLHudUtil.configHud() }
    
    @objc public var styleConfig: WLStyleConfig!
}

extension WLGlobalManager {
    // 配置style
    @objc public static func creatStyleConfig(_ config: WLStyleConfig) {
        WLUMUtil.shared().regUMAppKey(config.umKey)
        
        WLGlobalManager.default.styleConfig = config
    }
}
