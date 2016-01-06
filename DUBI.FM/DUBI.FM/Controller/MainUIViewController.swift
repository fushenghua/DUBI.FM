//
//  MainUIViewController.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/10/22.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit

class MainUIViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var smallScrollView: UIScrollView!
    
    @IBOutlet weak var pageScrollView: UIScrollView!
    

    lazy var arrayLists:NSArray={
        
        let tempArrayLists=NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("NewsURLs.plist", ofType: nil)!);
        
            return tempArrayLists!;
        
        }();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the vie
        
        self.automaticallyAdjustsScrollViewInsets=false;
        self.smallScrollView.showsHorizontalScrollIndicator=false;
        self.smallScrollView.showsVerticalScrollIndicator=false;
        self.pageScrollView.showsVerticalScrollIndicator=false;
        self.pageScrollView.delegate=self;
        
        addController();
        
        addLable();
        
     
        
        
        
        let contentX=CGFloat(self.childViewControllers.count) * UIScreen.mainScreen().bounds.width;
        self.pageScrollView.contentSize=CGSizeMake(contentX, 0);
        self.pageScrollView.pagingEnabled=true;
        
        //添加默认控制器
        let vc:UIViewController=self.childViewControllers.first!;
        vc.view.frame=self.pageScrollView.bounds;
        self.pageScrollView.addSubview(vc.view);
        
        var lable:TitleLabel=self.smallScrollView.subviews.first as! TitleLabel;
        lable.sacleValue=1.0;
        self.pageScrollView.showsHorizontalScrollIndicator=false;
        
        
        
    }
    
    
    
    
    func addController(){
        for(var i=0;i<8;i++){
            
            var vc1:NewsTableViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("news") as! NewsTableViewController;
            vc1.title=self.arrayLists[i]["title"] as! String;
            vc1.urlString=self.arrayLists[i]["urlString"] as! String;
            self.addChildViewController(vc1);
        }
        
        print("size:\(self.childViewControllers.count)")
        
    
    
    }
    
    func addLable(){
        for(var i=0;i<8;i++){
            var lblW:CGFloat=70.0;
            var lblH:CGFloat=40.0;
            var lblY:CGFloat=0.0;
            var lblX:CGFloat=CGFloat(CGFloat(i) * lblW);
            
            let lbl1=TitleLabel();
            let vc:UIViewController=self.childViewControllers[i];
            
            lbl1.text=vc.title;
            lbl1.frame=CGRectMake(lblX , lblY, lblW, lblH);
            lbl1.tag=i;
            lbl1.font=UIFont(name: "HYQiHei", size: 17);
            lbl1.userInteractionEnabled=true;
            self.smallScrollView.addSubview(lbl1);
            
            lbl1.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: "lblClick:"));
        }
        
        self.smallScrollView.contentSize=CGSizeMake(70*8, 0);
    
    }
    
    
    func lblClick(recognizer:UITapGestureRecognizer){
        
        var titlelable:TitleLabel=recognizer.view as! TitleLabel;
        
        let offsetX:CGFloat=CGFloat(titlelable.tag)*CGFloat(self.pageScrollView.frame.size.width);
        var offsetY=self.pageScrollView.contentOffset.y;
        var offset=CGPointMake(offsetX, offsetY);
        
        self.pageScrollView.setContentOffset(offset, animated: true);
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 滚动结束后调用（代码导致） */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //获取索引
        let index:Int = Int(scrollView.contentOffset.x) / Int(self.pageScrollView.frame.size.width);
        
        //滚动标题栏
        var titileLable=self.smallScrollView.subviews[index] as! TitleLabel;
        var offsetX=titileLable.center.x-self.smallScrollView.frame.size.width * 0.5;
        var offsetMax=self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
        
        if(offsetX<0){
            offsetX=0;
        }else if(offsetX>offsetMax){
            offsetX=offsetMax;
        }
        
        let offset=CGPointMake(offsetX, self.smallScrollView.contentOffset.y);
        self.smallScrollView.setContentOffset(offset, animated: true);
        
        //添加控制器
        let newsVc:NewsTableViewController=self.childViewControllers[index] as! NewsTableViewController;
        newsVc.index=index;
        
//        for indexVc in self.smallScrollView.subviews {
//            var vc:NewsTableViewController=indexVc as! NewsTableViewController;
//            if (vc.index != index){
//                let titleLable=self.smallScrollView.subviews[vc.index];
//                titileLable.sacleValue=0.0;
//            }
//        }
        
        let titleLable=self.smallScrollView.subviews[index];
        titileLable.sacleValue=1.0;

//        for(var i=0;i<self.smallScrollView.subviews.count;i++){
//            if(i != index){
//                let titleLable=self.smallScrollView.subviews[i];
//                titileLable.sacleValue=0.0;
//            }
//        }
        
//        if (newsVc.view.superview==nil){
//            return;
//        }
        
        
        newsVc.view.frame=scrollView.bounds;
        self.pageScrollView.addSubview(newsVc.view);
        
        print("offset:\(offset) index :\(index)")
        
    }
    
    //正在滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //取出绝对值，避免左边往右拉时形变超过1
        let value=abs(scrollView.contentOffset.x / scrollView.frame.size.width);
        let leftIndex=Int(value);
        let rightIndex=leftIndex+1;
        
        var scaleRight=CGFloat(value) - CGFloat(leftIndex);
        let scaleLeft=1-scaleRight;
        let labelLeft:TitleLabel=self.smallScrollView.subviews[leftIndex] as! TitleLabel;
        labelLeft.sacleValue=scaleLeft;
        
          // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
        if(Int(rightIndex)<self.smallScrollView.subviews.count){
            let labeRight:TitleLabel=self.smallScrollView.subviews[Int(rightIndex)] as! TitleLabel;
            labeRight.sacleValue=scaleRight;
        }
        
    }
    
    //滚动结束
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView);
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
