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
        
        let tableData: Variable<[WLFocusBean]> = Variable<[WLFocusBean]>([])
        
        let endHeaderRefreshing: Driver<WLUserResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return onUserArrayResp(WLMainApi.fetchMyFocus(1))
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
                    
                    output.tableData.value = items as! [WLFocusBean]
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
