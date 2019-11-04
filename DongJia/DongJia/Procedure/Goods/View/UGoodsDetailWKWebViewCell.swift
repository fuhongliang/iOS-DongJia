//
//  UGoodsDetailWKWebViewCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import WebKit

/// webView的加载完成回调
protocol UGoodsDetailWKWebViewHeightCallBack {
    func wkWebViewHeightCallBack(height: CGFloat)
}

class UGoodsDetailWKWebViewCell: UBaseTableViewCell {
    
    var heightDelegate: UGoodsDetailWKWebViewHeightCallBack?
    
    /// 商品详情文本
    let goodsDetailLabel = UILabel().then{
        $0.text = "商品详情"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    /// 商品详情加载WebView
    var wkWebView: WKWebView!
    
    override func configUI() {
        
        
        let js = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}"
        let wkUScript = WKUserScript.init(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        /// 商品详情加载WebView
        wkWebView = WKWebView(frame: .zero, configuration: wkWebConfig)
        
        contentView.addSubview(goodsDetailLabel)
        contentView.addSubview(wkWebView)
        wkWebView.scrollView.bouncesZoom = false
        //MARK:商品详情文本
        goodsDetailLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        wkWebView.navigationDelegate = self
        //MARK:WebView
        wkWebView.snp.makeConstraints { (make) in
            make.top.equalTo(goodsDetailLabel.snp.bottom).offset(15)
            make.width.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    var html: String? {
        didSet {
            guard let html = html else { return }
            wkWebView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    /// 当前是否加载完成
    var isWebReload: Bool = false

}
extension UGoodsDetailWKWebViewCell: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var high: Int?
        webView.evaluateJavaScript("document.body.scrollHeight") { (obj, error) in
            guard let height = obj as? Int else { return }
            high = height
            if !self.isWebReload {
                self.wkWebView.snp.makeConstraints { (make) in
                    make.top.equalTo(self.goodsDetailLabel.snp.bottom).offset(15)
                    //修改计算得到的高度
                    make.height.equalTo(height)
                    make.width.left.bottom.equalToSuperview()
                }
            }
        }
        /// 当确认页面加载完成时通知TableView修改Cell高度
        self.wkWebView.evaluateJavaScript("document.readyState") { (obj, complete) in
            if obj as? String == "complete" && !self.wkWebView.isLoading{
                if !self.isWebReload {
                    // 第一次计算高度完成通知后  后续则不再刷新高度
                    self.heightDelegate?.wkWebViewHeightCallBack(height: CGFloat(high ?? 0))
                    self.isWebReload = true
                }
            }
        }
    }
}
