//
//  WLSignatureBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLThirdUtil.WLHudUtil
import WLBaseViewController

extension Reactive where Base: WLSignatureBaseViewController {
    
    public var complete: Observable<WLUserBean> {
        
        return self.base.userBean.asObservable()
    }
}

@objc (WLSignatureBaseViewController)
open class WLSignatureBaseViewController: WLF1DisposeViewController {
    
    public var config: WLUserInfoConfig!
    
    public required init(_ config: WLUserInfoConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let userBean: BehaviorRelay<WLUserBean> = BehaviorRelay<WLUserBean>(value: WLUserInfoCache.default.userBean)
    
    final let signaturetv: UITextView = UITextView(frame: .zero).then {
        
        $0.font = UIFont.systemFont(ofSize: 15)
        
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    var observer = Observable<String>.empty()
    
    final let completeItem = UIButton(type: .custom).then {
        
        $0.setTitle("完成", for: .normal)
        
        $0.setTitle("完成", for: .highlighted)
        
        $0.setTitle("完成", for: .disabled)
        
        $0.sizeToFit()
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    override open func configNaviItem() {
        
        title = "个性签名"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeItem)
        
        if let config = config {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(imageName: config.backIcon, target: self, action: #selector(dismissa))
        }
    }
    
    fileprivate var viewModel: WLSignatureViewModel!
    
    open override func configViewModel() {
        
        let inputs = WLSignatureViewModel.WLInput(orignal: signature.asDriver(),
                                                  updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                  completTaps: completeItem.rx.tap.asSignal())
        
        viewModel = WLSignatureViewModel(inputs)
        
        viewModel
            .output
            .completeEnabled
            .drive(completeItem.rx.isEnabled)
            .disposed(by: disposed)
        
        viewModel
            .output
            .completing
            .drive(onNext: { [weak self] (_) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "修改昵称...")
                
                self.signaturetv.resignFirstResponder()
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .completed
            .drive(onNext: { [weak self ] (result) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.pop()
                
                switch result {
                case let .updateUserInfoSucc(user, msg: msg):
                    
                    self.userBean.accept(user as! WLUserBean)
                    
                    WLHudUtil.showInfo(msg)
                    
                    self.dismissa()
                    
                case let .failed(msg):
                    
                    WLHudUtil.showInfo(msg)
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signaturetv.becomeFirstResponder()
    }
    
    @objc func dismissa() {
        
        view.endEditing(true)
        
        dismiss(animated: true, completion: nil)
    }
}

