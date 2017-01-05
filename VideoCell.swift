//
//  VideoCell.swift
//  youtubeTutorial
//
//  Created by sabina on 04/09/16.
//  Copyright © 2016 sabina. All rights reserved.
//

import UIKit
import Foundation

class BaseCell :UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoCell: BaseCell {
    
    var video :Video?{
        didSet {
            titleLabel.text = video?.title
            if let thumbnailImage = video?.thumbnailImageName {
                thumbnailImageView.image = UIImage(named:thumbnailImage)
 
            }
            
            if let userProfileImage = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named:userProfileImage)
            }
            if let channelName = video?.channel?.name,let numberOfViews = video?.numberOfVideos {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subTitleText = "\(channelName).\(numberFormatter.string(from: numberOfViews)!)*2 years ago"
                subTitleTextView.text = subTitleText
            }
           
            //measure the title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
              
                let estimatedRect = NSString(string:title).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraints?.constant = 44
                } else{
                     titleLabelHeightConstraints?.constant = 20
                }
            }
            
            
        }
    }
    
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: DBL_MAX),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: self],
                                                         context: nil).size
    }
    
    let thumbnailImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "norahjones4")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:230/255,green: 230/255, blue:230/255, alpha:1)
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        imageView.image = UIImage(named: "norahjones1")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purpleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = "Norah Jones - Blue Space"
        return label
    }()
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = UIColor.redColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Norah Jones@VEVO - 1,66453682 views - 3 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraints:NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbnailImageView]))
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        //         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbnailImageView,"v1":separatorView]))
        
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":separatorView,]))
        
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":separatorView]))
        
        
        //thumbnailImageView.frame = CGRectMake(0,0, 100, 100)
        
        //top constraint for title label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // addConstraintsWithFormat("V:[v0(20)]", views: titleLabel)
        //addConstraintsWithFormat("H:|[v0]", views: titleLabel)
        
        //left constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraints = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute:
            .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraints!)
        
        
        //top constraint for title label
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        
        //left constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute:
            .height, multiplier: 0, constant: 30))
        
        
        
    }
}
