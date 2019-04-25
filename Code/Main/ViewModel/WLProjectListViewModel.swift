//
//  WLProjectListViewModel.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLToolsKit

struct WLProjectListViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let page: Variable<Int> = Variable<Int>(1)
        
        let tag: Variable<String>
        
        let modelSelect: ControlEvent<WLProjectBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
    }
    struct WLOutput {
        
        let zip: Observable<(WLProjectBean,IndexPath)>
        
        let tableData: Variable<[WLProjectBean]> = Variable<[WLProjectBean]>([])
        
        let endHeaderRefreshing: Driver<WLMainResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let combine = Driver.combineLatest(input.page.asDriver(), input.tag.asDriver())
        
        let headerRefreshData = input
            .headerRefresh
            .withLatestFrom(combine)
            .flatMapLatest({ (_,_) in
//                return onUserArrayResp(WLMainApi.fetchList($0.1, page: $0.0 == 1 ? $0.0 : 1))
//                    .mapArray(type: WLProjectBean.self)
//                    .map({ return $0.count > 0 ? WLMainResult.projectList($0) : WLMainResult.empty })
//                    .asDriver(onErrorRecover: { return Driver.just(WLMainResult.failed(($0 as! WLBaseError).description.0)) })
                
                return Driver.just(WLMainResult.empty)
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .projectList(items):
                    
                    output.tableData.value.removeAll()
                    
                    output.tableData.value += items
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
