//
//  WLUpdateNameViewModel.swift
//  WLContact
//
//  Created by three stone 王 on 2018/12/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseViewModel
import WLToolsKit

class WLUpdateNameViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let orignal: Driver<String>
        
        let updated:Driver<String>
        
        let completTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        let completeEnabled: Driver<Bool>
        
        let completing: Driver<Void>
        
        let completed: Driver<WLUserResult>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let ou = Driver.combineLatest(input.orignal, input.updated)
        
        let completEnabled = ou.flatMapLatest { return Driver.just($0.0 != $0.1 && !$0.1.isEmpty && !$0.1.wl_isEmpty) }
        
        let completing: Driver<Void> = input.completTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLUserResult> = input.completTaps
            .withLatestFrom(input.updated)
            .flatMapLatest({
                return onUserDictResp(WLUserApi.updateUserInfo(WLUserInfoType.name.updateKey, value: $0))
                .mapObject(type: WLUserBean.self)
                .map { WLUserResult.updateUserInfoSucc($0, msg: WLUserInfoType.name.title + "修改成功")}
                .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) }) })
        
        self.output = WLOutput(completeEnabled: completEnabled, completing: completing, completed: completed)
    }
}
