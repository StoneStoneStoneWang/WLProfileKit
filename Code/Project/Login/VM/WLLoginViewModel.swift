//
//  WLLoginViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa
import WLReqKit
import ObjectMapper

struct WLLoginViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        /* 用户名 序列*/
        let username: Driver<String>
        /* 密码 序列*/
        let password: Driver<String>
        /* 登录按钮点击 序列*/
        let loginTaps: Signal<Void>
        
        let swiftLoginTaps: Signal<Void>
        
        let forgetTaps: Signal<Void>
        
        let passwordItemSelected: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        
        let passwordItemTaps: Signal<Void>
    }
    struct WLOutput {
        
        /* 登录中... 序列*/
        let logining: Driver<Void>
        /* 登录结果... 序列*/
        let logined: Driver<WLUserResult>
        // 忘记密码点击回掉
        let swiftLogined: Driver<Void>
        
        let forgeted: Driver<Void>
        
        let passwordItemed: Driver<Bool>
        
        let passwordEntryed: Driver<Bool>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        // 用户名 密码合并
        let uap = Driver.combineLatest(input.username, input.password)
        
        let logining = input.loginTaps.flatMap { Driver.just($0) }
        
        let logined: Driver<WLUserResult> = input
            .loginTaps
            .withLatestFrom(uap)
            .flatMapLatest {
                
                switch loginCheckResult($0.0, password: $0.1) {
                case .ok:
                    
                    return onUserDictResp(WLUserApi.login($0.0,password: $0.1))
                        .mapObject(type: WLAccountBean.self)
                        .map({ WLAccountCache.default.saveAccount(acc: $0) }) // 存储account
                        .map({ $0.toJSON()})
                        .mapObject(type: WLUserBean.self)
                        .map({ WLUserInfoCache.default.saveUser(data: $0) })
                        .map({ _ in WLUserResult.logined })
                        .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(msg): return Driver<WLUserResult>.just(WLUserResult.failed(msg))
                    
                default: return Driver<WLUserResult>.empty()
                }
        }
        
        let swiftLogined = input.swiftLoginTaps.flatMapLatest { Driver.just($0) }
        
        let forgeted = input.forgetTaps.flatMapLatest { Driver.just($0) }
        
        let passwordEntryed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in return Driver.just(!input.passwordItemSelected.value) }
        
        let passwordItemed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in
            
            input.passwordItemSelected.accept(!input.passwordItemSelected.value)
            
            return Driver.just(input.passwordItemSelected.value)
        }
        
        self.output = WLOutput(logining: logining, logined: logined ,swiftLogined: swiftLogined, forgeted: forgeted, passwordItemed: passwordItemed, passwordEntryed: passwordEntryed)
    }
}
public func loginCheckResult(_ username: String ,password: String) -> WLUserResult {
    
    if username.isEmpty || username.wl_isEmpty {
        
        return WLUserResult.failed("请输入手机号")
    }
    
    if !String.validPhone(phone: username) {
        return WLUserResult.failed("请输入11位手机号")
    }
    
    if password.isEmpty || password.wl_isEmpty {
        
        return WLUserResult.failed("请输入6-18密码")
    }
    
    if password.length < 6 {
        
        return WLUserResult.failed("请输入6-18密码")
    }
    
    return WLUserResult.ok("验证成功")
}
