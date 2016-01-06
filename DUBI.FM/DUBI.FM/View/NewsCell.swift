//
//  NewsCell.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/12/3.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!//标题
    
    @IBOutlet weak var lblReply: UILabel!//回复数
    
    @IBOutlet weak var imgIcon: UIImageView!//图片
    
    @IBOutlet weak var lblSubtitle: UILabel!//描述
    
    
    func setNewsModel(newsMode:NewsModel){
        
        //加载图片
        ImageLoader.sharedLoader.imageForUrl(newsMode.imgsrc!, completionHandler:{(image: UIImage?, url: String) in
            self.imgIcon.image = image
        });
        
        //回复数
        var displayCount:String;
        var count=Int(newsMode.replyCount!);
        
        if(count>10000){
         displayCount=String((count!/10000))+"万跟帖";
        }else{
         displayCount=String(count!)+"万跟帖";
        }
        
        self.lblReply.text=displayCount;
        
        //标题，描述
        self.lblTitle.text=newsMode.title;
        self.lblSubtitle.numberOfLines = 0;
        self.lblSubtitle.preferredMaxLayoutWidth = self.lblSubtitle.bounds.size.width;
        self.lblSubtitle.lineBreakMode=NSLineBreakMode.ByCharWrapping;
        self.lblSubtitle.text=newsMode.digest;
        
    
    
    }
  
    
}
