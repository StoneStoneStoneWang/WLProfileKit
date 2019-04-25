//
//  WLUploadReq.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import RxSwift
import ObjectMapper
import Alamofire
import WLThirdUtil.WLAliObjCache

public struct WLALJsonBean: Mappable {
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        
        credentials <- map["credentials"]
    }
    public var credentials: WLALCredentialsBean!
}

public struct WLALCredentialsBean: Mappable {
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        
        accessKeyId <- map["accessKeyId"]
        
        accessKeySecret <- map["accessKeySecret"]
        
        securityToken <- map["securityToken"]
    }
    public var accessKeyId: String = ""
    
    public var accessKeySecret: String = ""
    
    public var securityToken: String = ""
}
public func onAliDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !WLAccountCache.default.token.isEmpty {
            
            params.updateValue(WLAccountCache.default.token, forKey: "token")
        }
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(result):
                
                if JSONSerialization.isValidJSONObject(result) {
                    
                    observer.onNext(result as! [String:Any])
                    
                    observer.onCompleted()
                    
                } else {
                    
                    observer.onError(WLBaseError.MapperError("invalid json"))
                }
                
            case let .failure(error):
                
                observer.onError(WLBaseError.HTTPFailed(error))
            }
        }
        
        return Disposables.create { }
    })
}

public func onUploadImgResp(_ data: Data ,file: String ,param: WLALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        let df = DateFormatter()
        
        df.dateFormat = "yyyyMMdd"
        
        let time = df.string(from: Date())
        
        let objectKey = "user/zhihe/" + time + "/" + file + "/" + WLAccountCache.default.uid + "/" + "\(WLAccountCache.default.uid).png";
        
        if let flag = WLAliObjCache.shared().perform(NSSelectorFromString("checkEnv")) {
            
            if !(flag.takeUnretainedValue() as! Bool) {
                
                WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com")
            }
        }
        else { WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com") }
        
        WLAliObjCache.shared().uploadData(data, andProjectKey: objectKey, andAccessKeyId: param.accessKeyId, andAccessKeySecret: param.accessKeySecret, andSecurityToken: param.securityToken, andProgress: { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
            
        }, andSucc: { (ok) in
            
            observer.onNext(ok)
            
            observer.onCompleted()
        }, andFail: { (error) in
            
            observer.onError(error)
        })
        
        return Disposables.create { }
    })
}

public func onUploadPubImgResp(_ data: Data ,file: String ,param: WLALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        let df = DateFormatter()
        
        df.dateFormat = "yyyyMMdd"
        
        let time = df.string(from: Date())
        
        let objectKey = "user/zhihe/" + time + "/" + file + "/" + WLAccountCache.default.uid + "/" + "\(Date.getTimeStamp_MS()).png";
        
        if let flag = WLAliObjCache.shared().perform(NSSelectorFromString("checkEnv")) {
            
            if !(flag.takeUnretainedValue() as! Bool) {
                
                WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com")
            }
        }
        else { WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com") }
        
        WLAliObjCache.shared().uploadData(data, andProjectKey: objectKey, andAccessKeyId: param.accessKeyId, andAccessKeySecret: param.accessKeySecret, andSecurityToken: param.securityToken, andProgress: { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
            
        }, andSucc: { (ok) in
            
            observer.onNext(ok)
            
            observer.onCompleted()
        }, andFail: { (error) in
            
            observer.onError(error)
        })
        
        
        return Disposables.create { }
    })
}
public func onUploadVideoResp(_ data: Data ,file: String ,param: WLALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        if data.count >= 30 * 1024 * 1024 {
            
            observer.onError(WLBaseError.MapperError("不能超过10兆"))
            
            return Disposables.create { }
        }
        
        let df = DateFormatter()
        
        df.dateFormat = "yyyyMMdd"
        
        let time = df.string(from: Date())
        
        let objectKey = "user/zhihe/" + time + "/" + file + "/" + WLAccountCache.default.uid + "/" + "\(Date.getTimeStamp_MS()).mp4";
        
        if let flag = WLAliObjCache.shared().perform(NSSelectorFromString("checkEnv")) {
            
            if !(flag.takeUnretainedValue() as! Bool) {
                
                WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com")
            }
        }
        else { WLAliObjCache.prepare("ecsoi", andEndPoint: "oss-cn-beijing.aliyuncs.com") }
        
        WLAliObjCache.shared().uploadData(data, andProjectKey: objectKey, andAccessKeyId: param.accessKeyId, andAccessKeySecret: param.accessKeySecret, andSecurityToken: param.securityToken, andProgress: { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
            
        }, andSucc: { (ok) in
            
            observer.onNext(ok)
            
            observer.onCompleted()
        }, andFail: { (error) in
            
            observer.onError(error)
        })
        
        
        return Disposables.create { }
    })
}
