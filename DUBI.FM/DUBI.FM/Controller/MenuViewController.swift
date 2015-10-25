//
//  MenuViewController.swift
//  Menu
//
//  Created by innovane on 14-6-23.
//  Copyright (c) 2014年 innovane. All rights reserved.
//

import UIKit

let kICSDrawerControllerLeftViewInitialOffset : CGFloat  = 60.0

let  kICSDrawerControllerDrawerDepth : CGFloat = 200.0

enum ICSDrawerControllerState : Int {
    case MenuControllerStateOpening
    case MenuControllerStateClosing
}


class MenuViewController: UIViewController {

    //用户点击center
    var tapGestureRecognizer :
    UITapGestureRecognizer!
    
    //    用户拖动视图
    var panGestureRecognizer :
    UIPanGestureRecognizer!
    
    //    用户touch的点位置
    var panGestureStartLocation : CGPoint!
    
    //    左边控制器
    var leftViewController : UIViewController!
    
    //中间控制器
    var centerViewController : UIViewController!
    
    var drawerState : ICSDrawerControllerState!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawerState = ICSDrawerControllerState.MenuControllerStateClosing;
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //        将左边控制器加入导航栏中。
        
        if self.leftViewController != nil{
            if (self.leftViewController.view.superview == nil){
            
                self.addChildViewController(self.leftViewController)
                
                self.view.insertSubview(self.leftViewController.view, atIndex:0)
                
            }
            
        }
        if self.centerViewController != nil{
             if (self.centerViewController.view.superview == nil){
                
                self.addChildViewController(self.centerViewController)
                
                self.view.addSubview(self.centerViewController.view)
                
            }
        }
        
        //        添加用户拖动事件。
        self.panGestureRecognizer = UIPanGestureRecognizer()
        self.panGestureRecognizer.addTarget(self,action:"panGestureRecognized:");
        self.centerViewController.view.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    //    用户拖动视图调用代理方法。
    func panGestureRecognized(panGestureRecognizer:UIPanGestureRecognizer){
        
        //        用户对视图操控的状态。
        let state = panGestureRecognizer.state;
        
        let location = panGestureRecognizer.locationInView(self.view)
        
        var velocity = panGestureRecognizer.velocityInView(self.view)
           
        
        switch (state) {
            
        case UIGestureRecognizerState.Began:
            //                记录用户开始点击的位置
            self.panGestureStartLocation = location;
            
            print("Began")
            
            break;
            
        case UIGestureRecognizerState.Changed:
            print("Changed")
            
            var c = self.centerViewController.view.frame
            
            if (panGestureRecognizer.translationInView(self.centerViewController.view).x > 0){
                
                if (self.drawerState == ICSDrawerControllerState.MenuControllerStateClosing){
                    c.origin.x = location.x - self.panGestureStartLocation.x;
                }
                
            }else if (panGestureRecognizer.translationInView(self.centerViewController.view).x > -kICSDrawerControllerDrawerDepth){
                
                if (self.drawerState == ICSDrawerControllerState.MenuControllerStateOpening){
            
                    c.origin.x = panGestureRecognizer.translationInView(self.centerViewController.view).x+kICSDrawerControllerDrawerDepth
                }
            }
                self.centerViewController.view.frame = c ;
            break;
          
            
        case UIGestureRecognizerState.Ended:

            let c = self.centerViewController.view.frame
        
//            表示用户需要展开
            if (location.x - self.panGestureStartLocation.x > kICSDrawerControllerLeftViewInitialOffset){
                self.didOpen()
            }else{
                if  (c.origin.x < (kICSDrawerControllerDrawerDepth - 40)){
                    self.didClose()
                }else{
                    self.didOpen()
                }
            }
            break;
        default:
            break;
        }
    }
    
//    移除点击事件，添加拖动事件
    func tapGestureRecognized(tapGestureRecognizer : UITapGestureRecognizer){
        self.didClose();
    }
    
//        菜单栏打开
    func didOpen(){
        
        var c = self.centerViewController.view.frame
        
        c.origin.x = kICSDrawerControllerDrawerDepth;
        
      
        UIView.animateWithDuration(0.7,delay:0,usingSpringWithDamping:0.5,initialSpringVelocity:1.0,options:UIViewAnimationOptions.AllowUserInteraction,animations:{
                self.centerViewController.view.frame = c ;
            },completion: { (finished: Bool) -> Void in
            
        })
 
        
        self.drawerState = ICSDrawerControllerState.MenuControllerStateOpening
        
        //增加点击事件
        if (self.tapGestureRecognizer == nil){
            
            self.tapGestureRecognizer  = UITapGestureRecognizer()
            self.tapGestureRecognizer.addTarget(self,action:"tapGestureRecognized:");
            
        }
        self.centerViewController.view.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
//    菜单关闭
    func didClose(){
        if (self.drawerState == ICSDrawerControllerState.MenuControllerStateOpening){
            
            self.drawerState = ICSDrawerControllerState.MenuControllerStateClosing
            
            self.centerViewController.view.removeGestureRecognizer(self.tapGestureRecognizer)
        }
        var c = self.centerViewController.view.frame
        
        c.origin.x = 0
        
        UIView.animateWithDuration(0.5,delay:0,usingSpringWithDamping:0.9,initialSpringVelocity:1.0,options:UIViewAnimationOptions.AllowUserInteraction,animations:{
            self.centerViewController.view.frame = c ;
            },completion: { (finished: Bool) -> Void in
                
            })
    }
}
