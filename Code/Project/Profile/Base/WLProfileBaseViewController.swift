//
//  WLProfileBaseViewController.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import RxDataSources
import WLToolsKit
import WLThirdUtil.WLHudUtil


@objc (WLProfileBaseViewController)
open class WLProfileBaseViewController: WLF1DisposeViewController {
    
    public var profileConfig: WLProfileConfig!
    
    public var profileStyle: WLProfileStyle = .one
    
    public var aboutConfig: WLAboutConfig!
    
    public var blackConfig: WLBlackListConfig!
    
    public var blackStyle: WLBlackListStyle = .one
    
    public var loginConfig: WLLoginConfig!
    
    public var loginStyle: WLLoginStyle = .one
    
    public var userInfoConfig: WLUserInfoConfig!
    
    public var focusConfig: WLFocusListConfig!
    
    public var focusStyle: WLFocusListStyle = .one
    
    public required init(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig) {
        super.init(nibName: nil, bundle: nil)
        
        self.profileStyle = profileStyle
        
        self.profileConfig = profileConfig
        
        self.userInfoConfig = userInfoConfig
        
        self.blackConfig = blackConfig
        
        self.blackStyle = blackStyle
        
        self.loginConfig = loginConfig
        
        self.loginStyle = loginStyle
        
        self.aboutConfig = aboutConfig
        
        WLProfileConfigManager.default.config = profileConfig
        
        self.focusStyle = focusStyle
        
        self.focusConfig = focusConfig
    }
    
    public required init(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig ,delegate: WLProfileViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.profileStyle = profileStyle
        
        self.profileConfig = profileConfig
        
        self.userInfoConfig = userInfoConfig
        
        self.blackConfig = blackConfig
        
        self.blackStyle = blackStyle
        
        self.loginConfig = loginConfig
        
        self.loginStyle = loginStyle
        
        self.aboutConfig = aboutConfig
        
        WLProfileConfigManager.default.config = profileConfig
        
        self.focusStyle = focusStyle
        
        self.focusConfig = focusConfig
        
        self.mDelegate = delegate
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public weak var mDelegate: WLProfileViewControllerDelegate!
    
    public final let tableView: WLProfileTableView = WLProfileTableView.baseTableView()
    
    public final let profileHeader: WLProfileHeaderView = WLProfileHeaderView(.white, style: .default, reuseIdentifier: "header")
    
    typealias Section = WLSectionModel<(), WLProfileType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: WLProfileViewModel!
    
    override open func addOwnSubViews() {
        
        view.addSubview(tableView)
    }
    
    override open func configOwnSubViews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(WL_TOP_LAYOUT_GUARD)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(WLProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        
        switch profileStyle {
        case .one: fallthrough
        case .two:
            
            profileHeader.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 3)
        case .three: fallthrough
        case .four:
            
            profileHeader.frame = CGRect(x: 0, y: 0, width: WL_SCREEN_WIDTH, height: WL_SCREEN_WIDTH / 2)
        }
        
        tableView.tableHeaderView = profileHeader
    }
    
    override open func configViewModel() {
        
        let input = WLProfileViewModel.WLInput(modelSelect: tableView.rx.modelSelected(WLProfileType.self),
                                               itemSelect: tableView.rx.itemSelected)
        
        viewModel = WLProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in
                
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! WLProfileTableViewCell
                
                cell.type = item
                
                return cell
        })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .userInfo
            .bind(to: profileHeader.rx.user)
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [weak self] (type,ip) in
                
                guard let `self` = self else { return }
                
                self.tableView.deselectRow(at: ip, animated: true)
                
                if let delegate = self.mDelegate {
                    
                    switch type {
                    case .setting:
                        
                        delegate.onSettingTap(self)
                        
                    case .pravicy:
                        
                        delegate.onPravicyTap(self)
                        
                    case .about:
                        
                        delegate.onAboutTap(self)
                    case .userInfo:
                        
                        let isLogin = self.checkLogin(self.loginStyle, config: self.loginConfig)
                        
                        if isLogin {
                            
                            delegate.onUserInfoTap(self)
                        }
                    case .contactUS:
                        
                        if !type.subTitle.isEmpty && WLDeviceInfo.wl_device_hasSIM()  {
                            
                            WLOpenUrl.openUrl(urlString: "telprompt://\(type.subTitle)")
                        } else {
                            
                            WLHudUtil.showInfo("请确认使用的是iPhone，且安装有手机卡")
                        }
                    case .focus:
                        
                        let isLogin = self.checkLogin(self.loginStyle, config: self.loginConfig)
                        
                        if isLogin {
                            
                            delegate.onFocusTap(self)
                        }
                    default:
                        break
                    }
                    return
                }
                
                switch type {
                case .setting:
                    
                    let setting = WLSettingViewController.createSetting(self.blackStyle, blackConfig: self.blackConfig, loginStyle: self.loginStyle, loginConfig: self.loginConfig)
                    
                    self.navigationController?.pushViewController(setting, animated: true)
                    
                case .pravicy:
                    
                    let pro = WLProtocolViewController.createProtocol()
                    
                    self.navigationController?.pushViewController(pro, animated: true)
                    
                case .about:
                    
                    let about = WLAboutViewController.createAbout(self.aboutConfig)
                    
                    self.navigationController?.pushViewController(about, animated: true)
                case .userInfo:
                    
                    let isLogin = self.checkLogin(self.loginStyle, config: self.loginConfig)
                    
                    if isLogin {
                        
                        let userinfo = WLUserInfoViewController.createUserInfo(self.userInfoConfig)
                        
                        self.navigationController?.pushViewController(userinfo, animated: true)
                    }
                case .contactUS:
                    
                    if !type.subTitle.isEmpty && WLDeviceInfo.wl_device_hasSIM()  {
                        
                        WLOpenUrl.openUrl(urlString: "telprompt://\(type.subTitle)")
                    } else {
                        
                        WLHudUtil.showInfo("请确认使用的是iPhone，切装有手机卡")
                    }
                    
                case .focus:
                    
                    let isLogin = self.checkLogin(self.loginStyle, config: self.loginConfig)
                    
                    if isLogin {
                        
                        let focus = WLFocusViewController.createFocusList(self.focusStyle, config: self.focusConfig)
                        
                        self.navigationController?.pushViewController(focus, animated: true)
                    }
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        let tapHeaderView = UITapGestureRecognizer(target: self, action: #selector(headerViewTaped))
        
        profileHeader.addGestureRecognizer(tapHeaderView)
    }
    @objc (headerViewTaped)
    func headerViewTaped() {
        
        let isLogin = checkLogin(loginStyle, config: loginConfig)
        
        if isLogin {
            
            if let delegate = self.mDelegate {
                
                delegate.onUserInfoTap(self)
                
                return
            }
            
            let userinfo = WLUserInfoViewController.createUserInfo(userInfoConfig)
            
            navigationController?.pushViewController(userinfo, animated: true)
        }
    }
    
    @objc (tokenInvalid)
    open func tokenInvalid() {
        
        if let tab = tabBarController {
            
            if let navi = tab.selectedViewController as? UINavigationController {
                
                navi.setViewControllers([navi.viewControllers.first!], animated: true)
            } else {
                
                if let navi = tab.viewControllers?.first as? UINavigationController{
                    
                    navi.setViewControllers([navi.viewControllers.first!], animated: true)
                }
            }
        } else {
            
            navigationController?.setViewControllers([self], animated: true)
        }
        
        tokenInvalidAlertShow(loginStyle, config: loginConfig)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
    }
    open override func configNaviItem() {
        
        title = "我的"
    }
}

extension WLProfileBaseViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
