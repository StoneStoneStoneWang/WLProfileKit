//
//  WLPublishCollectionViewCell.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLComponentView
import SnapKit
import WLToolsKit

open class WLPublishCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: WLBaseTextField!
    
    var iconImageView: UIImageView = UIImageView(frame: .zero)
    
    var broadItem: UIButton = UIButton(type: .custom)
    
    var deleteItem: UIButton = UIButton(type: .custom)
    
    var bean: (WLPublishStyle ,WLPublishBean)?
    
//        {
//
//        willSet {
//
//            guard let newValue = newValue else { return }
//
//            broadItem.isHidden = true
//
//            deleteItem.isHidden = true
//
//            iconImageView.isHidden = true
//
//            switch newValue.1.type {
//            case "image":
//
//                iconImageView.isHidden = false
//
//                deleteItem.isHidden = false
//
//                iconImageView.snp.remakeConstraints { (make) in
//
//                    make.left.top.equalTo(10)
//
//                    make.bottom.equalTo(-10)
//
//                    make.right.equalTo(-10)
//                }
//
//            case "video":
//
//                iconImageView.isHidden = false
//
//                deleteItem.isHidden = false
//
//                broadItem.isHidden = false
//
//            default:
//
//                switch newValue.0 {
//                case .zero: break
//
//                default:
//
//                    titleLabel = WLNickNameTextField(frame: .zero)
//
//                    contentView.addSubview(titleLabel)
//
//                    titleLabel.snp.remakeConstraints { (make) in
//
//                        make.left.right.top.bottom.equalToSuperview()
//                    }
//
//                    titleLabel.textColor = WLHEXCOLOR(hexColor: "#666666")
//
//                    titleLabel.isUserInteractionEnabled = false
//                }
//            }
//        }
//    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func commitInit() {
        
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(broadItem)
        
        contentView.addSubview(deleteItem)
        
        backgroundColor = .white
    }
}
extension WLPublishCollectionViewCell {

    
}
