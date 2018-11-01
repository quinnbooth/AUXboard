//
//  ViewController.swift
//  AUXboard
//
//  Created by Quinn Booth on 10/22/18.
//  Copyright © 2018 boothApplications. All rights reserved.
//

/*{
 "info" : {
 "version" : 1,
 "author" : "xcode"
 },
 "properties" : {
 "provides-namespace" : true
 }
 }*/

import UIKit
import Foundation
import AVKit


class Presets: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.fixedCoordinateSpace.bounds;
        
        var scroll_view = UIScrollView();
        var view_scroll = UIView();
        
        scroll_view.frame = CGRect(x:0,y: Int(screen.height/2+50), width:Int(screen.width), height: Int(screen.height-(screen.height/2+50)));
        view_scroll.frame = CGRect(x:0,y: Int(screen.height/2+50), width:Int(screen.width), height: Int(screen.height+1000));
        
        scroll_view.contentSize = CGSize(width: view_scroll.frame.width, height: view_scroll.frame.height);
        
        view.addSubview(scroll_view);
        scroll_view.addSubview(view_scroll);
        
        //let scroll_screen = scroll.bounds;
        let reverse_placing = (tracks.count/2)+(tracks.count % 2)
        let color_step = 1.0/Double(reverse_placing);
        var count = 0.0;
        var count2 = 0.0;
        
        for i in tracks {
            count2 += 1;
            count += 1;
            if count2 > Double(reverse_placing){
                count -= 2;
            }
            let frame = CGRect(x: 20, y: /*Int(screen.height/2)*/0+Int(40*count2)
                , width: Int(screen.width-40), height: 30);
            let button = UIButton();
            button.frame = frame;
            button.backgroundColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 180.0/255.0, alpha: CGFloat(count*color_step))
            button.setTitle(i, for: UIControlState(rawValue: 0));
           print(button.center)
           view_scroll.addSubview(button);
        }
        //let path = Bundle.main.path(forResource: "a1", ofType: "mp3", inDirectory: "Pulse")!
        //print(path)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

