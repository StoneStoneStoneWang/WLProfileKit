//
//  WLModifyPwdViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit

struct WLModifyPwdViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        /* 旧密码 序列*/
        let oldpassword: Driver<String>
        /* 新密码 序列*/
        let password:Driver<String>
        /* 重复新密码 序列*/
        let passwordAgain:Driver<String>
        
        let completeTaps: Signal<Void>
    }
    
    struct WLOutput {
        
        let completing: Driver<Void>
        
        let completed: Driver<WLUserResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let opa = Driver.combineLatest(input.oldpassword, input.password ,input.passwordAgain)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLUserResult> = input
            .completeTaps
            .withLatestFrom(opa)
            .flatMapLatest {
                
                switch mpwdCheckResult($0.0, password: $0.2, passwordAgain: $0.1) {
                case .ok: return onUserVoidResp(WLUserApi.modifyPassword($0.0, password: $0.1))
                    .map({ WLUserResult.ok("修改密码成功") })
                    .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(message: msg): return Driver<WLUserResult>.just(WLUserResult.failed( msg))
                default: return Driver<WLUserResult>.empty()
                    
                }
        }
        
        self.output = WLOutput( completing: completing, completed: completed)
    }
}


public func mpwdCheckResult(_ oldpassword: String,password: String ,passwordAgain: String) -> WLUserResult {
    
    if oldpassword.isEmpty || oldpassword.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6-18位旧密码")
    }
    
    if oldpassword.length < 6 {
        
        return WLUserResult.failed( "请输入6-18位旧密码")
    }
    if password.isEmpty || password.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6-18位新密码")
    }
    
    if password.length < 6 {
        
        return WLUserResult.failed( "请输入6-18位新密码")
    }
    
    if passwordAgain.isEmpty || passwordAgain.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6-18位确认密码")
    }
    
    if passwordAgain.length < 6 {
        
        return WLUserResult.failed( "请输入6-18位确认密码")
    }
    
    if password != passwordAgain {
        return WLUserResult.failed( "新密码和确认密码不一致")
    }
    
    return WLUserResult.ok( "")
}
