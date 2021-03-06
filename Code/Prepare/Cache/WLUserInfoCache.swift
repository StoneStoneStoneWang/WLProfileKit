//
//  WLUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLThirdUtil.WLCacheUtil

@objc class WLUserInfoCache: NSObject {
    
    @objc public static let `default`: WLUserInfoCache = WLUserInfoCache()
    
    private override init() { WLCacheUtil.shared().createCache("WLUserInfoCache") }
    
    @objc dynamic var userBean: WLUserBean = WLUserBean()
}

extension WLUserInfoCache {
    
    func saveUser(data: WLUserBean) -> WLUserBean {
        
        WLCacheUtil.shared().saveObj(data, withKey: "user_" + data.encoded)
        
        userBean = data
        
        return data
    }
    public func queryUser() -> WLUserBean  {
        
        if let user = WLCacheUtil.shared().fetchObj("user_" + WLAccountCache.default.uid) {
            
            userBean = user as! WLUserBean
            
            return userBean
        }
        
        return WLUserBean()
    }
}
