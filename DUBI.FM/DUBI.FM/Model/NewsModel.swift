//
//  NewsModel.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/12/2.
//  Copyright © 2015年 fushenghua. All rights reserved.
//



class NewsModel {

    var tName:String?;
    
    var pTime:String?;//新闻发布时间
    var title:String?;
    var imageXtra:Array<String>?;
    var photosetID:String?;
    var hasHead:String?;
    var lmodify:String?;
    
    var digest:String?;//描述
    
    var imgsrc:String?;//图片链接
    
    var replyCount:String?//回复数
    
    var docid:String?;//新闻id
    
    
    
    static func idForRow(model:NewsModel) -> String{
        
        
        return "NewsCell";
    }
    
}
