//
//  WLCommentBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

@objc public final class WLCommentBean: NSObject ,Mappable{
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        intime  <- map["intime"]
        
        content  <- map["content"]
        
        users  <- map["users"]
    }
    
    @objc var intime: String = ""
    
    @objc var content: String = ""
    
    @objc var users: WLUserBean!
}
