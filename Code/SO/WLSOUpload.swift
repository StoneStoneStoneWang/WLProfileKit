//
//  WLSOUpload.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLThirdUtil.WLHudUtil

extension WLSOManager {
    
    @objc public func onUploadImag(_ data: Data,succ: @escaping (String) -> ()) {
        
        WLHudUtil.show(withStatus: "图片上传中")
        
        WLUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (res) in
                
                switch res {
                case let .aliToken(token):
                    
                    DispatchQueue.global().async {
                        
                        onUploadPubImgResp(data, file: "circle", param: token.credentials)
                            .subscribe(onNext: { (value) in
                                
                                DispatchQueue.main.async {
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo("图片上传成功")
                                    
                                    succ(value)
                                }
                                
                            }, onError: { (error) in
                                
                                DispatchQueue.main.async {
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo( "上传图片失败")
                                }
                                
                            }).disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    WLHudUtil.pop()
                    
                    WLHudUtil.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    
    @objc func onUploadVideo(_ view: UIView,data: Data,succ: @escaping (String) -> ()) {
        
        WLHudUtil.show(withStatus: "视频上传中...")
        
        WLUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (res) in
                
                switch res {
                case let .aliToken(token):
                    
                    DispatchQueue.global().async {
                        
                        onUploadVideoResp(data, file: "circle", param: token.credentials)
                            .subscribe(onNext: { (value) in
                                
                                DispatchQueue.main.async {
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo("上传视频成功")
                                    
                                    succ(value)
                                }
                                
                            }, onError: { (error) in
                                
                                DispatchQueue.main.async {
                                    
                                    WLHudUtil.pop()
                                    
                                    WLHudUtil.showInfo("视频上传失败")
                                }
                                
                            }).disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    WLHudUtil.pop()
                    
                    WLHudUtil.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}
