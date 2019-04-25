//
//  WLProfileHeaderView.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import WLToolsKit
import WLBaseTableView
import SnapKit

extension Reactive where Base: WLProfileHeaderView {
    
    var user: Binder<WLUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}
@objc (WLProfileHeaderView)
public final class WLProfileHeaderView: WLBaseTableViewCell {
    
    final let topLine: UIView = UIView().then {
        
        $0.backgroundColor = WLHEXCOLOR(hexColor: "#f1f1f1")
    }
    
    final let nameLabel: UILabel = UILabel().then {
        
        $0.textAlignment = .left
        
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    var user: WLUserBean? {
        
        willSet {
            
            guard let newValue = newValue else { return  }
            
            nameLabel.textColor = WLHEXCOLOR(hexColor: WLProfileConfigManager.default.config.itemColor)
            
            if WLAccountCache.default.isLogin() {
                
                var nickname = newValue.nickname
                
                if String.validPhone(phone: nickname) {
                    
                    nickname = (nickname as NSString).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
                }
                
                nameLabel.text = nickname
                
                let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
                
                iconImageView.kf.indicatorType = .activity
                
                if newValue.headImg.isEmpty {
                    
                    self.iconImageView.image = UIImage(named: WLProfileConfigManager.default.config.defaultIcon)
                    
                } else {
                    
                    let icon: String = newValue.headImg + "?x-oss-process=image/resize,w_100,h_100"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: WLProfileConfigManager.default.config.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .forceRefresh
                        ])
                }
                
            } else {
                
                newValue.nickname = "未登录"
                
                iconImageView.image = UIImage(named: WLProfileConfigManager.default.config.defaultIcon)
                
                nameLabel.text = newValue.nickname
            }
            
            iconImageView.layer.borderColor = WLHEXCOLOR(hexColor: WLProfileConfigManager.default.config.itemColor).cgColor
        }
    }
    
    var style: WLProfileStyle = .one {
        
        willSet {
            
            
            
            switch newValue {
            case .one: fallthrough
            case .two:
                
                nameLabel.textAlignment = .left
            case .three: fallthrough
            case .four:
                
                nameLabel.textAlignment = .center
            }
            
            setNeedsDisplay()
        }
    }
}

extension WLProfileHeaderView {
    
    override public func commitInit() {
        super.commitInit()
        addSubview(topLine)
        
        addSubview(nameLabel)
        
        backgroundColor = .white
        
        iconImageView.layer.masksToBounds = true
        
        iconImageView.isUserInteractionEnabled = true
        
        iconImageView.contentMode = .redraw
        
        iconImageView.layer.cornerRadius = 35
        
        iconImageView.layer.borderWidth = 1
        
        accessoryType = .disclosureIndicator
        
        
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        topLine.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(1)
        }
        
        switch style {
        case .one: fallthrough
        case .two:
            
            iconImageView.snp.remakeConstraints { (make) in
                
                make.left.equalTo(15)
                
                make.centerY.equalToSuperview()
                
                make.width.equalTo(70)
                
                make.height.equalTo(70)
            }
            
            nameLabel.snp.remakeConstraints { (make) in
                
                make.left.equalTo(iconImageView.snp.right).offset(15)
                
                make.right.equalTo(0)
                
                make.centerY.equalToSuperview()
            }
        case .four: fallthrough
        case .three:
            
            iconImageView.snp.remakeConstraints { (make) in
                
                make.centerX.centerY.equalToSuperview()
                
                make.width.equalTo(70)
                
                make.height.equalTo(70)
            }
            
            nameLabel.snp.remakeConstraints { (make) in
                
                make.top.equalTo(iconImageView.snp.bottom).offset(15)
                
                make.centerX.equalTo(iconImageView.snp.centerX)
            }
        }
        
    }
    
}
