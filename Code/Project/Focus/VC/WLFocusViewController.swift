//
//  WLFocusViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxDataSources
import WLBaseTableView
import WLToolsKit
import WLThirdUtil.WLHudUtil
import SnapKit

@objc (WLFocusViewController)
open class WLFocusViewController: WLLoadingDisposeF1ViewController {
    
    public var config: WLFocusListConfig!
    
    public var style: WLFocusListStyle = .one
    
    public required init(_ style: WLFocusListStyle,config: WLFocusListConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.config = config
        
        self.style = style
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public final let tableView: WLFocusListTableView = WLFocusListTableView.baseTableView()
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        switch style {
        case .one:
            
            tableView.register(WLFocusList1TableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    typealias Section = MySection<WLFocusBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: WLFocusViewModel!
    
    override open func configViewModel() {
        
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer.isHidden = true
        
        let input = WLFocusViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLFocusBean.self),
                                                 itemSelect: tableView.rx.itemSelected,
                                                 headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
        
        viewModel = WLFocusViewModel(input, disposed: disposed)
        
        let config = self.config
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLFocusListBaseTableViewCell
                
                cell.type = (item,config) as? (WLFocusBean, WLFocusListConfig)
                
                return cell
        }
            ,canEditRowAtIndexPath: {_,_ in
                
                return true
        })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: "", items: [$0]) }) })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { [weak self] (res) in
                guard let `self` = self else { return }
                switch res {
                case .fetchList:
                    self.loadingView.onLoadingStatusChanged(.succ)
                    self.tableView.emptyViewHidden()
                    
                case let .failed(msg):
                    WLHudUtil.showInfo(msg)
                    self.loadingView.onLoadingStatusChanged(.fail)
                case .empty:
                    self.loadingView.onLoadingStatusChanged(.succ)
                    
                    switch self.style {
                    case .one:
                        
                        self.tableView.emptyViewShow(WLFocusList1Empty())
                    }
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}

extension WLFocusViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    override open func configNaviItem() {
        
        title = "我的关注"
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "关注信息", message: "是否取消\(type.users.nickname)拉黑？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                WLHudUtil.show(withStatus: "移除\(type.users.nickname)中...")
                
                onUserVoidResp(WLUserApi.focus(type.users.encoded, targetEncoded: type.encoded))
                    .subscribe(onNext: { [weak self] (_) in

                        guard let `self` = self else { return }

                        WLHudUtil.pop()

                        WLHudUtil.showInfo("移除\(type.users.nickname)成功")

                        self.viewModel.output.tableData.value.remove(at: ip.section)

                        if self.viewModel.output.tableData.value.isEmpty {

                            self.tableView.emptyViewShow(WLFocusList1Empty())
                        }

                        }, onError: { (error) in

                            WLHudUtil.pop()

                            WLHudUtil.showInfo("移除\(type.users.nickname)失败")
                    })
                    .disposed(by: self.disposed)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
