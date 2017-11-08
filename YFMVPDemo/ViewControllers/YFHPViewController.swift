//
//  YFHPViewController.swift
//  YFMVPDemo
//
//  Created by tsaievan on 2017/11/6.
//  Copyright © 2017年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit

class YFHPViewController: YFBaseViewController, YFHPPresenterProtocol {
    var tableView: UITableView = UITableView()
    
    lazy var hpPresenter: YFHPPresenter = {
       let presenter = YFHPPresenter(tView: tableView)
        presenter.viewController = self
        return presenter
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "MVP Demo";
        
        ///< 布局
        initViews()
        setupConstrints()
        hpPresenter.loadHTTPData()
    }
}

extension YFHPViewController {
    func initViews() {
        view.addSubview(tableView)
    }
    
    func setupConstrints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

extension YFHPViewController {
    func didClickCell(model: CellSelfSizeListModel) {
        let string = model.title ?? ""
        print("\(string)")
    }
}
