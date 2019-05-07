//
//  WLPwdViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit

struct WLPwdViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        /* 用户名 序列*/
        let username: Driver<String>
        /* 验证码 序列*/
        let vcode:Driver<String>
        /* 密码 序列*/
        let password:Driver<String>
        /* 验证码点击 序列*/
        let verifyTaps: Signal<Void>
        /* 定时器 序列*/
        let timer: Observable<Int> = Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
        
        let completeTaps: Signal<Void>
        
        let passwordItemSelected: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        
        let passwordItemTaps: Signal<Void>
    }
    
    struct WLOutput {
        /* 获取验证码中 序列*/
        let verifying: Driver<Void>
        /* 获取验证码结果 序列*/
        let verifyed: Driver<WLUserResult>
        
        let completing: Driver<Void>
        
        let completed: Driver<WLUserResult>
        @available(*, deprecated, message: "Please use smsRelay")
        let sms: Variable<(Bool,String)> = Variable<(Bool,String)>((true,"获取验证码"))
        
        let smsRelay: BehaviorRelay<(Bool,String)> = BehaviorRelay<(Bool,String)>(value: (true,"获取验证码"))
        
        let passwordItemed: Driver<Bool>
        
        let passwordEntryed: Driver<Bool>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let uvp = Driver.combineLatest(input.username, input.vcode ,input.password)
        
        let verifying: Driver<Void> = input.verifyTaps.flatMap { Driver.just($0) }
        
        let duration: Int = 60
        
        let verifyed: Driver<WLUserResult> = input
            .verifyTaps
            .withLatestFrom(input.username)
            .flatMapLatest({ (username) in
                
                switch checkPhoneResult(username) {
                case .ok:
                    //
                    
                    
                    let result: Observable<WLUserResult> = Observable<WLUserResult>.create({ (ob) -> Disposable in
                        
                        onUserVoidResp(WLUserApi.smsPassword(username))
                            .subscribe(onNext: { (_) in
                                
                                ob.onNext(WLUserResult.ok("验证码已发送到您的手机，请注意查收"))
                                
                                input.timer
                                    .map({ duration - $0 })
                                    .take(61)
                                    .map({ smsResult(count: $0) })
                                    .map({ WLUserResult.smsOk(isEnabled: $0, title: $1)})
                                    .subscribe(onNext: { (result) in
                                        
                                        ob.onNext(result)
                                    })
                                    .disposed(by: disposed)
                                
                            }, onError: { (error) in
                                
                                ob.onError(error)
                                
                            })
                            .disposed(by: disposed)
                        
                        return Disposables.create { }
                    })
                    
                    return result.asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(message: msg): return Driver<WLUserResult>.just(WLUserResult.failed( msg))
                    
                default: return Driver<WLUserResult>.empty()
                    
                }
            })
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLUserResult> = input
            .completeTaps
            .withLatestFrom(uvp)
            .flatMapLatest {
                
                switch pwdCheckResult($0.0, vcode: $0.1, password: $0.2) {
                case .ok:
                    
                    return onUserVoidResp(WLUserApi.resettingPassword($0.0, password: $0.2, code: $0.1))
                        .map({ WLUserResult.ok("找回密码成功") })
                        .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(message: msg): return Driver<WLUserResult>.just(WLUserResult.failed( msg))
                default: return Driver<WLUserResult>.empty()
                    
                }
        }
        
        let passwordEntryed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in return Driver.just(!input.passwordItemSelected.value) }
        
        let passwordItemed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in
            
            input.passwordItemSelected.accept(!input.passwordItemSelected.value)
            
            return Driver.just(input.passwordItemSelected.value)
        }
        self.output = WLOutput(verifying: verifying, verifyed: verifyed, completing: completing, completed: completed, passwordItemed: passwordItemed, passwordEntryed: passwordEntryed)
    }
}

