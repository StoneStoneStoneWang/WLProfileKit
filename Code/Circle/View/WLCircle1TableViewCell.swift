//
//  WLCircle1TableViewCell.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import SnapKit
import Kingfisher
import WLToolsKit

public final class WLCircle1TableViewCell: WLCircleBaseTableViewCell {
    
    public override var type: (WLCircleBean, WLCircleConfig)! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            //            moreItem.setImage(UIImage(named: newValue.1.moreIcon), for: .normal)
            
            let title = newValue.0.contentMap.first!
            
            titleLabel.text = title.value
            
            var subTitle: WLPublishBean!
            
            for item in newValue.0.contentMap {
                
                if item.type == "txt" {
                    
                    subTitle = item
                    
                    break
                }
            }
            
            var media: WLPublishBean!
            
            for item in newValue.0.contentMap {
                
                if item.type == "image" {
                    
                    media = item
                    
                    break
                } else if item.type == "video"{
                    
                    media = item
                    
                    break
                }
            }
            
            if let subTitle = subTitle {
                
                subtitleLabel.text = subTitle.value
            } else {
                
                subtitleLabel.text = title.value
            }
            
            if let media = media {
                
                let processor = DefaultImageProcessor() >> RoundCornerImageProcessor(cornerRadius: 30)
                
                iconImageView.kf.indicatorType = .activity
                
                if media.type == "image" {
                    
                    let icon: String = media.value + "?x-oss-process=image/resize,w_500,h_500"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                } else {
                    
                    let icon: String = media.value + "?x-oss-process=video/snapshot,t_7000,f_jpg,w_500,h_500,m_fast"
                    
                    self.iconImageView.kf.setImage(with: URL(string: icon), placeholder: UIImage(named: newValue.1.defaultIcon), options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.3)),
                        .fromMemoryCacheOrRefresh
                        ])
                }
            }
        }
    }
    
    public final let subtitleLabel: UILabel = UILabel().then {
        
        $0.tag = 2003
        
        $0.font = UIFont.systemFont(ofSize: 12)
        
        $0.textAlignment = .left
        
        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
        
        $0.numberOfLines = 2
    }
    
    public override func commitInit() {
        super.commitInit()
        
        iconImageView.layer.masksToBounds = true
        
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(subtitleLabel)
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let h = bounds.height - 30
        
        let w = h
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(15)
            
            make.bottom.equalTo(-15)
            
            make.width.equalTo(w)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.top.equalTo(iconImageView.snp.top)
            
            make.right.equalTo(-15)
        }
        
        moreItem.sizeToFit()
        
        moreItem.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            
            make.width.height.equalTo(30)
            
            //            make.left.equalTo(subtitleLabel.snp.right).offset(15)
            
            make.bottom.equalTo(iconImageView.snp.bottom).offset(3)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            
            make.bottom.equalTo(iconImageView.snp.bottom)
            
            make.right.equalTo(moreItem.snp.left).offset(-15)
        }
    }
}
