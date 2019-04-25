//
//  WLProjectTypeBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper

@objc public final class WLProjectTypeBean: NSObject,Mappable {
    required public init?(map: Map) {
        
        
    }
    
    public func mapping(map: Map) {
        
        type  <- map["type"]
        
        value  <- map["value"]
    }
    
    @objc override init() {
        
    }
    
    @objc var type: String = ""
    
    @objc var value: String = ""
}
