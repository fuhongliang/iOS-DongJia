//
//  URefresh.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/25.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var uHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }

    var uFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class URefreshHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
//        setImages([UIImage(named: "refresh_normal")!], for: .idle)
//        setImages([UIImage(named: "refresh_will_refresh")!], for: .pulling)
//        setImages([UIImage(named: "refresh_loading_1")!,
//                   UIImage(named: "refresh_loading_2")!,
//                   UIImage(named: "refresh_loading_3")!], for: .refreshing)
        setTitle("你拉我干啥", for: .idle)
        setTitle("别拉了,快松手", for: .pulling)
        setTitle("你是不是欠收拾,又让我刷新", for: .refreshing)
        lastUpdatedTimeLabel.isHidden = true
//        stateLabel.isHidden = true
    }
}

class URefreshAutoHeader: MJRefreshHeader {}

class URefreshFooter: MJRefreshBackNormalFooter {
    override func prepare() {
        super.prepare()
        backgroundColor = .background
        isAutomaticallyChangeAlpha = true
        setTitle("上拉加载更多", for: .idle)
        setTitle("松开获取更多", for: .pulling)
        setTitle("正在获取更多", for: .refreshing)
        setTitle("就这么多啦,去别的地方看看吧", for: .noMoreData)
    }
}

class URefreshAutoFooter: MJRefreshAutoFooter {}


class URefreshDiscoverFooter: MJRefreshBackGifFooter {

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.background
        setImages([UIImage(named: "refresh_discover")!], for: .idle)
        stateLabel.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class URefreshTipKissFooter: MJRefreshBackFooter {

    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()

    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "refresh_kiss")
        return iw
    }()

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.background
//        mj_h = 10
        addSubview(tipLabel)
        addSubview(imageView)
    }

    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 20, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 90, width: 80, height: 80)
    }

    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}



