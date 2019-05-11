# WLProfileKit 子分之管理 
A lib for profile

1.登陆依赖的是注册、修改密码、协议 
2.注册以来的是找回密码、协议 
3.内部请求是处理了缓存用户信息以及token功能
4.App的逻辑是 进入App显示的是首页 未登录d状态、不强制登陆、
5.需要用户x信息的地方个人中心 是有一个对userbean的监听的
6.如果是oc的话 需要重写一个***协议。Equalable
7.新建一个userbean 每次给单利的userbean赋值 

8.basevc 去处理所有的事件 、并声明事件所需要的view、子类vc去具体布局 
打个比方说 登陆界面 手机号或者s账号的文本框、密码的文本框d、登陆按钮、跳转注册、跳转忘记密码

基础是Swift 

<!--## 所有的请求 接口配置-->
<!--pod  'WLProfileKit/Prepare/Api'-->
<!---->
<!--## 请求-->
<!--pod  'WLProfileKit/Prepare/Req'-->
<!--## 上传-->
<!--pod 'WLProfileKit/Prepare/Upload'-->
<!--## picker的实现-->
<!--pod 'WLProfileKit/Prepare/PickerImpl'-->
<!--## 检测弹出登陆-->
<!--pod 'WLProfileKit/Login/CheckLogin'-->
<!--## token 无效-->
<!--pod 'WLProfileKit/Login/TokenInvalid'-->
<!--## 登陆模块-->
<!--pod 'WLProfileKit/Login/Create'-->
<!--## 个人中心-->
<!--pod 'WLProfileKit/Profile/Create'-->
<!--## 设置-->
<!--pod 'WLProfileKit/Setting/Create'-->
<!--## 协议-->
<!--pod 'WLProfileKit/Protocol/Create'-->
<!--## 注册-->
<!--pod 'WLProfileKit/Reg/Create'-->
<!--## 密码-->
<!--pod 'WLProfileKit/Pwd/Create'-->
<!--## 个人资料-->
<!--pod 'WLProfileKit/WLUserInfo/Create'-->
<!--## 签名-->
<!--pod 'WLProfileKit/Signature/Create'-->
<!--## 昵称-->
<!--pod 'WLProfileKit/NickName/Create'-->
<!--## 黑名单-->
<!--pod 'WLProfileKit/Black/Create'-->
<!--## 关注-->
<!--pod 'WLProfileKit/Focus/Create'-->
<!--## 关于我们-->
<!--pod 'WLProfileKit/About/Create'-->
<!--## 举报-->
<!--pod 'WLProfileKit/Report/Create'-->
<!--## 圈子列表-->
<!--pod 'WLProfileKit/Circle/Create'-->
<!---->
<!--## 详情-->
<!--pod 'WLProfileKit/Detail/Create'-->
<!--## 圈子详情-->
<!--pod 'WLProfileKit/Content/Create'-->
<!--## 评论-->
<!--pod 'WLProfileKit/Comment/Create'-->
<!--## 举报-->
<!--pod 'WLProfileKit/Report/Create'-->
