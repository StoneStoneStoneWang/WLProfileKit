
Pod::Spec.new do |spec|
  
  spec.name         = "WLProfileKit"
  spec.version      = "1.0.9"
  spec.summary      = "A Lib For profile kit."
  spec.description  = <<-DESC
  WLProfileKit一个对用户模块的封装
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/WLProfileKit"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'CoreServices'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/WLProfileKit.git", :tag => "#{spec.version}" }
  
  ## Prepare
  spec.subspec 'Prepare' do |prepare|
    ## Bean
    prepare.subspec 'Bean' do |bean|
      bean.source_files = "Code/Prepare/Bean/*.{swift}"
      bean.dependency 'ObjectMapper'
    end
    ## Cache
    prepare.subspec 'Cache' do |cache|
      cache.source_files = "Code/Prepare/Cache/*.{swift}"
      cache.dependency 'WLProfileKit/Prepare/Bean'
      cache.dependency 'WLThirdUtil/Cache'
    end
    
    ## Config
    prepare.subspec 'config' do |config|
      config.source_files = "Code/Prepare/Config/*.{swift}"
    end
    ## Manager
    prepare.subspec 'Manager' do |manager|
      manager.source_files = "Code/Prepare/Manager/*.{swift}"
      manager.dependency 'WLThirdUtil/Hud'
      manager.dependency 'WLThirdUtil/UM/Base'
      manager.dependency 'WLProfileKit/Prepare/config'
    end
    ## Api
    prepare.subspec 'Api' do |api|
      api.source_files = "Code/Prepare/Api/*.{swift}"
      api.dependency 'WLProfileKit/Prepare/Manager'
      api.dependency 'Alamofire'
      api.dependency 'WLReqKit'
      api.dependency 'WLToolsKit/Common'
    end
    ## Req
    prepare.subspec 'Req' do |req|
      req.source_files = "Code/Prepare/Req/*.{swift}"
      req.dependency 'WLProfileKit/Prepare/Api'
      req.dependency 'WLProfileKit/Prepare/Cache'
      req.dependency 'RxSwift'
    end
    ## Upload
    prepare.subspec 'Upload' do |upload|
      
      upload.source_files = "Code/Prepare/Upload/*.{swift}"
      upload.dependency 'WLProfileKit/Prepare/Cache'
      upload.dependency 'Alamofire'
      upload.dependency 'RxSwift'
      upload.dependency 'WLReqKit'
      upload.dependency 'ObjectMapper'
      upload.dependency 'WLThirdUtil/Ali/ObjCache'
    end
    
    ## Base
    prepare.subspec 'Base' do |base|
      base.source_files = "Code/Prepare/Base/*.{swift}"
      base.dependency 'WLToolsKit/Color'
      base.dependency 'WLBaseViewController/Loading'
      base.dependency 'WLBaseViewController/Inner'
      base.dependency 'RxSwift'
    end
    
    prepare.subspec 'Result' do |result|
      result.source_files = "Code/Prepare/Result/*.{swift}"
      result.dependency 'ObjectMapper'
    end
    
    prepare.subspec 'TextCheck' do |textCheck|
      textCheck.source_files = "Code/Prepare/TextCheck/*.{swift}"
      textCheck.dependency 'WLProfileKit/Prepare/Result'
      textCheck.dependency 'WLToolsKit/String'
    end
    ## Prepare/Base
    prepare.subspec 'ActionShow' do |ac|
      ac.source_files = "Code/Prepare/ActionShow/*.{swift}"
    end
    ## Prepare/Base
    prepare.subspec 'PickerImpl' do |pi|
      pi.source_files = "Code/Prepare/PickerImpl/*.{swift}"
      pi.dependency 'WLToolsKit/Then'
    end
  end
  
  ## RXCocoa
  spec.subspec 'RXCocoa' do |cocoa|
    cocoa.subspec 'Button' do |btn|
      btn.source_files = "Code/RXCocoa/Button/*.{swift}"
      btn.dependency 'RxSwift'
      btn.dependency 'RxCocoa'
    end
    cocoa.subspec 'TextField' do |tf|
      tf.source_files = "Code/RXCocoa/TextField/*.{swift}"
      tf.dependency 'RxSwift'
      tf.dependency 'RxCocoa'
    end
  end
  
  # Welcome
  spec.subspec 'Welcome' do |welcome|
    ## 'Style'
    welcome.subspec 'Style' do |style|
      style.source_files = "Code/Project/Welcome/Style/*.{swift}"
    end
    ## 'Delegate'
    welcome.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/Project/Welcome/Delegate/*.{swift}"
      delegate.dependency 'WLBaseViewModel'
    end
    ## 'Config'
    welcome.subspec 'Config' do |config|
      config.source_files = "Code/Project/Welcome/Config/*.{swift}"
    end
    ## 'VM'
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Welcome/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLProfileKit/Welcome/Style'
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
    end
    ## 'View'
    welcome.subspec 'View' do |view|
      view.source_files = "Code/Project/Welcome/View/*.{swift}"
      view.dependency 'SnapKit'
      view.dependency 'WLToolsKit/Then'
    end
    ## 'Base'
    welcome.subspec 'Base' do |base|
      base.source_files = "Code/Project/Welcome/Base/*.{swift}"
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLProfileKit/Welcome/VM'
      base.dependency 'WLProfileKit/Welcome/View'
      base.dependency 'WLProfileKit/Welcome/Config'
      base.dependency 'WLProfileKit/Welcome/Delegate'
      base.dependency 'WLToolsKit/Color'
      base.dependency 'WLBaseTableView/SM'
      base.dependency 'WLProfileKit/RXCocoa/Button'
      base.dependency 'RxDataSources'
    end
    
    ## 'VC'
    welcome.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Welcome/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Welcome/Base'
    end
    
    ## Create
    welcome.subspec 'Create' do |create|
      create.source_files = "Code/Project/Welcome/Create/*.{swift}"
      create.dependency 'WLProfileKit/Welcome/VC'
    end
  end
  
  ## Protocol
  spec.subspec 'Protocol' do |protocol|
    ## VM
    protocol.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Protocol/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Prepare/Manager'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
    end
    ## VC
    protocol.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Protocol/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Prepare/Base'
      vc.dependency 'WLProfileKit/Protocol/VM'
    end
    ## Create
    protocol.subspec 'Create' do |create|
      create.source_files = "Code/Project/Protocol/Create/*.{swift}"
      create.dependency 'WLProfileKit/Protocol/VC'
    end
  end
  
  ## Pwd
  spec.subspec 'Password' do |password|
    ## VM
    password.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Pwd/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Prepare/TextCheck'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    ## Base
    password.subspec 'Base' do |base|
      base.source_files = "Code/Project/Pwd/Base/*.{swift}"
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLProfileKit/Password/VM'
      base.dependency 'WLProfileKit/Login/Config'
      base.dependency 'WLProfileKit/Login/Style'
      base.dependency 'WLProfileKit/RXCocoa/Button'
      base.dependency 'WLProfileKit/RXCocoa/TextField'
      base.dependency 'WLToolsKit/Color'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLComponentView/TextFeild/Vcode'
      base.dependency 'WLComponentView/TextFeild/Password'
      base.dependency 'WLThirdUtil/Hud'
    end
    ## VC
    password.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Pwd/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Password/Base'
      vc.dependency 'WLComponentView/Draw'
      vc.dependency 'SnapKit'
    end
    ## Create
    password.subspec 'Create' do |create|
      create.source_files = "Code/Project/Pwd/Create/*.{swift}"
      create.dependency 'WLProfileKit/Password/VC'
    end
  end
  
  ## Reg
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Reg/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Prepare/TextCheck'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    reg.subspec 'Base' do |base|
      base.source_files = "Code/Project/Reg/Base/*.{swift}"
      #      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLProfileKit/Reg/VM'
      base.dependency 'WLProfileKit/Login/Config'
      base.dependency 'WLProfileKit/Login/Style'
      base.dependency 'WLProfileKit/RXCocoa/Button'
      base.dependency 'WLToolsKit/Color'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLComponentView/TextFeild/Vcode'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLThirdUtil/JPush'
      base.dependency 'WLProfileKit/Protocol/Create'
      base.dependency 'WLProfileKit/Prepare/Cache'
    end
    
    reg.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Reg/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Reg/Base'
      vc.dependency 'SnapKit'
      vc.dependency 'WLComponentView/Draw'
    end
    
    reg.subspec 'Create' do |create|
      create.source_files = "Code/Project/Reg/Create/*.{swift}"
      create.dependency 'WLProfileKit/Reg/VC'
    end
  end
  
  ## Reg
  spec.subspec 'Login' do |login|
    
    login.subspec 'Style' do |style|
      style.source_files = "Code/Project/Login/Style/*.{swift}"
    end
    
    login.subspec 'Config' do |config|
      config.source_files = "Code/Project/Login/Config/*.{swift}"
    end
    
    login.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Login/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Prepare/TextCheck'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    login.subspec 'Base' do |base|
      base.source_files = "Code/Project/Login/Base/*.{swift}"
      base.dependency 'WLProfileKit/Login/VM'
      base.dependency 'WLProfileKit/Reg/Create'
      base.dependency 'WLProfileKit/Password/Create'
    end
    
    login.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Login/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Login/Base'
      vc.dependency 'WLComponentView/Draw'
    end
    
    login.subspec 'Create' do |create|
      create.source_files = "Code/Project/Login/Create/*.{swift}"
      create.dependency 'WLProfileKit/Login/VC'
    end
    
    # TokenInvalid
    login.subspec 'TokenInvalid' do |ti|
      ti.source_files = "Code/Project/Login/TokenInvalid/*.{swift}"
      ti.dependency 'WLProfileKit/Login/Create'
    end
    
    ## CheckLogin
    login.subspec 'CheckLogin' do |check|
      check.source_files = "Code/Project/Login/CheckLogin/*.{swift}"
      check.dependency 'WLProfileKit/Login/Create'
    end
  end
  
  # Black
  spec.subspec 'Black' do |black|
    
    black.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/Black/Bean/*.{swift}"
      bean.dependency 'WLProfileKit/Prepare/Bean'
      bean.dependency 'ObjectMapper'
      bean.dependency 'RxDataSources'
    end
    black.subspec 'Style' do |style|
      style.source_files = "Code/Project/Black/Style/*.{swift}"
    end
    black.subspec 'Config' do |config|
      config.source_files = "Code/Project/Black/Config/*.{swift}"
    end
    
    black.subspec 'View' do |view|
      
      view.subspec 'Empty' do |empty|
        empty.source_files = "Code/Project/Black/View/Empty/*.{swift}"
        empty.dependency 'WLBaseTableView/Empty'
        empty.dependency 'WLToolsKit/Color'
      end
      
      view.subspec 'TV' do |tv|
        tv.source_files = "Code/Project/Black/View/TV/*.{swift}"
        tv.dependency 'WLBaseTableView/RTV'
      end
      
      view.subspec 'Cell' do |cell|
        cell.source_files = "Code/Project/Black/View/Cell/*.{swift}"
        cell.dependency 'WLBaseTableView/BTVC'
        cell.dependency 'WLToolsKit/Color'
        cell.dependency 'WLToolsKit/Then'
        cell.dependency 'WLToolsKit/Common'
        cell.dependency 'Kingfisher'
        cell.dependency 'SnapKit'
        cell.dependency 'WLProfileKit/Black/Config'
        cell.dependency 'WLProfileKit/Black/Bean'
      end
    end
    
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Black/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLReqKit'
      vm.dependency 'ObjectMapper'
      vm.dependency 'WLProfileKit/Black/Bean'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLProfileKit/Prepare/Req'
    end
    
    black.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Black/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Prepare/Base'
      vc.dependency 'WLProfileKit/Black/VM'
      vc.dependency 'WLProfileKit/Black/View'
      vc.dependency 'WLProfileKit/Black/Style'
      vc.dependency 'WLProfileKit/Black/Config'
      vc.dependency 'WLToolsKit/Then'
      vc.dependency 'WLToolsKit/Common'
      vc.dependency 'WLBaseTableView/ASM'
      vc.dependency 'WLThirdUtil/Hud'
      vc.dependency 'RxDataSources'
    end
    black.subspec 'Create' do |create|
      create.source_files = "Code/Project/Black/Create/*.{swift}"
      create.dependency 'WLProfileKit/Black/VC'
    end
  end
  
  # Focus
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/Focus/Bean/*.{swift}"
      bean.dependency 'WLProfileKit/Prepare/Bean'
      bean.dependency 'ObjectMapper'
      bean.dependency 'RxDataSources'
    end
    focus.subspec 'Style' do |style|
      style.source_files = "Code/Project/Focus/Style/*.{swift}"
    end
    focus.subspec 'Config' do |config|
      config.source_files = "Code/Project/Focus/Config/*.{swift}"
    end
    
    focus.subspec 'View' do |view|
      
      view.subspec 'Empty' do |empty|
        empty.source_files = "Code/Project/Focus/View/Empty/*.{swift}"
        empty.dependency 'WLBaseTableView/Empty'
        empty.dependency 'WLToolsKit/Color'
      end
      
      view.subspec 'TV' do |tv|
        tv.source_files = "Code/Project/Focus/View/TV/*.{swift}"
        tv.dependency 'WLBaseTableView/RTV'
      end
      
      view.subspec 'Cell' do |cell|
        cell.source_files = "Code/Project/Focus/View/Cell/*.{swift}"
        cell.dependency 'WLBaseTableView/BTVC'
        cell.dependency 'WLToolsKit/Color'
        cell.dependency 'WLToolsKit/Then'
        cell.dependency 'WLToolsKit/Common'
        cell.dependency 'Kingfisher'
        cell.dependency 'SnapKit'
        cell.dependency 'WLProfileKit/Focus/Config'
        cell.dependency 'WLProfileKit/Focus/Bean'
      end
    end
    
    focus.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Focus/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLReqKit'
      vm.dependency 'ObjectMapper'
      vm.dependency 'WLProfileKit/Focus/Bean'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLProfileKit/Prepare/Req'
    end
    
    focus.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Focus/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Prepare/Base'
      vc.dependency 'WLProfileKit/Focus/VM'
      vc.dependency 'WLProfileKit/Focus/View'
      vc.dependency 'WLProfileKit/Focus/Style'
      vc.dependency 'WLProfileKit/Focus/Config'
      vc.dependency 'WLToolsKit/Then'
      vc.dependency 'WLToolsKit/Common'
      vc.dependency 'WLBaseTableView/ASM'
      vc.dependency 'WLThirdUtil/Hud'
      vc.dependency 'RxDataSources'
    end
    focus.subspec 'Create' do |create|
      create.source_files = "Code/Project/Focus/Create/*.{swift}"
      create.dependency 'WLProfileKit/Focus/VC'
    end
    
  end
  
  
  # Setting
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/Setting/Bean/*.{swift}"
      bean.dependency 'WLProfileKit/Prepare/Cache'
    end
    
    setting.subspec 'View' do |view|
      view.source_files = "Code/Project/Setting/View/*.{swift}"
      view.dependency 'WLProfileKit/Setting/Bean'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'SnapKit'
    end
    setting.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Setting/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Setting/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    setting.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Setting/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Setting/VM'
      vc.dependency 'WLProfileKit/Setting/View'
      vc.dependency 'WLBaseTableView/SM'
      vc.dependency 'WLProfileKit/Black/Create'
      vc.dependency 'WLProfileKit/Login/CheckLogin'
    end
    
    setting.subspec 'Create' do |create|
      create.source_files = "Code/Project/Setting/Create/*.{swift}"
      create.dependency 'WLProfileKit/Setting/VC'
    end
  end
  
  # UserInfo
  spec.subspec 'UserInfo' do |info|
    
    info.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/UserInfo/Bean/*.{swift}"
    end
    
    info.subspec 'Config' do |config|
      config.source_files = "Code/Project/UserInfo/Config/*.{swift}"
    end
    
    info.subspec 'View' do |view|
      
      view.source_files = "Code/Project/UserInfo/View/*.{swift}"
      view.dependency 'WLProfileKit/UserInfo/Bean'
      view.dependency 'WLProfileKit/UserInfo/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/String'
      view.dependency 'Kingfisher'
      view.dependency 'SnapKit'
    end
    
    #
    info.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/UserInfo/VM/*.{swift}"
      vm.dependency 'WLProfileKit/UserInfo/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLProfileKit/Prepare/Cache'
      vm.dependency 'WLProfileKit/Prepare/Upload'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    #
    info.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/UserInfo/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Signature'
      vc.dependency 'WLProfileKit/NickName'
      vc.dependency 'WLProfileKit/UserInfo/VM'
      vc.dependency 'WLProfileKit/UserInfo/Config'
      vc.dependency 'WLProfileKit/UserInfo/View'
      vc.dependency 'WLToolsKit/Then'
      vc.dependency 'WLToolsKit/Common'
      vc.dependency 'WLBaseTableView/SM'
      vc.dependency 'WLThirdUtil/Hud'
      vc.dependency 'WLProfileKit/Prepare/ActionShow'
      vc.dependency 'RxDataSources'
      vc.dependency 'WLComponentView/Picker/DatePicker'
      vc.dependency 'WLProfileKit/Prepare/PickerImpl'
    end
    info.subspec 'Create' do |create|
      create.source_files = "Code/Project/UserInfo/Create/*.{swift}"
      create.dependency 'WLProfileKit/UserInfo/VC'
    end
  end
  
  # Signature
  spec.subspec 'Signature' do |sign|
    
    sign.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Signature/VM/*.{swift}"
      vm.dependency 'WLToolsKit/String'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLProfileKit/Prepare/Cache'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/UserInfo/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
      
    end
    sign.subspec 'Base' do |base|
      base.source_files = "Code/Project/Signature/Base/*.{swift}"
      base.dependency 'WLProfileKit/Signature/VM'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLProfileKit/UserInfo/Config'
      base.dependency 'WLToolsKit/Then'
    end
    
    sign.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Signature/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Signature/Base'
      vc.dependency 'WLToolsKit/Color'
      vc.dependency 'WLToolsKit/Common'
    end
    sign.subspec 'Create' do |create|
      create.source_files = "Code/Project/Signature/Create/*.{swift}"
      create.dependency 'WLProfileKit/Signature/VC'
      create.dependency 'WLBaseViewController/Navi'
    end
  end
  
  # NickName
  spec.subspec 'NickName' do |name|
    
    name.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/NickName/VM/*.{swift}"
      vm.dependency 'WLToolsKit/String'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
      vm.dependency 'WLProfileKit/Prepare/Cache'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/UserInfo/Bean'
    end
    name.subspec 'Base' do |base|
      base.source_files = "Code/Project/NickName/Base/*.{swift}"
      base.dependency 'WLProfileKit/NickName/VM'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'WLProfileKit/UserInfo/Bean'
      base.dependency 'WLProfileKit/UserInfo/Config'
      base.dependency 'WLToolsKit/Then'
      base.dependency 'WLProfileKit/Prepare/Cache'
      base.dependency 'WLComponentView/TextFeild/NickName'
    end
    
    name.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/NickName/VC/*.{swift}"
      vc.dependency 'WLProfileKit/NickName/Base'
      vc.dependency 'WLToolsKit/Color'
      vc.dependency 'WLToolsKit/Common'
    end
    name.subspec 'Create' do |create|
      create.source_files = "Code/Project/NickName/Create/*.{swift}"
      create.dependency 'WLProfileKit/NickName/VC'
      create.dependency 'WLBaseViewController/Navi'
    end
  end
  
  # About
  spec.subspec 'About' do |about|
    
    about.subspec 'Config' do |config|
      config.source_files = "Code/Project/About/Config/*.{swift}"
    end
    
    about.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/About/Bean/*.{swift}"
      bean.dependency 'WLToolsKit/String'
    end
    
    about.subspec 'View' do |view|
      view.source_files = "Code/Project/About/View/*.{swift}"
      view.dependency 'WLProfileKit/About/Bean'
      view.dependency 'WLProfileKit/About/Config'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/SM'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'SnapKit'
      
    end
    
    about.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/About/VM/*.{swift}"
      vm.dependency 'WLProfileKit/About/Bean'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
    end
    
    about.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/About/VC/*.{swift}"
      vc.dependency 'WLProfileKit/About/VM'
      vc.dependency 'WLProfileKit/About/View'
      vc.dependency 'WLProfileKit/About/Config'
      vc.dependency 'WLProfileKit/Prepare/Base'
      vc.dependency 'RxDataSources'
      vc.dependency 'WLToolsKit/Common'
    end
    about.subspec 'Create' do |create|
      create.source_files = "Code/Project/About/Create/*.{swift}"
      create.dependency 'WLProfileKit/About/VC'
    end
  end
  
  # Profile
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'Config' do |config|
      config.source_files = "Code/Project/Profile/Config/*.{swift}"
    end
    profile.subspec 'Style' do |style|
      style.source_files = "Code/Project/Profile/Style/*.{swift}"
    end
    profile.subspec 'Manager' do |manager|
      manager.source_files = "Code/Project/Profile/Manager/*.{swift}"
      manager.dependency 'WLProfileKit/Profile/Config'
      manager.dependency 'WLProfileKit/Profile/Style'
    end
    
    profile.subspec 'Bean' do |bean|
      bean.source_files = "Code/Project/Profile/Bean/*.{swift}"
      bean.dependency 'WLProfileKit/Profile/Manager'
    end
    
    profile.subspec 'View' do |view|
      view.source_files = "Code/Project/Profile/View/*.{swift}"
      view.dependency 'WLProfileKit/Profile/Bean'
      view.dependency 'WLProfileKit/Profile/Manager'
      view.dependency 'WLProfileKit/Prepare/Cache'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
      view.dependency 'RxCocoa'
      view.dependency 'WLProfileKit/Profile/Bean'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
    end
    
    profile.subspec 'VM' do |vm|
      vm.source_files = "Code/Project/Profile/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Profile/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
    end
    
    profile.subspec 'Base' do |base|
      base.source_files = "Code/Project/Profile/Base/*.{swift}"
      base.dependency 'WLProfileKit/Profile/View'
      base.dependency 'WLProfileKit/Profile/Manager'
      base.dependency 'WLProfileKit/Profile/VM'
      base.dependency 'WLProfileKit/UserInfo/Create'
      base.dependency 'WLProfileKit/Login/TokenInvalid'
      base.dependency 'WLProfileKit/Login/CheckLogin'
      base.dependency 'WLProfileKit/About/Create'
      base.dependency 'WLProfileKit/Setting/Create'
      base.dependency 'WLProfileKit/Focus/Create'
      base.dependency 'WLToolsKit/OpenUrl'
      base.dependency 'WLToolsKit/DeviceInfo'
      base.dependency 'RxDataSources'
      base.dependency 'WLThirdUtil/Hud'
    end
    profile.subspec 'VC' do |vc|
      vc.source_files = "Code/Project/Profile/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Profile/Base'
    end
    
    profile.subspec 'Create' do |create|
      create.source_files = "Code/Project/Profile/Create/*.{swift}"
      create.dependency 'WLProfileKit/Profile/VC'
    end
    
  end
  
  
  # Publish
  spec.subspec 'Publish' do |pub|
    
    pub.subspec 'Prepare' do |prepare|
      
      prepare.subspec 'Delegate' do |delegate|
        delegate.source_files = "Code/Publish/Prepare/Delegate/*.{swift}"
        delegate.dependency 'WLProfileKit/Publish/Prepare/Bean'
      end
      
      prepare.subspec 'Bean' do |bean|
        bean.source_files = "Code/Publish/Prepare/Bean/*.{swift}"
        bean.dependency 'ObjectMapper'
        bean.dependency 'RxDataSources'
        bean.dependency 'WLProfileKit/Prepare/Bean'
        bean.dependency 'WLToolsKit/JsonCast'
      end
      
      prepare.subspec 'Convert' do |convert|
        convert.source_files = "Code/Publish/Prepare/VideoConvert/*.{swift}"
      end
      
      prepare.subspec 'Config' do |config|
        config.source_files = "Code/Publish/Prepare/Config/*.{swift}"
      end
      
      prepare.subspec 'Style' do |style|
        style.source_files = "Code/Publish/Prepare/Style/*.{swift}"
      end
      
      prepare.subspec 'TextEdit' do |te|
        te.subspec 'Base' do |base|
          base.source_files = "Code/Publish/Prepare/TextEdit/Base/*.{swift}"
          base.dependency 'WLProfileKit/Prepare/Base'
          base.dependency 'WLBaseViewController/Navi'
          base.dependency 'WLProfileKit/Publish/Prepare/Config'
          base.dependency 'WLToolsKit/Color'
          base.dependency 'WLToolsKit/Then'
          base.dependency 'RxCocoa'
          base.dependency 'RxSwift'
        end
        te.subspec 'VC' do |vc|
          vc.source_files = "Code/Publish/Prepare/TextEdit/VC/*.{swift}"
          vc.dependency 'WLProfileKit/Publish/Prepare/TextEdit/Base'
          vc.dependency 'WLToolsKit/Common'
        end
        te.subspec 'Create' do |create|
          create.source_files = "Code/Publish/Prepare/TextEdit/Create/*.{swift}"
          create.dependency 'WLProfileKit/Publish/Prepare/TextEdit/VC'
          create.dependency 'WLBaseViewController/Navi'
        end
      end
    end
    pub.subspec 'VM' do |vm|
      vm.source_files = "Code/Publish/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLReqKit'
      vm.dependency 'WLToolsKit/String'
      vm.dependency 'WLToolsKit/JsonCast'
      vm.dependency 'WLProfileKit/Publish/Prepare/Bean'
      vm.dependency 'WLProfileKit/Publish/Prepare/Style'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLProfileKit/Prepare/Req'
    end
    
    pub.subspec 'Table' do |table|
      
      table.subspec 'View' do |view|
        view.source_files = "Code/Publish/Table/View/*.{swift}"
        view.dependency 'SnapKit'
        view.dependency 'RxCocoa'
        view.dependency 'WLComponentView/TextFeild/NickName'
        view.dependency 'WLBaseTableView/BTV'
        view.dependency 'WLBaseTableView/BTVC'
        view.dependency 'WLToolsKit/Color'
        view.dependency 'WLToolsKit/Then'
        view.dependency 'SnapKit'
      end
      table.subspec 'Base' do |base|
        base.source_files = "Code/Publish/Table/Base/*.{swift}"
        base.dependency 'WLBaseViewController/Navi'
        base.dependency 'WLProfileKit/Publish/Table/View'
        base.dependency 'WLProfileKit/Publish/VM'
        base.dependency 'WLProfileKit/Publish/Prepare/Delegate'
        base.dependency 'WLProfileKit/Publish/Prepare/Convert'
        base.dependency 'WLProfileKit/Publish/Prepare/Style'
        base.dependency 'WLProfileKit/Publish/Prepare/TextEdit/Create'
        base.dependency 'WLProfileKit/Prepare/PickerImpl'
        base.dependency 'WLProfileKit/Prepare/ActionShow'
        base.dependency 'WLBaseTableView/ASM'
        base.dependency 'WLThirdUtil/Hud'
        base.dependency 'RxDataSources'
        base.dependency 'WLProfileKit/UserInfo/VM'
      end
      #
      table.subspec 'VC' do |vc|
        vc.source_files = "Code/Publish/Table/VC/*.{swift}"
        vc.dependency 'WLProfileKit/Publish/Table/Base'
        vc.dependency 'WLToolsKit/Common'
      end
      table.subspec 'Create' do |create|
        create.source_files = "Code/Publish/Table/Create/*.{swift}"
        create.dependency 'WLProfileKit/Publish/Table/VC'
        create.dependency 'WLBaseViewController/Navi'
      end
    end
  end
  
  # UserInfo
  spec.subspec 'Report' do |report|
    
    report.subspec 'Bean' do |bean|
      bean.source_files = "Code/Report/Bean/*.{swift}"
      bean.dependency 'RxDataSources'
      bean.dependency 'ObjectMapper'
    end
    
    report.subspec 'Config' do |config|
      config.source_files = "Code/Report/Config/*.{swift}"
    end
    
    report.subspec 'Style' do |style|
      style.source_files = "Code/Report/Style/*.{swift}"
    end
    
    report.subspec 'View' do |view|
      view.source_files = "Code/Report/View/*.{swift}"
      view.dependency 'WLProfileKit/Report/Bean'
      view.dependency 'WLProfileKit/Report/Config'
      view.dependency 'WLProfileKit/Report/Style'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/BTV'
      view.dependency 'WLBaseTableView/Empty'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'SnapKit'
    end
    
    #
    report.subspec 'VM' do |vm|
      vm.source_files = "Code/Report/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Report/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    #
    report.subspec 'Base' do |base|
      base.source_files = "Code/Report/Base/*.{swift}"
      base.dependency 'WLProfileKit/Report/Bean'
      base.dependency 'WLProfileKit/Report/Style'
      base.dependency 'WLProfileKit/Report/VM'
      base.dependency 'WLProfileKit/Report/Config'
      base.dependency 'WLProfileKit/Report/View'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'SnapKit'
    end
    
    report.subspec 'VC' do |vc|
      vc.source_files = "Code/Report/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Report/Base'
      vc.dependency 'WLToolsKit/Color'
    end
    
    report.subspec 'Create' do |create|
      create.source_files = "Code/Report/Create/*.{swift}"
      create.dependency 'WLProfileKit/Report/VC'
    end
    
  end
  
  # UserInfo
  spec.subspec 'Circle' do |circle|
    
    circle.subspec 'Config' do |config|
      config.source_files = "Code/Circle/Config/*.{swift}"
    end
    
    circle.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/Circle/Delegate/*.{swift}"
    end
    
    circle.subspec 'Style' do |style|
      style.source_files = "Code/Circle/Style/*.{swift}"
    end
    
    circle.subspec 'View' do |view|
      view.source_files = "Code/Circle/View/*.{swift}"
      view.dependency 'WLProfileKit/Publish/Prepare/Bean'
      view.dependency 'WLProfileKit/Circle/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    
    #
    circle.subspec 'VM' do |vm|
      vm.source_files = "Code/Circle/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Publish/Prepare/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    #
    circle.subspec 'Base' do |base|
      base.source_files = "Code/Circle/Base/*.{swift}"
      base.dependency 'WLProfileKit/Publish/Prepare/Bean'
      base.dependency 'WLProfileKit/Circle/Style'
      base.dependency 'WLProfileKit/Circle/VM'
      base.dependency 'WLProfileKit/Circle/Config'
      base.dependency 'WLProfileKit/Circle/Delegate'
      base.dependency 'WLProfileKit/Circle/View'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLProfileKit/Login/CheckLogin'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'SnapKit'
    end
    
    circle.subspec 'VC' do |vc|
      vc.source_files = "Code/Circle/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Circle/Base'
      vc.dependency 'WLToolsKit/Color'
    end
    
    circle.subspec 'Create' do |create|
      create.source_files = "Code/Circle/Create/*.{swift}"
      create.dependency 'WLProfileKit/Circle/VC'
    end
  end
  # Comment
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'Bean' do |bean|
      bean.source_files = "Code/Comment/Bean/*.{swift}"
      bean.dependency 'ObjectMapper'
      bean.dependency 'RxDataSources'
      bean.dependency 'WLProfileKit/Prepare/Bean'
    end
    comment.subspec 'Config' do |config|
      config.source_files = "Code/Comment/Config/*.{swift}"
    end
    
    comment.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/Comment/Delegate/*.{swift}"
    end
    
    comment.subspec 'Style' do |style|
      style.source_files = "Code/Comment/Style/*.{swift}"
    end
    
    comment.subspec 'View' do |view|
      view.source_files = "Code/Comment/View/*.{swift}"
      view.dependency 'WLProfileKit/Publish/Prepare/Bean'
      view.dependency 'WLProfileKit/Comment/Config'
      view.dependency 'WLProfileKit/Comment/Bean'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    
    #
    comment.subspec 'VM' do |vm|
      vm.source_files = "Code/Comment/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Comment/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    #
    comment.subspec 'Base' do |base|
      base.source_files = "Code/Comment/Base/*.{swift}"
      base.dependency 'WLProfileKit/Publish/Prepare/Bean'
      base.dependency 'WLProfileKit/Comment/Bean'
      base.dependency 'WLProfileKit/Comment/Style'
      base.dependency 'WLProfileKit/Comment/VM'
      base.dependency 'WLProfileKit/Comment/Config'
      base.dependency 'WLProfileKit/Comment/Delegate'
      base.dependency 'WLProfileKit/Comment/View'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLProfileKit/Login/CheckLogin'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLToolsKit/String'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'SnapKit'
    end
    
    comment.subspec 'VC' do |vc|
      vc.source_files = "Code/Comment/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Comment/Base'
      vc.dependency 'WLToolsKit/Color'
    end
    
    comment.subspec 'Create' do |create|
      create.source_files = "Code/Comment/Create/*.{swift}"
      create.dependency 'WLProfileKit/Comment/VC'
    end
  end
  
  # Comment
  spec.subspec 'Content' do |content|
    
    content.subspec 'Config' do |config|
      config.source_files = "Code/Content/Config/*.{swift}"
    end
    
    content.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/Content/Delegate/*.{swift}"
    end
    
    content.subspec 'Style' do |style|
      style.source_files = "Code/Content/Style/*.{swift}"
    end
    
    content.subspec 'View' do |view|
      view.source_files = "Code/Content/View/*.{swift}"
      view.dependency 'WLProfileKit/Publish/Prepare/Bean'
      view.dependency 'WLProfileKit/Circle/Config'
      view.dependency 'WLBaseTableView/BTVC'
      view.dependency 'WLBaseTableView/RTV'
      view.dependency 'WLToolsKit/Then'
      view.dependency 'WLToolsKit/Color'
      view.dependency 'WLToolsKit/Common'
      view.dependency 'WLToolsKit/Image'
      view.dependency 'SnapKit'
      view.dependency 'Kingfisher'
    end
    
    #
    content.subspec 'VM' do |vm|
      vm.source_files = "Code/Content/VM/*.{swift}"
      vm.dependency 'WLProfileKit/Publish/Prepare/Bean'
      vm.dependency 'WLProfileKit/Prepare/Req'
      vm.dependency 'WLProfileKit/Prepare/Result'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLReqKit'
    end
    
    #
    content.subspec 'Base' do |base|
      base.source_files = "Code/Content/Base/*.{swift}"
      base.dependency 'WLProfileKit/Publish/Prepare/Bean'
      base.dependency 'WLProfileKit/Content/Style'
      base.dependency 'WLProfileKit/Content/VM'
      base.dependency 'WLProfileKit/Content/Config'
      base.dependency 'WLProfileKit/Content/Delegate'
      base.dependency 'WLProfileKit/Content/View'
      base.dependency 'WLProfileKit/Prepare/Base'
      base.dependency 'WLToolsKit/Common'
      base.dependency 'WLToolsKit/String'
      base.dependency 'WLBaseTableView/ASM'
      base.dependency 'WLThirdUtil/Hud'
      base.dependency 'SnapKit'
    end
    
    content.subspec 'VC' do |vc|
      vc.source_files = "Code/Content/VC/*.{swift}"
      vc.dependency 'WLProfileKit/Content/Base'
    end
    
    content.subspec 'Create' do |create|
      create.source_files = "Code/Content/Create/*.{swift}"
      create.dependency 'WLProfileKit/Content/VC'
    end
  end
  
  # Comment
  spec.subspec 'CircleDetail' do |detail|
    
    detail.subspec 'Delegate' do |delegate|
      delegate.source_files = "Code/CircleDetail/Delegate/*.{swift}"
    end
    
    detail.subspec 'Style' do |style|
      style.source_files = "Code/CircleDetail/Style/*.{swift}"
    end
    
    #
    detail.subspec 'VM' do |vm|
      vm.source_files = "Code/CircleDetail/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxSwift'
      vm.dependency 'RxCocoa'
    end
    
    #
    detail.subspec 'Base' do |base|
      base.source_files = "Code/CircleDetail/Base/*.{swift}"
      base.dependency 'WLProfileKit/Publish/Prepare/Bean'
      base.dependency 'WLProfileKit/Content/Create'
      base.dependency 'WLProfileKit/Comment/Create'
      base.dependency 'WLProfileKit/Report/Create'
      base.dependency 'WLProfileKit/CircleDetail/Style'
      base.dependency 'WLProfileKit/CircleDetail/Delegate'
      base.dependency 'WLProfileKit/CircleDetail/VM'
      base.dependency 'WLProfileKit/Login/CheckLogin'
      base.dependency 'WLProfileKit/Circle/VM'
    end
    
    detail.subspec 'VC' do |vc|
      vc.source_files = "Code/CircleDetail/VC/*.{swift}"
      vc.dependency 'WLProfileKit/CircleDetail/Base'
    end
    
    detail.subspec 'Create' do |create|
      create.source_files = "Code/CircleDetail/Create/*.{swift}"
      create.dependency 'WLProfileKit/CircleDetail/VC'
    end
  end
  
end


