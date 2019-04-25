//
//  WLProtocolViewController.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
@objc (WLProtocolViewController)
public class WLProtocolViewController: WLInnerDisposeViewController {
    
    override public func configNaviItem() {
        
        title = "协议与隐私"
    }
    
    var viewModel: WLProtocolViewModel!
    
    override public func configViewModel() {
        
        let inputs = WLProtocolViewModel.WLInput()
        
        viewModel = WLProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: { [weak self] (value) in
                
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    
                    self.loadHTML(value)
                }
                
            })
            .disposed(by: disposed)
    }
}


