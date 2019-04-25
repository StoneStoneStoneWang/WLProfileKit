//
//  WLGlobalManager+SOMain.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLReqKit
import WLThirdUtil.WLHudUtil

@objc public final class WLSOManager: NSObject {
    
    public final let disposed: DisposeBag = DisposeBag()
    
    @objc public override init() { }
}

extension WLSOManager {
    
    @objc public func fetchComments(_ page: Int ,projectId: String ,encoded: String,succ: @escaping (_ list: [WLCommentBean]) -> () ,fail: @escaping (_ error: String) -> ()) {
        onUserArrayResp(WLMainApi.fetchComments(page, targetEncoded: encoded))
            .mapArray(type: WLCommentBean.self)
            .subscribe(onNext: { succ($0) } , onError: { fail(($0 as! WLBaseError).description.0) } )
            .disposed(by: disposed)
    }
    
//    public func fetchList(_ tag: String,page: Int ,succ: @escaping (_ list: [WLProjectBean]) -> () ,fail: @escaping (_ error: String) -> ()) {
//        
//        onUserArrayResp(WLMainApi.fetchList(tag, page: page) )
//            .mapArray(type: WLProjectBean.self)
//            .subscribe(onNext: { succ($0) } , onError: { fail(($0 as! WLBaseError).description.0) } )
//            .disposed(by: disposed)
//    }
    
    @objc public func addComment(_ encoded: String,content: String,succ: @escaping (_ com: WLCommentBean ) -> () ,fail: @escaping (_ error: String) -> ()) {
        
        if content.isEmpty {
            
            WLHudUtil.showInfo("请输入评论内容!")
            return
        }
        
        onUserDictResp(WLMainApi.addComment(encoded, content: content, tablename: "CircleFriends", type: "0"))
            .mapObject(type: WLCommentBean.self)
            .subscribe(onNext: { succ($0) } , onError: { fail(($0 as! WLBaseError).description.0) } )
            .disposed(by: disposed)
        
    }
    
    @objc public func like(_ encoded: String,succ: @escaping () -> () ,fail: @escaping (_ error: String) -> ()) {
        
        onUserVoidResp(WLMainApi.like(encoded))
            .subscribe(onNext: { _ in succ() } , onError: { fail(($0 as! WLBaseError).description.0) } )
            .disposed(by: disposed)
    }
    
    @objc public func report(_ OUsEncoded: String,targetEncoded: String ,type: String ,content: String,succ: @escaping () -> () ,fail: @escaping (_ error: String) -> ()) {
        
        onUserVoidResp(WLMainApi.report(OUsEncoded, targetEncoded: targetEncoded, type: type, content: content))
            .subscribe(onNext: { _ in succ() } , onError: { fail(($0 as! WLBaseError).description.0) } )
            .disposed(by: disposed)
    }
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String,succ: @escaping () -> () ,fail: @escaping (_ error: String) -> ()) {
        
        onUserVoidResp(WLMainApi.addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content))
            .subscribe(onNext: { _ in succ() } , onError: { fail(($0 as! WLBaseError).description.0) } )
            .disposed(by: disposed)
    }
}
