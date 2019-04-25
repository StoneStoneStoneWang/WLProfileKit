//
//  UIViewController+ActionShow.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc public func imageActionShow() {
        
        let alert = UIAlertController(title: "选择图片", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
            
            
        }
        
        let photo = UIAlertAction(title: "相册", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            self.wl_imagePhotoShow()
        }
        
        let camera = UIAlertAction(title: "相机", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            self.wl_imageCameraShow()
        }
        
        alert.addAction(cancel)
        
        alert.addAction(photo)
        
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc public func videoActionShow() {
        
        let alert = UIAlertController(title: "选择视频", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
            
            
        }
        
        let photo = UIAlertAction(title: "相册", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            self.wl_videoPhotoShow()
        }
        
        let camera = UIAlertAction(title: "相机", style: .default) { [weak self] (a) in
            
            guard let `self` = self else { return }
            
            self.wl_videoCameraShow()
        }
        
        alert.addAction(cancel)
        
        alert.addAction(photo)
        
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
    }
}
extension UIViewController {
    
    @objc open func wl_imagePhotoShow() { }
    
    @objc open func wl_imageCameraShow() { }
    
    @objc open func wl_videoPhotoShow() { }
    
    @objc open func wl_videoCameraShow() { }
}
