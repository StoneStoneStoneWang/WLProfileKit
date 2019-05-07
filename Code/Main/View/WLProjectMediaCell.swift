////
////  WLProjectMediaView.swift
////  WLUserKitDemo
////
////  Created by three stone 王 on 2019/4/8.
////  Copyright © 2019 three stone 王. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Kingfisher
//import SnapKit
//import WLToolsKit
//
//protocol WLProjectMediaCellDelegate {
//    
//    func onMediaClick(_ cell: UICollectionViewCell)
//}
//
//
//@objc public final class WLProjectMediaCell: UICollectionViewCell {
//    
//    var mDelegate: WLProjectMediaCellDelegate!
//    
//    public final let iconImageView: UIImageView = UIImageView().then {
//        
//        $0.contentMode = .center
//    }
//    
//    public final let coverImageView: UIImageView = UIImageView().then {
//        
//        $0.backgroundColor = .black
//        
//        $0.alpha = 0.5
//    }
//    
//    @objc public override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        commitInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc var media: String = "" {
//        
//        willSet {
//            
//            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
//            
//            iconImageView.kf.indicatorType = .activity
//            
////            iconImageView.kf.setImage(with: URL(string: newValue), placeholder: UIImage(named: WLGlobalManager.default.styleConfig.defaultIcon), options: [
////                .processor(processor),
////                .scaleFactor(UIScreen.main.scale),
////                .transition(.none),
////                .fromMemoryCacheOrRefresh
////                ])
//        }
//    }
//    @objc var isVideo: Bool = false {
//        
//        willSet {
//            
//            coverImageView.isHidden = !newValue
//        }
//    }
//}
//
//extension WLProjectMediaCell {
//    
//    public func commitInit() {
//        
//        addSubview(iconImageView)
//        
//        addSubview(coverImageView)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(onMediaClick))
//        
//        addGestureRecognizer(tap)
//    }
//    @objc func onMediaClick() {
//        
//        guard let delegate = mDelegate else { return }
//        
//        delegate.onMediaClick(self)
//        
//    }
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        iconImageView.snp.makeConstraints { (make) in
//            
//            make.left.right.top.bottom.equalToSuperview()
//        }
//        
//        coverImageView.snp.makeConstraints { (make) in
//            
//            make.left.right.top.bottom.equalToSuperview()
//        }
//    }
//}
