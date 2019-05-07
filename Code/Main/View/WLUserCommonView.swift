////
////  WLUserCommonView.swift
////  WLUserKitDemo
////
////  Created by three stone 王 on 2019/4/4.
////  Copyright © 2019 three stone 王. All rights reserved.
////
//
//import Foundation
//import UIKit
//import WLToolsKit
//import Kingfisher
//
//@objc public final class WLUserCommonView: UIView {
//    
//    public var subtitleLabel: UILabel = UILabel().then {
//        
//        $0.tag = 2002
//        
//        $0.font = UIFont.systemFont(ofSize: 15)
//        
//        $0.textAlignment = .right
//        
//        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
//    }
//    public var iconImageView: UIImageView = UIImageView().then {
//        
//        $0.contentMode = .scaleAspectFill
//        
//        $0.layer.cornerRadius = 20
//        
//        $0.layer.masksToBounds = true
//    }
//    
//    public var titleLabel: UILabel = UILabel().then {
//        
//        $0.font = UIFont.systemFont(ofSize: 15)
//        
//        $0.textAlignment = .left
//        
//        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
//    }
//    
//    public var tagLabel: UILabel = UILabel().then {
//        
//        $0.font = UIFont.systemFont(ofSize: 15)
//        
//        $0.textAlignment = .left
//        
//        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
//    }
//    
//    public var timeLabel: UILabel = UILabel().then {
//        
//        $0.tag = 2002
//        
//        $0.font = UIFont.systemFont(ofSize: 15)
//        
//        $0.textAlignment = .left
//        
//        $0.textColor = WLHEXCOLOR(hexColor: "#333333")
//    }
//    
//    public var user: WLUserBean? {
//        
//        willSet {
//            guard let newValue = newValue else { return }
//            
//            titleLabel.text = newValue.nickname
//            
//            let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 20)
//            
//            iconImageView.kf.indicatorType = .activity
//            
//            let icon: String = newValue.headImg + "?x-oss-process=image/resize,w_100,h_100"
//            
////            iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: WLGlobalManager.default.styleConfig.defaultIcon), options: [
////                .processor(processor),
////                .scaleFactor(UIScreen.main.scale),
////                .transition(.fade(0.3)),
////                .fromMemoryCacheOrRefresh
////                ])
//        }
//    }
//    
//    public var tags: String = "" {
//        
//        willSet {
//            
//            tagLabel.isHidden = newValue.isEmpty
//            
//            tagLabel.text = newValue
//        }
//    }
//    
//    public var time: String = "" {
//        
//        willSet {
//            
//            subtitleLabel.text = newValue
//        }
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
//    func commitInit() {
//        
//        addSubview(iconImageView)
//        
//        addSubview(titleLabel)
//        
//        addSubview(subtitleLabel)
//        
//        addSubview(timeLabel)
//        
//        addSubview(tagLabel)
//        
//        tagLabel.isHidden = true
//    }
//    
//}
//extension WLUserCommonView {
//    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        iconImageView.snp.makeConstraints { (make) in
//            
//            make.left.top.equalTo(wl_main_margin)
//            
//            make.width.height.equalTo(40)
//        }
//        
//        titleLabel.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(iconImageView.snp.right).offset(wl_main_margin)
//            
//            make.bottom.equalTo(iconImageView.snp.centerY).offset(-1)
//        }
//        subtitleLabel.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(iconImageView.snp.right).offset(wl_main_margin)
//            
//            make.top.equalTo(iconImageView.snp.centerY).offset(1)
//        }
//        
//        tagLabel.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(titleLabel.snp.right).offset(wl_main_margin)
//            
//            make.centerY.equalTo(titleLabel.snp.centerY)
//        }
//    }
//}
