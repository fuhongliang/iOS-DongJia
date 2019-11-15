//
//  AppDelegate.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/9.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let bugTagsAppKey = "680fb8a79fdc9d164099fd4295c9786e"
    let jpushAppKey = "6b10a477d49cd29b167c53ca"
    let weChatAppKey = "wx4cb54f0fb9038e2e"

    var window: UIWindow?
    // 后台任务标识
    var backgroundTask:UIBackgroundTaskIdentifier! = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if(baseHttpsUrl.contains("test")){
            Bugtags.start(withAppKey: bugTagsAppKey, invocationEvent:    BTGInvocationEventBubble)
        }
        
        configBase()
        configWeChat()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        APIUser.shared.loadUserFromCache()
        
        self.window?.rootViewController = UTabBarController()
        
        
        window?.makeKeyAndVisible()
        
        //推送代码
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        //需要IDFA 功能，定向投放广告功能
        //let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        JPUSHService.setup(withOption: launchOptions, appKey: jpushAppKey, channel: "App Store", apsForProduction: false, advertisingIdentifier: nil)
        
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                print("registrationID获取成功：\(registrationID!)")
                saveJPushRegistrationID(registrationID: registrationID!)
            }else {
                print("registrationID获取失败：\(registrationID ?? "----")")
            }
        }
        
        return true
    }
    
    func configBase() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        // 延迟程序静止的时间
        DispatchQueue.global().async() {
            //如果已存在后台任务，先将其设为完成
            if self.backgroundTask != nil {
                application.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
        
        //如果要后台运行
        self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
            () -> Void in
            //如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        })
        
        //销毁通知红点
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        UIApplication.shared.cancelAllLocalNotifications()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    func showLoginView() -> Void {
        APIUser.shared.cleanUser()
        let loginVC = ULoginViewController()
        let loginNav = UINavigationController.init(rootViewController: loginVC)
        self.window?.rootViewController = loginNav
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DongJia")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//MARK:--微信事件代理
extension AppDelegate: WXApiDelegate{
    
    func configWeChat(){
        WXApi.registerApp(weChatAppKey)
        print("微信注册\(weChatAppKey)")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        WXApi.handleOpen(url, delegate: self)
        return true
    }
    
    func onResp(_ resp: BaseResp) { // 这里微信登录成功后
        // 发送一个通知 通知所有观察此通知的地方 并进行处理
        print("微信回调数据")
        
        if let payResp = resp as? PayResp{
            NotificationCenter.default.post(name: Notification.Name.weChatPayNotification, object: payResp)
        } else if resp.errCode == 0 && resp.type == 0 { // 登录授权成功
            let response = resp as! SendAuthResp
            
            print("微信返回的Code----\(response.code ?? "")")
            APIUserServices().login(wxCode: response.code ?? "", { (APILoginResponseModel) in
                APIUser.shared.user = APILoginResponseModel.data
                APIUser.shared.saveUserToCache()
                (self.window!.rootViewController as! UTabBarController).mineVC.refreshUserData()
            }) { (APIErrorModel) in
                
            }
            
        }
    }
    
    func onReq(_ req: BaseReq) {
        
    }
    
}

//MARK:--推送代理
extension AppDelegate : JPUSHRegisterDelegate {
    
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    //点推送进来执行这个方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    //系统获取Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
        print("----deviceToken = \(deviceToken)")
    }
    //获取token 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}

