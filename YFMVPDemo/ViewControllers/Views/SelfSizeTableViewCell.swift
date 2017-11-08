//
//  SelfSizeTableViewCell.swift
//  YFMVPDemo
//
//  Created by tsaievan on 2017/11/8.
//  Copyright © 2017年 tsaievan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

enum CellType {
    case hasNewsPictureOneLine
    case hasNewsPictureTwoLine
    case onlyNewsContentOneLine
    case onlyNewsContentTwoLine
    
    case NewsInListCellTypeOnlyWord
    case NewsInListCellTypeHavePic
    case NewsInListCellTypeOnlyHaveTagBtn
    case NewsInListCellTypeHavePicTagBtn
}

class SelfSizeTableViewCell: UITableViewCell {
    var myCelltype: CellType?
    lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newsSourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .orange
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var refreshTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var readTimeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = false
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4)
        return button
    }()
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var separateLine: UIView = {
        let line = UIView()
        line.backgroundColor = .red
        return line
    }()
    
    var cellModel: CellSelfSizeListModel? {
        didSet {
            newsTitleLabel.text = cellModel?.title
            let viewTimes = "\(cellModel?.views ?? 0)"
            readTimeBtn.setTitle(viewTimes, for: .normal)
            newsImageView.sd_setImage(with: URL(string: cellModel?.orginImg ?? ""), completed: nil)
            refreshTimeLabel.text = cellModel?.time
        }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String, cellType: CellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        myCelltype = cellType
        initViews()
        setupConstraints()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelfSizeTableViewCell {
    fileprivate func initViews() {
        switch myCelltype! {
        case CellType.NewsInListCellTypeOnlyWord:
            
            contentView.addSubview(newsTitleLabel)
            contentView.addSubview(refreshTimeLabel)
            contentView.addSubview(readTimeBtn)
            contentView.addSubview(separateLine)
            
            break
        case CellType.NewsInListCellTypeHavePic:
            contentView.addSubview(newsTitleLabel)
            contentView.addSubview(refreshTimeLabel)
            contentView.addSubview(readTimeBtn)
            contentView.addSubview(separateLine)
            contentView.addSubview(newsImageView)
            break
            
        case .hasNewsPictureOneLine:

            break
        case .hasNewsPictureTwoLine:break
            
        case .onlyNewsContentOneLine:break
            
        case .onlyNewsContentTwoLine:break
            
        case .NewsInListCellTypeOnlyHaveTagBtn:
            contentView.addSubview(newsTitleLabel)
            contentView.addSubview(refreshTimeLabel)
            contentView.addSubview(readTimeBtn)
            contentView.addSubview(separateLine)
            break
            
        case .NewsInListCellTypeHavePicTagBtn:
            contentView.addSubview(newsTitleLabel)
            contentView.addSubview(refreshTimeLabel)
            contentView.addSubview(readTimeBtn)
            contentView.addSubview(separateLine)
            contentView.addSubview(newsImageView)
            break
            
        }
    }
    
    fileprivate func setupConstraints() {
        readTimeBtn.setContentHuggingPriority(.defaultHigh, for: .vertical)
        readTimeBtn.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        if myCelltype == CellType.NewsInListCellTypeOnlyWord {
            newsTitleLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(contentView.snp.leading).offset(13)
                make.trailing.equalTo(contentView.snp.trailing).offset(-13)
                make.top.equalTo(contentView.snp.top).offset(10)
            })
            
            refreshTimeLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(readTimeBtn.snp.trailing).offset(17)
                make.centerY.equalTo(readTimeBtn.snp.centerY)
            })
            
            readTimeBtn.snp.makeConstraints({ (make) in
                make.top.equalTo(newsTitleLabel.snp.bottom).offset(18)
                make.leading.equalTo(newsTitleLabel.snp.leading).offset(6)
                make.bottom.equalTo(separateLine.snp.top).offset(-10)
            })
        }else if myCelltype == CellType.NewsInListCellTypeHavePic {
            newsImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(newsTitleLabel.snp.top)
                make.width.equalTo(80)
                make.height.equalTo(60)
                make.trailing.equalTo(contentView.snp.trailing).offset(-13)
                make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            })
            
            newsTitleLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(contentView.snp.leading).offset(13)
                make.trailing.equalTo(newsImageView.snp.leading).offset(-13)
                make.top.equalTo(contentView.snp.top).offset(10)
            })
            
            refreshTimeLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(readTimeBtn.snp.trailing).offset(17)
                make.centerY.equalTo(readTimeBtn.snp.centerY)
            })
            
            readTimeBtn.snp.makeConstraints({ (make) in
                make.top.equalTo(newsTitleLabel.snp.bottom).offset(18)
                make.leading.equalTo(newsTitleLabel.snp.leading).offset(6)
                make.bottom.equalTo(separateLine.snp.top).offset(-10)
            })
        }else if myCelltype == CellType.NewsInListCellTypeHavePicTagBtn {
            newsImageView.snp.makeConstraints({ (make) in
                make.top.equalTo(newsTitleLabel.snp.top)
                make.width.equalTo(80)
                make.height.equalTo(60)
                make.trailing.equalTo(contentView.snp.trailing).offset(-13)
                make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            })
            
            newsTitleLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(contentView.snp.leading).offset(13)
                make.trailing.equalTo(newsImageView.snp.leading).offset(-13)
                make.top.equalTo(contentView.snp.top).offset(10)
            })
            
            refreshTimeLabel.snp.makeConstraints({ (make) in
                make.leading.equalTo(readTimeBtn.snp.trailing).offset(17)
                make.centerY.equalTo(readTimeBtn.snp.centerY)
            })
        }
        separateLine.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(contentView)
            make.height.equalTo(0.5)
        }
    }
}
