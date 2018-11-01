//
//  ViewController.swift
//  AUXboard
//
//  Created by Quinn Booth on 10/22/18.
//  Copyright © 2018 boothApplications. All rights reserved.
//

import UIKit
import Foundation
import AVKit

let tracks = ["Pulse", "Third Thoughts", "Discharge Mentality", "Hopes Once Lost (Reborn)", "Move", "Run", "Walk", "Beauty of the Ruins", "Hit Record", "Gray Turns Blue", "Nothing To Own", "Red Lies", "", "", "", "", "", "", "", "", "", "", "", ""]

class Board: UIViewController {

    var count = 0;
    var count2 = 0.0;
    var count3 = 0.0;
    
    var presets_btn_var = false;
    
    let screen = UIScreen.main.fixedCoordinateSpace.bounds;
    
    var scroll_view = UIScrollView();
    var view_scroll = UIView();
    
    let reverse_placing = (tracks.count/2)+(tracks.count % 2);
    
    var btn1 = UIButton();
    var btn2 = UIButton();
    var btn3 = UIButton();
    var btn4 = UIButton();
    var btn5 = UIButton();
    var btn6 = UIButton();
    var btn7 = UIButton();
    var btn8 = UIButton();
    var btn9 = UIButton();
    var btn10 = UIButton();
    
    var btnPresets = UIButton();
    
    var btnSavePreset = UIButton();
    
    var lblTitle = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnDimensions = 0.9*screen.width/5;
        let btnXBase = screen.width/2-btnDimensions/2;
        let btnYBase = screen.height/6;
        
        let btn1Frame = CGRect(x: btnXBase-screen.width/5*2, y: btnYBase, width: btnDimensions, height: btnDimensions);
        let btn2Frame = CGRect(x: btnXBase-screen.width/5, y: btnYBase, width: btnDimensions, height: btnDimensions);
        let btn3Frame = CGRect(x: btnXBase, y: btnYBase, width: btnDimensions, height: btnDimensions);
        let btn4Frame = CGRect(x: btnXBase+screen.width/5, y: btnYBase, width: btnDimensions, height: btnDimensions);
        let btn5Frame = CGRect(x: btnXBase+screen.width/5*2, y: btnYBase, width: btnDimensions, height: btnDimensions);
        
        let btn6Frame = CGRect(x: btnXBase-screen.width/5*2, y: btnYBase+1.1*btnDimensions, width: btnDimensions, height: btnDimensions);
        let btn7Frame = CGRect(x: btnXBase-screen.width/5, y: btnYBase+1.1*btnDimensions, width: btnDimensions, height: btnDimensions);
        let btn8Frame = CGRect(x: btnXBase, y: btnYBase+1.1*btnDimensions, width: btnDimensions, height: btnDimensions);
        let btn9Frame = CGRect(x: btnXBase+screen.width/5, y: btnYBase+1.1*btnDimensions, width: btnDimensions, height: btnDimensions);
        let btn10Frame = CGRect(x: btnXBase+screen.width/5*2, y: btnYBase+1.1*btnDimensions, width: btnDimensions, height: btnDimensions);
        
        var btn_frames = [btn1Frame, btn2Frame, btn3Frame, btn4Frame, btn5Frame, btn6Frame, btn7Frame, btn8Frame, btn9Frame, btn10Frame];
        var btns = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn10];
        var btn_images = [#imageLiteral(resourceName: "red_btn"),#imageLiteral(resourceName: "orange_btn"),#imageLiteral(resourceName: "yellow_btn"),#imageLiteral(resourceName: "green_btn"),#imageLiteral(resourceName: "blue_btn"),#imageLiteral(resourceName: "purple_btn"),#imageLiteral(resourceName: "pink_btn"),#imageLiteral(resourceName: "cyan_btn")];
        var btn_assignments = [4, 4, 4, 7, 7, 6, 5, 3, 3, 3];
        
        for i in 0..<btns.count {
            defineBTN(btns[i], btn_frames[i], btn_images[btn_assignments[i]]);
        }
        
        lblTitle.frame = CGRect(x: screen.width/5, y: screen.height/24, width: screen.width/5*3, height: screen.height/12);
        lblTitle.backgroundColor = .black;
        lblTitle.font = lblTitle.font.withSize(lblTitle.frame.height * 1/2)
        lblTitle.textAlignment = .center;
        lblTitle.text = "AUXboard";
        lblTitle.textColor = .white;
        view.addSubview(lblTitle);
        
        btnPresets.frame = CGRect(x: 20, y: btn6Frame.maxY+(btnDimensions/3), width: 100, height: 30);
        btnPresets.setTitle("Presets", for: .normal);
        btnPresets.setTitleColor(.blue, for: .normal)
        btnPresets.contentHorizontalAlignment = .left;
        btnPresets.addTarget(self, action: #selector(Board.presets(button: )), for: .touchUpInside);
        view.addSubview(btnPresets)
        
        scroll_view.frame = CGRect(x:0,y: Int(btnPresets.frame.maxY+(btnDimensions/3)), width:Int(screen.width), height: Int(screen.height-(screen.height/2+50)));
        view_scroll.frame = CGRect(x:0,y: 0, width:Int(screen.width), height: Int(screen.height+1000));
        
        scroll_view.contentSize = CGSize(width: view_scroll.frame.width, height: view_scroll.frame.height);
        
        view.addSubview(scroll_view);
        scroll_view.addSubview(view_scroll);
        
        scroll_view.isHidden = true;
        
        let color_step = 1.0/Double(reverse_placing);
        
        btnSavePreset.frame = CGRect(x: 20, y: 0
            , width: Int(screen.width-40), height: 50);
        btnSavePreset.backgroundColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 180.0/255.0, alpha: 1.0);
        btnSavePreset.setTitle("Save Current Loops As New Preset", for: UIControlState(rawValue: 0));
        btnSavePreset.setTitleColor(.black, for: .normal);
        btnSavePreset.addTarget(self, action: #selector(Board.savePreset(button:)), for: .touchUpInside);
        view_scroll.addSubview(btnSavePreset);
        
        for i in tracks {
            count2 += 1;
            count3 += 1;
            if count2 > Double(reverse_placing){
                count3 -= 2;
            }
            let frame = CGRect(x: 20, y: 20+Int(40*count2)
                , width: Int(screen.width-40), height: 30);
            let button = UIButton();
            button.frame = frame;
            button.backgroundColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 180.0/255.0, alpha: CGFloat(count3*color_step))
            button.setTitle(i, for: UIControlState(rawValue: 0));
            view_scroll.addSubview(button);
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func defineBTN(_ button: UIButton, _ frame: CGRect, _ image: UIImage){
        button.frame = frame;
        button.imageView!.contentMode = .scaleAspectFill;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill;
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        button.setImage(image, for: .normal);
        button.addTarget(self, action: #selector(Board.press(button: )), for: .touchUpInside);
        view.addSubview(button);
    }
    
    @objc func press(button: UIButton){
        
    }
    
    @objc func presets(button: UIButton){
        if presets_btn_var == false {
            button.setTitle("Close", for: .normal);
            scroll_view.isHidden = false;
            presets_btn_var = true;
        } else {
            button.setTitle("Presets", for: .normal);
            scroll_view.isHidden = true;
            presets_btn_var = false;
        }
    }
    
    @objc func savePreset(button: UIButton){
        
    }
    

}

