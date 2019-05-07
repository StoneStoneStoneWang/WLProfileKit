//
//  WLAboutViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

struct WLAboutViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLAboutType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    struct WLOutput {
        
        let zip: Observable<(WLAboutType,IndexPath)>
        
        let tableData: BehaviorRelay<[WLAboutType]>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let tableData: BehaviorRelay<[WLAboutType]> = BehaviorRelay<[WLAboutType]>(value: WLAboutType.types)
        
        self.output = WLOutput(zip: zip, tableData: tableData)
    }
}
