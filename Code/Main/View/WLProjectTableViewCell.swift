////
////  WLProjectTableViewCell.swift
////  WLUserKitDemo
////
////  Created by three stone 王 on 2019/4/8.
////  Copyright © 2019 three stone 王. All rights reserved.
////
//
//import Foundation
//import WLBaseTableView
//import WLToolsKit
//protocol WLProjectTableViewCellDelegate: NSObjectProtocol {
//    
////    func onMediaViewClick(_ pro: WLProjectBean ,for indexPath: IndexPath)
////
////    func onMediaClick(_ cell: UICollectionViewCell ,cIndexPath: IndexPath ,data: WLProjectTypeBean ,pro: WLProjectBean )
////
////    func onWatchItemClick(_ pro: WLProjectBean,for indexPath: IndexPath)
////
////    func onCommentItemClick(_ pro: WLProjectBean,for indexPath: IndexPath)
////
////    func onFunItemClick(_ pro: WLProjectBean,for indexPath: IndexPath)
////
////    func onMoreItemClick(_ pro: WLProjectBean,for indexPath: IndexPath)
//}
//
//@objc public final class WLProjectTableViewCell: WLBaseTableViewCell {
//    
//    var mDelegate: WLProjectTableViewCellDelegate!
//    
//    var indexPath: IndexPath!
//    
//    public final let commonView: WLUserCommonView = WLUserCommonView(frame: .zero)
//    
//    public final let subTitleLable: UILabel = UILabel().then {
//        
//        $0.tag = 2009
//        
//        $0.font = UIFont.systemFont(ofSize: 13)
//        
//        $0.textAlignment = .left
//        
//        $0.textColor = WLHEXCOLOR(hexColor: "#666666")
//        
//        $0.numberOfLines = 0
//    }
//    
//    public final let mediaView: WLProjectMeidaView = WLProjectMeidaView.project()
//    
//    public final let funcView: WLProjectFuncView = WLProjectFuncView.project()
//    
//    public final let moreItem: UIButton = UIButton(type: .custom)
//    
//    public var projectBean: WLProjectBean? {
//        
//        willSet {
//            
//            guard let newValue = newValue else { return }
//            
//            commonView.user = newValue.users
//            
//            commonView.time = "\(newValue.intime)"
//            
////            titleLabel.text = newValue.titleBean.value
////
////            subTitleLable.text = newValue.subTitle.value
//            
////            mediaView.medias = newValue.medias
//            
//            funcView.projectBean = newValue
//        }
//    }
//}
//
//extension WLProjectTableViewCell {
//    
//    public override func commitInit() {
//        super.commitInit()
//        
//        contentView.addSubview(commonView)
//        
//        contentView.addSubview(subTitleLable)
//        
//        contentView.addSubview(mediaView)
//        
//        contentView.addSubview(funcView)
//        
//        contentView.addSubview(moreItem)
//        
//        mediaView.mDelegate = self
//        funcView.mDelegate = self
//    }
//    
//}
//extension WLProjectTableViewCell: WLProjectFuncCellDelegate ,WLProjectMeidaViewDelegate {
//    func onWatchItemClick() {
//        
//        guard let delegate = mDelegate ,let projectBean = projectBean else { return }
//        
//        delegate.onWatchItemClick(projectBean, for: indexPath)
//    }
//    
//    func onCommentItemClick() {
//        guard let delegate = mDelegate ,let projectBean = projectBean else { return }
//        
//        delegate.onWatchItemClick(projectBean,for: indexPath)
//    }
//    
//    func onFunItemClick() {
//        guard let delegate = mDelegate ,let projectBean = projectBean else { return }
//        
//        delegate.onFunItemClick(projectBean,for: indexPath)
//    }
//    
//    @objc func onMediaViewClick() {
//        guard let delegate = mDelegate ,let projectBean = projectBean else { return }
//        
//        delegate.onMediaViewClick(projectBean,for: indexPath)
//    }
//    
//    @objc func onMediaClick(_ cell: UICollectionViewCell ,cIndexPath: IndexPath ,data: WLProjectTypeBean) {
//        
//        guard let delegate = mDelegate ,let projectBean = projectBean else { return }
//        
//        delegate.onMediaClick(cell, cIndexPath: cIndexPath, data: data, pro: projectBean)
//    }
//}
//
//extension WLProjectTableViewCell {
//    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        commonView.snp.makeConstraints { (make) in
//            
//            make.left.top.right.equalToSuperview()
//            
//            make.height.equalTo(65)
//        }
//        
//        titleLabel.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(wl_main_margin)
//            
//            make.top.equalTo(commonView.snp.bottom)
//            
//            make.height.equalTo(30)
//        }
//        
//        subTitleLable.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(wl_main_margin)
//            
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            
//            make.right.equalTo(-wl_main_margin)
//        }
//        
//        let w = ( WL_SCREEN_WIDTH - wl_margin * 2 - 5 * 2) / 3
//        
//        var h: CGFloat = 0
//        
//        if WLMainGlobal.default.styleConfig.mediaStyle == "1*1" {
//            //                1*1 4*3 2*1
//            h = w
//        } else if WLMainGlobal.default.styleConfig.mediaStyle == "4*3" {
//            
//            h = w * 3 / 4
//        } else if WLMainGlobal.default.styleConfig.mediaStyle == "2*1" {
//            
//            h = w / 2
//        } else {
//            
//            h = w
//        }
//        
//        mediaView.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(wl_main_margin)
//            
//            make.right.equalTo(-wl_main_margin)
//            
//            make.top.equalTo(subTitleLable.snp.bottom).offset(5)
//            
//            make.height.equalTo(h)
//        }
//        funcView.snp.makeConstraints { (make) in
//            
//            make.left.equalTo(wl_main_margin)
//            
//            make.width.equalTo(200)
//            
//            make.top.equalTo(mediaView.snp.bottom)
//            
//            make.height.equalTo(40)
//        }
//    }
//}
