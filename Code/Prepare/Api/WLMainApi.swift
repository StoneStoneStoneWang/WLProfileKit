//
//  WLMainApi.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire
import WLToolsKit
public enum WLMainApi {
    
    case publish(_ tag: String,content: String)
    
    case fetchList(_ tag: String,page: Int)
    
    case fetchDetail
    
    case fetchComments(_ page: Int,targetEncoded: String)
    
    case addComment(_ targetEncoded: String,content: String,tablename: String,type: String)
    
    case deleteComment(_ encoded: String)
    
    case like(_ targetEncoded: String)
    
    case report(_ OUsEncoded: String,targetEncoded: String ,type: String ,content: String)
    
    case addBlack(_ OUsEncoded: String,targetEncoded: String,content: String)
    
    case fetchPublish(_ tag: String ,page: Int ,userId: String)
    
    case attention(_ OUsEncoded: String,targetEncoded: String)
    
    case fetchMyFocus(_ page: Int)
    
}
extension WLMainApi: WLObserverReq {
    public var reqName: String {
        
        switch self {
            
        case .publish: return "mob/circleFriends_mobAddCircleFriends?"
            
        case .fetchList: return "mob/circleFriends_mobListCircleFriends?"
            
        case .fetchComments: return "mob/comment_mobListComment?"
            
        case .addComment: return "mob/comment_mobAddComment?"
            
        case .deleteComment: return "mob/comment_mobDelComment?"
            
        case .like: return "mob/laud_mobAddLaud?"
            
        case .report: return "mob/report_mobReportAdd?"
            
        case .addBlack: return "mob/blacklist_mobAddBlacklist?"
            
        case .fetchPublish: return "mob/circleFriends_mobUserCircleFriends?"
            
        case .fetchMyFocus: return "mob/attention_mobListAttention?"
            
        case .attention: return "mob/attention_mobSucrAttention?"
            
        default: return ""
            
        }
    }
    
    public var params: Dictionary<String, Any> {
        
        switch self {
        case let .publish(tag,content: content): return ["cfs.tag":tag,"cfs.projectId":WLGlobalManager.default.styleConfig.prprEncode,"cfs.content":content]
            
        case let .fetchList(tag, page: page): return ["cfs.tag":tag,"cfs.projectId":WLGlobalManager.default.styleConfig.prprEncode,"page":page]
            
        case let .fetchComments(page, targetEncoded: targetEncoded):
            
            return ["comment.targetEncoded":targetEncoded,"page":page,"limit": 20,"projectId": WLGlobalManager.default.styleConfig.prprEncode]
            
        case let .addComment(targetEncoded, content: content, tablename: tablename, type: type):
            
            return ["comment.targetEncoded":targetEncoded,"comment.content":content,"comment.tableName": tablename,"comment.type": type,"projectId": WLGlobalManager.default.styleConfig.prprEncode]
            
        case let .like(targetEncoded): return ["targetEncoded":targetEncoded]
            
        case let .report(OUsEncoded, targetEncoded: targetEncoded, type: type, content: content):
            
            return ["rt.OUsEncoded":OUsEncoded,"rt.targetEncoded":targetEncoded,"rt.type": type,"rt.content": content,"rt.projectId": WLGlobalManager.default.styleConfig.prprEncode,"rt.tableName": "CircleFriends"]
        case let .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content):
            
            return ["bt.OUsEncoded":OUsEncoded,"bt.targetEncoded":targetEncoded,"bt.content": content,"projectId": WLGlobalManager.default.styleConfig.prprEncode,"bt.tableName": "CircleFriends"]
            
        case let .fetchMyFocus(page): return ["page":page,"projectId": WLGlobalManager.default.styleConfig.prprEncode]
            
        case let .attention(OUsEncoded, targetEncoded: targetEncoded): return ["atn.OUsEncoded":OUsEncoded,"atn.targetEncoded":targetEncoded,"projectId": WLGlobalManager.default.styleConfig.prprEncode,"atn.tableName":"Users"]
            
        case let .fetchPublish(tag, page: page, userId: userId): return ["cfs.projectId":WLGlobalManager.default.styleConfig.prprEncode,"cfs.tag": tag,"page": page,"userId": userId]
            
        default: return [:]
            
        }
    }
    
    public var headers: Dictionary<String, String> {
        
        return [:]
    }
    
    public var method: HTTPMethod {
        
        return .post
    }
    
    public var host: String {
        
        guard let styleConfig = WLGlobalManager.default.styleConfig else { fatalError("请设置代理") }
        
        return styleConfig.host
    }
}
