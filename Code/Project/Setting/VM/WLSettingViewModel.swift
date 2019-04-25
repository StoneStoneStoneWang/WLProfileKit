//
//  WLSettingViewModel.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
struct WLSettingViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<WLSettingType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    struct WLOutput {
        
        let zip: Observable<(WLSettingType,IndexPath)>
        
        let tableData: Variable<[WLSettingType]>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
    
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let tableData: Variable<[WLSettingType]> = Variable<[WLSettingType]>(WLSettingType.types)
        
        self.output = WLOutput(zip: zip, tableData: tableData)
    }
}

