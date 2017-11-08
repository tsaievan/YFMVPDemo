//
//  YFHPPresenter.swift
//  YFMVPDemo
//
//  Created by tsaievan on 2017/11/6.
//  Copyright © 2017年 tsaievan. All rights reserved.
//

import UIKit

@objc protocol YFPresenterProtocol {
    @objc optional func setView(view: UIView)
    
    @objc optional func setViewController(viewController: UIViewController)
    
    @objc optional func present()
    
    @objc optional func presentWithModelAndViewController(model: AnyObject, viewController: UIViewController)
}

@objc protocol YFHPPresenterProtocol {
    @objc func didClickCell(model: CellSelfSizeListModel)
}

class YFHPPresenter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var hpModel: CellSelfSizeModel?
    
    var viewController: YFHPPresenterProtocol?
    
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.separatorStyle = .none
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 100
        }
    }
    
    init(tView: UITableView) {
        super.init()
        tableView = tView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 100
    }
}

extension YFHPPresenter: YFPresenterProtocol {
    
    func present() {
        tableView?.reloadData()
    }
}

extension YFHPPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hpModel?.data?.listArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ID: String?
        var type: CellType?
        var newsList: CellSelfSizeListModel?
        guard let list = hpModel?.data?.listArray else {
            return UITableViewCell()
        }
        
        if indexPath.row > list.count - 1 {
            newsList = nil
        }else {
            newsList = list[indexPath.row] as? CellSelfSizeListModel ?? CellSelfSizeListModel(dict: [:])
        }
        if ((newsList?.orginImg)! as NSString).length > 0 {
            type = CellType.NewsInListCellTypeHavePic
        }else {
            type = CellType.NewsInListCellTypeOnlyWord
        }
        
        ID = "reusId + \(String(describing: type))"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ID!) as? SelfSizeTableViewCell
        
        if cell == nil {
            cell = SelfSizeTableViewCell(style: .default, reuseIdentifier: ID!, cellType: type!)
        }
        cell?.cellModel = newsList
        return cell!
    }
}

extension YFHPPresenter {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.didClickCell(model: hpModel?.data?.listArray![indexPath.row] as! CellSelfSizeListModel)
    }
}

extension YFHPPresenter {
     func loadHTTPData() {
        let dataPath = Bundle.main.path(forResource: "testCellData", ofType: "json")
        let data = NSData(contentsOfFile: dataPath ?? "")
        
        guard let newData = data else {
            return
        }
        let dataDict = try? JSONSerialization.jsonObject(with: newData as Data, options: .allowFragments)
        
        hpModel = CellSelfSizeModel(dict: dataDict as? [String : Any] ?? [:])
        present()
    }
}
