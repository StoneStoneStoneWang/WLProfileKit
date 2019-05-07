//
//  WLFocusViewModel.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLToolsKit

struct WLFocusViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLFocusBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
    }
    struct WLOutput {
        
        let zip: Observable<(WLFocusBean,IndexPath)>
        
        let tableData: BehaviorRelay<[WLFocusBean]> = BehaviorRelay<[WLFocusBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLUserResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
                return onUserArrayResp(WLUserApi.fetchMyFocus(1))
                    .mapArray(type: WLFocusBean.self)
                    .map({ return $0.count > 0 ? WLUserResult.fetchList($0) : WLUserResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.tableData.accept(items as! [WLFocusBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension WLFocusViewModel {
    
    public static func removeFocus(_ uid: String ,encode: String) -> Driver<WLUserResult> {
        
        return onUserVoidResp(WLUserApi.focus(uid, targetEncoded: encode))
            .flatMapLatest({ return Driver.just(WLUserResult.ok("移除成功")) })
            .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
