////
////  WLProjectListViewController.swift
////  WLUserKitDemo
////
////  Created by three stone 王 on 2019/4/8.
////  Copyright © 2019 three stone 王. All rights reserved.
////
//
//import Foundation
//import WLReqKit
//import RxDataSources
//import RxSwift
//import RxCocoa
//import WLBaseTableView
//import WebKit
//import WLToolsKit
//import WLThirdUtil
//
//class WLProjectListEmpty: WLTableViewEmptyViewSource {
//    var emptyAText: NSAttributedString {
//        let blackListStyle = NSMutableParagraphStyle()
//        
//        blackListStyle.alignment = .center
//        
//        return NSAttributedString(string: "暂无内容", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: WLHEXCOLOR(hexColor: "#666666") ,NSAttributedString.Key.paragraphStyle: blackListStyle])
//        
//    }
//    
//    var emptyIcon: String { return ""}
//    
//    var emptyIconFrame: CGRect { return .zero }
//    
//    var emptyTextFrame: CGRect { return UIScreen.main.bounds }
//    
//    var emptyFrame: CGRect { return UIScreen.main.bounds }
//    
//    var canResponse: Bool { return true }
//    
//    var emptyBackgroundHex: String { return "#f1f1f1"}
//}
//
//public typealias WLProjectMoreItemBlock = (_ data: [String: Any]) -> ()
//
//public typealias WLProjectDetailBlock = (_ data: [String: Any]) -> ()
//
//@objc public class WLProjectListViewController: WLLoadingDisposeF1ViewController {
//    
//    final let tableView: WLBlackListTableView = WLBlackListTableView.baseTableView()
//    
//    @objc public static func createProjectList(_ tag: String ,moreBlock: @escaping WLProjectMoreItemBlock ,detailBlock:  @escaping WLProjectDetailBlock) -> Self {
//        
//        return self.init(tag,moreBlock: moreBlock,detailBlock: detailBlock)
//    }
//    
//    var tag: String = ""
//    
//    public var moreBlock: WLProjectMoreItemBlock!
//    
//    public var detailBlock: WLProjectDetailBlock!
//    
//    @objc public required init(_ tag: String,moreBlock: @escaping WLProjectMoreItemBlock ,detailBlock:  @escaping WLProjectDetailBlock) {
//        super.init(nibName: nil, bundle: nil)
//        self.tag = tag
//        
//        self.moreBlock = moreBlock
//        
//        self.detailBlock = detailBlock
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override public func addOwnSubViews() {
//        
//        view.addSubview(tableView)
//    }
//    
//    override public func configOwnSubViews() {
//        
//        tableView.snp.makeConstraints { (make) in
//            
//            make.right.left.bottom.equalToSuperview()
//            
//            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
//        }
//        
//        tableView.separatorStyle = .none
//        
//        tableView.register(WLProjectTableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//    
//    typealias Section = MySection<WLProjectBean>
//    
//    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
//    
//    var viewModel: WLProjectListViewModel!
//    
//    override public func configViewModel() {
//        
//        self.tableView.mj_header.beginRefreshing()
//        
//        self.tableView.mj_footer.isHidden = true
//        
//        let input = WLProjectListViewModel.WLInput(tag: Variable<String>(tag),
//                                                   modelSelect: tableView.rx.modelSelected(WLProjectBean.self),
//                                                   itemSelect: tableView.rx.itemSelected,
//                                                   headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
//        
//        viewModel = WLProjectListViewModel(input, disposed: disposed)
//        
//        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
//            animationConfiguration: AnimationConfiguration(insertAnimation: .none, reloadAnimation: .none, deleteAnimation: .fade),
//            decideViewTransition: { _, _, _ in .reload },
//            configureCell: { ds, tv, ip, item in
//                
//                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLProjectTableViewCell
//                
//                cell.projectBean = item
//                
//                cell.indexPath = ip
//                
//                cell.mDelegate = self
//                
//                return cell
//        })
//        
//        viewModel
//            .output
//            .tableData
//            .asDriver()
//            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
//            .drive(tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposed)
//        
//        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
//        
//        endHeaderRefreshing
//            .map({ _ in return true })
//            .drive(tableView.mj_header.rx.endRefreshing)
//            .disposed(by: disposed)
//        
//        endHeaderRefreshing
//            .drive(onNext: { [weak self] (res) in
//                guard let `self` = self else { return }
//                switch res {
//                case .projectList:
//                    self.loadingView.onLoadingStatusChanged(.succ)
//                    self.tableView.emptyViewHidden()
//                    
//                case let .failed(msg):
//                    WLHudUtil.showInfo(msg)
//                    self.loadingView.onLoadingStatusChanged(.fail)
//                case .empty:
//                    self.loadingView.onLoadingStatusChanged(.succ)
//                    self.tableView.emptyViewShow(WLProjectListEmpty())
//                default:
//                    break
//                }
//            })
//            .disposed(by: disposed)
//        
//        self.dataSource = dataSource
//        
//        viewModel
//            .output
//            .zip
//            .subscribe(onNext: { (type,ip) in })
//            .disposed(by: disposed)
//        
//        tableView
//            .rx
//            .setDelegate(self)
//            .disposed(by: disposed)
//    }
//}
//
//extension WLProjectListViewController: UITableViewDelegate {
//    
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let datasource = dataSource else { return 0}
//        
////        return datasource[indexPath].cellHeight
//        
//        return 0
//    }
//    
//    override public func configNaviItem() {
//        
//        title = tag
//    }
//}
//extension WLProjectListViewController: WLProjectTableViewCellDelegate {
//    func onMediaViewClick(_ pro: WLProjectBean, for indexPath: IndexPath) {
//        
//        self.detailBlock(pro.toJSON())
//        
//    }
//    
//    func onWatchItemClick(_ pro: WLProjectBean, for indexPath: IndexPath) {
//        
//        self.detailBlock(pro.toJSON())
//    }
//    
//    func onCommentItemClick(_ pro: WLProjectBean, for indexPath: IndexPath) {
//        
//        self.detailBlock(pro.toJSON())
//    }
//    
//    func onFunItemClick(_ pro: WLProjectBean, for indexPath: IndexPath) {
//        
////        let isLogin = checkLoginAndIsGoLogin(<#WLLoginStyle#>, config: <#WLLoginConfig#>)
////
////        if isLogin {
////
////            if pro.isLaud {
////
////                let alert = UIAlertController(title: "取消点赞？", message: "", preferredStyle: .alert)
////
////                let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in
////
////
////                }
////
////                let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
////
////                    guard let `self` = self else { return }
////
////                    WLHudUtil.show(withStatus: "取消点赞中...")
////
//////                    self.soManager.like(pro.encoded, succ: {[weak self] in
//////
//////                        guard let `self` = self else { return }
//////
//////                        var temp = pro
//////
//////                        temp.isLaud = false
//////
//////                        temp.countLaud -= 1
//////
//////                        self.viewModel.output.tableData.value.replaceSubrange(indexPath.section..<indexPath.section+1, with: [temp])
//////
//////                        WLHudUtil.pop()
//////
//////                        WLHudUtil.showInfo("取消点赞成功")
//////
//////                    }) { (error) in
//////
//////                        WLHudUtil.pop()
//////
//////                        WLHudUtil.showInfo(error)
//////                    }
////                }
////
////                alert.addAction(cancel)
////
////                alert.addAction(confirm)
////
////                present(alert, animated: true, completion: nil)
////
////            } else {
////
////                WLHudUtil.show(withStatus: "点赞中...")
////
//////                soManager.like(pro.encoded, succ: {[weak self] in
//////
//////                    guard let `self` = self else { return }
//////
//////                    var temp = pro
//////
//////                    temp.isLaud = true
//////
//////                    temp.countLaud += 1
//////
//////                    self.viewModel.output.tableData.value.replaceSubrange(indexPath.section..<indexPath.section+1, with: [temp])
//////
//////                    WLHudUtil.pop()
//////
//////                    WLHudUtil.showInfo("点赞成功")
//////
//////                }) { (error) in
//////
//////                    WLHudUtil.pop()
//////
//////                    WLHudUtil.showInfo(error)
//////                }
////            }
////        }
//    }
//    
//    func onMoreItemClick(_ pro: WLProjectBean, for indexPath: IndexPath) {
//        
//        self.moreBlock(pro.toJSON())
//    }
//    
//    func onMediaClick(_ cell: UICollectionViewCell, cIndexPath: IndexPath, data: WLPublishBean, pro: WLProjectBean) {
//        
////        if data.type == "image" {
////
////            let imageShow = WLImageShowViewController.createImageShow(data.value)
////
////            imageShow.show(self)
////        } else if data.type == "video" {
////
////            let video = WLVideoShowViewController.createVideoShow(data.value)
////
////            video.show(self)
////        }
//    }
//}
