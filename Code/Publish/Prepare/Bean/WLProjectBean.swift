//
//  WLProjectBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources
@objc (WLProjectBean)
public final class WLProjectBean: NSObject,Mappable , IdentifiableType{
    public var identity: String = ""
    
    public typealias Identity = String
    
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        identity <- map["encoded"]
        
        intime <- map["intime"]
        
        content  <- map["content"]
        
        isLaud  <- map["isLaud"]
        
        countLaud  <- map["countLaud"]
        
        tag  <- map["tag"]
        
        users  <- map["users"]
        
        countComment  <- map["countComment"]
        
        projectId  <- map["projectId"]
        
        encoded  <- map["encoded"]
    }
    
    @objc var projectId: String = ""
    
    @objc var encoded: String = ""
    
    @objc var intime: Int = Int.max
    
    @objc var content: String = ""
    
    @objc var isLaud: Bool = false
    
    @objc var countLaud: Int = Int.max
    
    @objc var tag: String = ""
    
    @objc var users: WLUserBean!
    
    @objc var countComment: Int = Int.max
}
