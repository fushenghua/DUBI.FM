//
//  NewsDetailController.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/12/7.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit
import Alamofire

class NewsDetailController: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var newsWebView: UIWebView!
    var newsModel:NewsModel?;
    var index:Int?;
    var newDetailModel:NewDetailModel?
    
    lazy var arrayLists:NSArray={
    
            let tempArrayLists=NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("NewsURLs.plist", ofType: nil)!);
        return tempArrayLists!;
    }()
    
    @IBAction func backBtn(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        self.tabBarController!.tabBar.hidden=true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.newsWebView.delegate=self;
        let url="http://c.m.163.com/nc/article/"+self.newsModel!.docid!+"/full.html"
        loadNewsForDetail(url);
    }
    
    func loadNewsForDetail(url:String){
        print(url)
        
        Alamofire.request(.GET, url).responseJSON { (response:Response<AnyObject, NSError>) -> Void in
            print("====\(response.result.value)");
            
            let json:Array<JSON>=JSON(data:response.data!)["T1348647853363"].arrayValue as! Array<JSON>;
            
            
            for  jb in json {
                let new=NewsModel();
                
                new.digest=jb["digest"].string;
                new.title=jb["title"].string
                new.replyCount="20000"
                new.imgsrc=jb["imgsrc"].string
               
            }
           
            
        };
    }
    
    
    
    
}
