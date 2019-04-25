//
//  WLProjectBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxCocoa
import RxSwift
import RxDataSources
import WLToolsKit

public struct WLProjectBean: Mappable ,IdentifiableType & Equatable{
    public var identity: String = ""
    
    public typealias Identity = String
    
    public init?(map: Map) {
        
        
    }
    
    public mutating func mapping(map: Map) {
        
        intime <- map["intime"]
        
        content  <- map["content"]
        
        isLaud  <- map["isLaud"]
        
        countLaud  <- map["countLaud"]
        
        tag  <- map["tag"]
        
        users  <- map["users"]
        
        countComment  <- map["countComment"]
        
        projectId  <- map["projectId"]
        
        encoded  <- map["encoded"]
        
        identity  <- map["encoded"]
    }
    
    var projectId: String = ""
    
    var encoded: String = ""
    
    var intime: Int = Int.max
    
    var content: String = ""
    
    var isLaud: Bool = false
    
    var countLaud: Int = Int.max
    
    var tag: String = ""
    
    var users: WLUserBean!
    
    var countComment: Int = Int.max
    
    var contentMap: [WLProjectTypeBean] {
        
        let res = WLJsonCast.cast(argu: content) as! [[String: String]]
        
        return res.map({ WLProjectTypeBean(JSON: $0)! })
    }
    
    var titleBean: WLProjectTypeBean {
        
        return contentMap.first!
    }
    
    var subTitle: WLProjectTypeBean! {
        
        var res: WLProjectTypeBean!
        
        for item in contentMap {
            
            if item.type == "txt" {
                
                res = item
                
                break
            }
        }
        
        return res
    }
    
    var medias: [WLProjectTypeBean] {
        
        var res: [WLProjectTypeBean] = []
        
        for item in contentMap {
            
            if item.type == "image" {
                
                res += [item]
                
                continue
            } else if item.type == "video" {
                
                res += [item]
                
                continue
            }
        }
        return res
    }
    
    var cellHeight: CGFloat {
        
        let col = 3
        
        let a = medias.count / col
        
        let b = medias.count % col
        
        let row = b > 0 ? (a + 1) : a
        
        var subH: CGFloat = 0
        
        if let first = subTitle {
            
            subH = (first.value as NSString).boundingRect(with: CGSize(width: WL_SCREEN_WIDTH - wl_main_margin * 2, height: 999), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil).height
            
        }
        
        let w = ( WL_SCREEN_WIDTH - wl_main_margin * 2 - 5 * 2) / 3
        
        var h: CGFloat = 0
        
        if WLMainGlobal.default.styleConfig.mediaStyle == "1*1" {
            //                1*1 4*3 2*1
            h = w
        } else if WLMainGlobal.default.styleConfig.mediaStyle == "4*3" {
            
            h = w * 3 / 4
        } else if WLMainGlobal.default.styleConfig.mediaStyle == "2*1" {
            
            h = w / 2
        } else {
            
            h = w
        }
        
        return 65 + 30 + subH + h * CGFloat(row) + CGFloat(row - 1) * 5 + 40 + 5
    }
}
