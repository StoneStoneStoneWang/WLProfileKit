//
//  WLPublisViewModel.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit
import WLReqKit
import ObjectMapper

public final class WLPublishViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let tag: String
        
        let title: Driver<String>
        
        let modelSelect: ControlEvent<WLPublishBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let textTaps: Signal<Void>
        
        let imageTaps: Signal<Void>
        
        let videoTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[WLPublishBean]> = BehaviorRelay<[WLPublishBean]>(value: [])
    }
    
    public struct WLOutput {
        
        let zip: Observable<(WLPublishBean,IndexPath)>
        /* 完成 序列*/
        let completing: Driver<Void>
        /* 完成结果 */
        let completed: Driver<WLUserResult>
        
        /* 选择文案 序列*/
        let textTaped: Driver<Void>
        /* 完成 序列*/
        let imageTaped: Driver<Void>
        
        /* 完成 序列*/
        let videoTaped: Driver<Void>
    }
    
    public init(_ input: WLInput,style: WLPublishStyle) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let combine = Driver.combineLatest(input.title, input.tableData.asDriver())
        
        let completed: Driver<WLUserResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {
                
                if $0.0.wl_isEmpty { return Driver.just(WLUserResult.failed("请输入标题")) }
                
                if style == .image {
                    
                    if $0.1.count == 0 { return Driver.just(WLUserResult.failed("请选择图片")) }
                    
                    if !$0.1.contains(where: { $0.type == "image" }) { return Driver.just(WLUserResult.failed("请选择至少一张图片")) }
                }
                
                if style == .video {
                    
                    if $0.1.count == 0 { return Driver.just(WLUserResult.failed("请选择视频")) }
                    
                    if !$0.1.contains(where: { $0.type == "video" }) { return Driver.just(WLUserResult.failed("请选择视频")) }
                }
                
                if style == .mix {
                    
                    if $0.1.count == 0 { return Driver.just(WLUserResult.failed("请选择至少一张图片或者视频")) }
                    
                    if !($0.1.contains(where: { $0.type == "image" }) || $0.1.contains(where: { $0.type == "video" }) ) { return Driver.just(WLUserResult.failed("请选择至少一张图片或者视频")) }
                }
                
                var title = WLPublishBean()
                
                title.type = "title"
                
                title.value = $0.0
                
                var result = [title]
                
                result += $0.1
                
                let content = WLJsonCast.cast(argu: result.toJSON())
                
                return onUserDictResp(WLMainApi.publish(input.tag, content: content))
                    .mapObject(type: WLCircleBean.self)
                    .map({ WLUserResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLUserResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        let textTaped = input.textTaps.flatMap { Driver.just($0) }
        
        let imageTaped = input.imageTaps.flatMap { Driver.just($0) }
        
        let videoTaped = input.videoTaps.flatMap { Driver.just($0) }
        
        self.output = WLOutput(zip: zip, completing: completing, completed: completed, textTaped: textTaped, imageTaped: imageTaped, videoTaped: videoTaped)
    }
}

extension WLPublishViewModel {
    
    public func removeContent(_ idx: Int) {
        
        var value = input.tableData.value
        
        value.remove(at: idx)
        
        input.tableData.accept(value)
        
    }
    public func replaceContent(_ idx: Int ,pub: WLPublishBean) {
        
        //        input.tableData.value.replaceSubrange(<#T##subrange: Range<Int>##Range<Int>#>, with: [pub])
    }
}
