//
//  CellSelfSizeModel.swift
//  YFMVPDemo
//
//  Created by tsaievan on 2017/11/8.
//  Copyright © 2017年 tsaievan. All rights reserved.
//

import UIKit

class CellSelfSizeModel: NSObject {
    @objc var data: CellSelfSizeDataModel?
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        var newValue = value
        if key == "data" && value != nil {
            newValue = CellSelfSizeDataModel(dict: value as? [String : Any] ?? [:])
            
        }
        super.setValue(newValue, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


class CellSelfSizeDataModel: NSObject {
    @objc var listArray: [Any]?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "list" && value != nil {
            var array:[Any] = []
            
            if let value = value as? [[String : Any]] {
                for tempDict in value {
                    let model:CellSelfSizeListModel = CellSelfSizeListModel(dict: tempDict)
                    array.append(model)
                }
            }
            listArray = array
        }
    }
}


class CellSelfSizeListModel: NSObject {
    
    @objc var title: String?
    @objc var time: String?
    @objc var views: NSNumber?
    @objc var img: String?
    @objc var orginImg: String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
