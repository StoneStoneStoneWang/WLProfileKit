//
//  WLUserApi.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/14.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire
import WLToolsKit

public enum WLUserApi {
    
    case login(_ phone: String,password: String)
    
    case smsCode(_ phone: String)
    
    case swiftLogin(_ phone: String,code: String)
    
    case reg(_ phone: String,password: String ,code: String)
    
    case feedback(_ email: String,content: String)
    
    case fetchProfile
    
    case updateUserInfo(_ key: String,value: String)
    
    case smsPassword(_ phone: String)
    
    case resettingPassword(_ phone: String,password: String ,code: String)
    
    case modifyPassword(_ oldPassword: String,password: String)
    
    case aliToken
    
    case fetchBlackList
    
    case removeBlack(_ encode: String)
    
    case focus(_ OUsEncoded: String,targetEncoded: String)
}

extension WLUserApi: WLObserverReq {
    public var reqName: String {
        
        switch self {
            
        case .login: return "other/login_mobLoginPhone?"
            
        case .swiftLogin: return "other/login_mobQuickLogin?"
            
        case .smsCode: return "mob/sms_mobSendQuickLoginCode?"
            
        case .reg: return "mob/users_mobPhoneAddUsers?"
            
        case .feedback: return "mob/feedback_mobFeedbackAdd?"
            
        case .fetchProfile: return "mob/users_mobUsersInfo?"
            
        case .updateUserInfo: return "mob/users_mobUsersUpdate?"
            
        case .smsPassword: return "mob/sms_mobSendForgetPwdCode?"
            
        case .resettingPassword: return "mob/users_mobForgetPassword?"
            
        case .modifyPassword: return "mob/users_mobUpdatePassword?"
            
        case .aliToken: return "other/oss_stsAssumeRole?"
            
        case .fetchBlackList: return "mob/blacklist_mobListBlacklist?"
            
        case .removeBlack: return "mob/blacklist_mobDelBlacklist"
            
        case .focus: return "mob/attention_mobSucrAttention?"
        }
    }
    
    public var params: Dictionary<String, Any> {
        
        switch self {
        case let .login(phone, password: password): return ["phone": phone,"password": password,"platform": "1" ,"deviceId": DeviceId]
            
        case let .smsCode(phone): return ["phone": phone,"signName":WLGlobalManager.default.styleConfig.smsSignName,"templateCode":WLGlobalManager.default.styleConfig.smsLoginCode]
            
        case let .swiftLogin(phone, code): return ["phone":phone,"code":code,"platform":"1"]
            
        case let .reg(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code,"openid": ""]
        case let .feedback(email, content: content): return ["fb.email": email,"fb.content": content]
            
        case .fetchProfile: return ["platform": "1"]
            
        case let .updateUserInfo(key, value: value): return [key: value]
            
        case let .smsPassword(phone): return ["phone": phone,"signName":WLGlobalManager.default.styleConfig.smsSignName,"templateCode":WLGlobalManager.default.styleConfig.smspasswordCode]
            
        case let .resettingPassword(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code]
            
        case let .modifyPassword(oldPassword, password: password): return ["oldPassword": oldPassword,"password": password]
            
        case .fetchBlackList: return ["projectId":WLGlobalManager.default.styleConfig.prprEncode]
            
        case .aliToken: return [:]
            
        case let .removeBlack(encoded): return ["projectId":WLGlobalManager.default.styleConfig.prprEncode,"bt.encoded": encoded]
            
        case let .focus(OUsEncoded, targetEncoded: targetEncoded): return ["atn.OUsEncoded":OUsEncoded,"atn.targetEncoded":targetEncoded,"projectId": WLGlobalManager.default.styleConfig.prprEncode,"atn.tableName":"Users"]
        }
    }
    
    public var headers: Dictionary<String, String> {
        
        switch self {
            
        default: return [:]
            
        }
    }
    
    public var method: HTTPMethod {
        switch self {
            
        default: return .post
            
        }
    }
    
    public var host: String {
        
        switch self {
            
        default: return WLGlobalManager.default.styleConfig.host
            
        }
    }
}

//  1.登录： 您上次登录的设备与本次登录的设备不一致，请确定是否是本人登录
//  2.修改密码: 您在xxxx时间段内修改了密码，如若是本人请忽略，如果不是本人请及时修改密码。

