//
//  WLProjectMeidaView.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

@objc protocol WLProjectMeidaViewDelegate: NSObjectProtocol {
    
    @objc optional func onMediaViewClick()
    
    @objc optional func onMediaClick(_ cell: UICollectionViewCell ,cIndexPath: IndexPath ,data: WLProjectTypeBean) 
}
@objc public final class WLProjectMeidaView: UICollectionView {
    
    @objc public var medias: [WLProjectTypeBean] = [] {
        
        willSet {
            
            guard !newValue.isEmpty else { return }
            
            layout.sectionInset = .zero
            
            layout.minimumLineSpacing = 5
            
            layout.minimumInteritemSpacing = 5
            
            let w = ( WL_SCREEN_WIDTH - wl_margin * 2 - 5 * 2) / 3
            
            var h: CGFloat = 0
            
            if WLMainGlobal.default.styleConfig.mediaStyle == "1*1" {
                //                1*1 4*3 2*1
                h = w
            } else if WLMainGlobal.default.styleConfig.mediaStyle == "4*3" {
                
                h = w * 3 / 4
            } else if WLMainGlobal.default.styleConfig.mediaStyle == "2*1" {
                
                h = w / 2
            } else {
                
                h = w
            }
            
            layout.itemSize = CGSize(width: w, height: h)
            
            reloadData()
        }
    }
    
    @objc public static func project() -> Self {
        
        let layout = UICollectionViewFlowLayout()
        
        return self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    @objc public var layout: UICollectionViewFlowLayout!
    
    @objc public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.layout = layout as? UICollectionViewFlowLayout
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var mDelegate: WLProjectMeidaViewDelegate!
    
}
extension WLProjectMeidaView {
    
    @objc public func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        bounces = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGR))
        
        addGestureRecognizer(tap)
        
        register(WLProjectMediaCell.self, forCellWithReuseIdentifier: "cell")
        
        dataSource = self
        
        delegate = self
        
        backgroundColor = .clear
    }
}

extension WLProjectMeidaView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return medias.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WLProjectMediaCell
        
        let media = medias[indexPath.row]
        
        if media.type == "video" {
            
            cell.media = media.value + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_800,h_800,m_fast"
        } else {
            
            cell.media = media.value + "?x-oss-process=image/resize,w_300,h_300"
        }
        
        cell.isVideo = media.type == "video"
        
        cell.mDelegate = self
        
        return cell
    }
}

extension WLProjectMeidaView {
    
    @objc func tapGR() {
        
        guard let delegate = mDelegate else { return }
        
        delegate.onMediaViewClick?()
    }
}
extension WLProjectMeidaView: WLProjectMediaCellDelegate {
    
    func onMediaClick(_ cell: UICollectionViewCell) {
        
        guard let delegate = mDelegate ,let ip = indexPath(for: cell)else { return }
        
        delegate.onMediaClick?(cell, cIndexPath: ip, data: medias[ip.row])
    }
}
extension WLProjectMeidaView: UICollectionViewDelegate {
    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//
//        guard let delegate = mDelegate else { return }
//
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
//
//        delegate.onMediaClick?(cell, cIndexPath: indexPath, data: medias[indexPath.row])
//    }
}
