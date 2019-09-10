//
//  BPicker.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/8/5.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

class BPicker: UIViewController {
    
    var pickerNumber = 1
    var onePickerList:Array<String>?
    var twoPickerList:Array<String>?
    var threePickerList:Array<String>?
    var selectRow:[Int] = []
    var needLinkage:Bool = false
    
    var backData: (([String],[Int]) -> Void)?
    ///获取当前日期
//    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())    //日期类型
    var containV:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: ScreenInfo.Height-240, width: ScreenInfo.Width, height: 240))
        view.backgroundColor = UIColor.white
        return view
    }()
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    var picker: UIPickerView!
    
    init(pickerNumber:Int = 1, onePickerList:Array<String>?, twoPickerList:Array<String>? = nil,threePickerList:Array<String>? = nil,selectRow:[Int] = [0],needLinkage:Bool = false,backData: @escaping (([String],[Int]) -> Void)) {
        self.onePickerList = onePickerList
        self.twoPickerList = twoPickerList
        self.threePickerList = threePickerList
        
        self.pickerNumber = pickerNumber
        self.selectRow = selectRow
        
        self.backData = backData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }
    // MARK: - Func
    private func drawMyView() {
        self.view.backgroundColor = UIColor.clear
        self.view.insertSubview(self.backgroundView, at: 0)
        self.modalPresentationStyle = .custom//viewcontroller弹出后之前控制器页面不隐藏 .custom代表自定义
        let cancel = UIButton(frame: CGRect(x: 0, y: 10, width: 70, height: 20))
        let sure = UIButton(frame: CGRect(x: ScreenInfo.Width - 80, y: 10, width: 70, height: 20))
        cancel.setTitle("取消", for: .normal)
        sure.setTitle("确认", for: .normal)
        cancel.setTitleColor(UIColor.colorWithRGBA(r: 255, g: 51, b: 102, a: 1), for: .normal)
        sure.setTitleColor(UIColor.colorWithRGBA(r: 255, g: 51, b: 102, a: 1), for: .normal)
        cancel.addTarget(self, action: #selector(self.onClickCancel), for: .touchUpInside)
        sure.addTarget(self, action: #selector(self.onClickSure), for: .touchUpInside)
        picker = UIPickerView(frame: CGRect(x: 0, y: 24, width: ScreenInfo.Width, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.clear
        picker.clipsToBounds = true//如果子视图的范围超出了父视图的边界，那么超出的部分就会被裁剪掉。
        //创建日期选择器
        self.containV.addSubview(cancel)
        self.containV.addSubview(sure)
        self.containV.addSubview(picker)
        self.view.addSubview(self.containV)
        
        self.transitioningDelegate = self as UIViewControllerTransitioningDelegate//自定义转场动画
    }
    
    // MARK: onClick
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onClickSure() {
//        let dateString = String(format: "%02ld-%02ld-%02ld", self.picker.selectedRow(inComponent: 0) + (self.currentDateCom.year!), self.picker.selectedRow(inComponent: 1) + 1, self.picker.selectedRow(inComponent: 2) + 1)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        /// 直接回调显示
        var selectText:[String] = []
        var selectIndex:[Int] = []
        for index in 0..<pickerNumber {
            selectText.append(onePickerList?[self.picker.selectedRow(inComponent: index)] ?? "")
            if index == 1 {
               selectText.append(twoPickerList?[self.picker.selectedRow(inComponent: index)] ?? "")
            }
            if index == 2 {
                selectText.append(threePickerList?[self.picker.selectedRow(inComponent: index)] ?? "")
            }
            selectIndex.append(self.picker.selectedRow(inComponent: index))
        }
        
        self.backData?(selectText,selectIndex)
        /*** 如果需求需要不能选择已经过去的日期
         let dateSelect = dateFormatter.date(from: dateString)
         let date = Date()
         let calendar = Calendar.current
         let dateNowString = String(format: "%02ld-%02ld-%02ld", calendar.component(.year, from: date) , calendar.component(.month, from: date), calendar.component(.day, from: date))
         /// 判断选择日期与当前日期关系
         let result:ComparisonResult = (dateSelect?.compare(dateFormatter.date(from: dateNowString)!))!
         if result == ComparisonResult.orderedAscending {
         /// 选择日期在当前日期之前,可以选择使用toast提示用户.
         return
         }else{
         /// 选择日期在当前日期之后. 正常调用
         if self.backDate != nil{
         self.backDate!(dateFormatter.date(from: dateString) ?? Date())
         }
         }
         */
        self.dismiss(animated: true, completion: nil)
    }
    ///点击任意位置view消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let currentPoint = touches.first?.location(in: self.view)
        if !self.containV.frame.contains(currentPoint ?? CGPoint()) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
// MARK: - PickerViewDelegate
extension BPicker:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return onePickerList?.count ?? 0
        } else if component == 1 {
            return twoPickerList?.count ?? 0
        } else {
            return threePickerList?.count ?? 0
        }
    }
//    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
//        if (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) {
//            return 31
//        }
//        if (month == 4) || (month == 6) || (month == 9) || (month == 11) {
//            return 30
//        }
//        if (year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3) {
//            return 28
//        }
//        if year % 400 == 0 {
//            return 29
//        }
//        if year % 100 == 0 {
//            return 28
//        }
//        return 29
//    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ScreenInfo.Width / CGFloat(pickerNumber)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return onePickerList?[row] ?? ""
        } else if component == 1 {
            return twoPickerList?[row] ?? ""
        } else {
            return threePickerList?[row] ?? ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard !needLinkage else {
            if component == 0 {
                pickerView.reloadComponent(1)
                pickerView.reloadComponent(2)
            } else if component == 1 {
                pickerView.reloadComponent(2)
            }
            return
        }
        
    }
}
// MARK: - 转场动画delegate
extension BPicker:UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = PickerPresentAnimated(type: .present)
        return animated
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = PickerPresentAnimated(type: .dismiss)
        return animated
    }
}
