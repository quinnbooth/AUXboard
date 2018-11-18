//
//  Board.swift
//  AUXboard
//
//  Created by Quinn Booth on 10/22/18.
//  Copyright © 2018 boothApplications. All rights reserved.
//












////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
//              Declarations and Vars               ////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /////GLOBAL VARS AND IMPORTS//////////////////////////////////////////////////////////////////////////

import UIKit
import Foundation
import AVKit
import AVFoundation

let tracks = ["Pulse", "Third Thoughts", "Discharge Mentality", "Hopes Once Lost (Reborn)", "Move", "Run", "Walk", "Beauty of the Ruins", "Hit Record", "Gray Turns Blue", "Nothing To Own", "Red Lies", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
let samples = ["Basic", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "","", "", "", "", "", "", "", "", "", "", "", ""]
let samples2 = ["Basic Beat", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "","", "", "", "", "", "", "", "", "", "", "", ""]

class Board: UIViewController {
    /////AUDIO//////////////////////////////////////////////////////////////////////////////////////////
    
    var timer: Timer!
    var progress: Float!
    var proval: Double = 0.00;
    var startTime: AVAudioTime? = nil
    
    var channel1: AVAudioEngine!
    var channel2: AVAudioEngine!
    var channel3: AVAudioEngine!
    var channel4: AVAudioEngine!
    var channel5: AVAudioEngine!
    var channel6: AVAudioEngine!
    var channel7: AVAudioEngine!
    var channel8: AVAudioEngine!
    var channel9: AVAudioEngine!
    var channel10: AVAudioEngine!
    
    var channels = [AVAudioEngine]();
    var channelsnodes = [AVAudioPlayerNode]();
    var tempchannelsnodes = [AVAudioPlayerNode]();
    var looptoggler = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    var loops = [AVAudioFile]();
    
    var synth1: AVAudioEngine!
    var synth2: AVAudioEngine!
    var synth3: AVAudioEngine!
    var synth4: AVAudioEngine!
    var synth5: AVAudioEngine!
    var synth6: AVAudioEngine!
    var synth7: AVAudioEngine!
    var synth8: AVAudioEngine!
    
    var synths = [AVAudioEngine]();
    var synthsnodes = [AVAudioPlayerNode]();
    
    /////VARS/////////////////////////////////////////////////////////////////////////////////////////////
    
    var btnMode = "n/a";
    var buttontoggler = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    var btns = [UIButton]();
    var preset: String? = "";
    var btnColors = [#imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn")];
    var btnAlphas = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
    
    /////UI ELEMENT VARS//////////////////////////////////////////////////////////////////////////////////
    
    var count = 0;
    var count2 = 0.0;
    var count3 = 0.0;
    var count4 = 0;
    var presets_btn_var = false;
    var presets_btn_var2 = false;
    var presets_btn_var3 = false;
    let reverse_placing = (tracks.count/2)+(tracks.count % 2);
    let reverse_placing2 = (samples.count/2)+(samples.count % 2);
    let reverse_placing3 = (samples2.count/2)+(samples2.count % 2);
    let screen = UIScreen.main.fixedCoordinateSpace.bounds;
    
    /////DEFINING UI ELEMENTS/////////////////////////////////////////////////////////////////////////////
    
    var scroll_view = UIScrollView();
    var view_scroll = UIView();
    var scroll_view2 = UIScrollView();
    var view_scroll2 = UIView();
    var scroll_view3 = UIScrollView();
    var view_scroll3 = UIView();
    
    var loopProgress = UIProgressView();
    
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
    
    var btn_play = UIButton();
    var btn_record = UIButton();
    var btn_edit = UIButton();
    
    var btnPresets = UIButton();
    var btnSynthPresets = UIButton();
    var drums_synths = UISegmentedControl();
    var loops_synths = UISegmentedControl();
    
    var btnSavePreset = UIButton();
    
    var lblTitle = UILabel();
    
    var volumeMeter = UISlider();
    var gainMeter = UISlider();
    var lowpassMeter = UISlider();
    var highpassMeter = UISlider();
    var reverbMeter = UISlider();
    var duckerMeter = UISlider();
    var pitchMeter = UISlider();
    
    var volumeLBL = UILabel();
    var gainLBL = UILabel();
    var lowpassLBL = UILabel();
    var highpassLBL = UILabel();
    var reverbLBL = UILabel();
    var duckerLBL = UILabel();
    var pitchLBL = UILabel();
    var playLBL = UILabel();
    var recordLBL = UILabel();
    var editLBL = UILabel();
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
//                  Misc. Functions                 ////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func defineBTN(_ button: UIButton, _ frame: CGRect, _ image: UIImage){
        button.frame = frame;
        button.imageView!.contentMode = .scaleAspectFill;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill;
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        button.setImage(image, for: .normal);
        button.addTarget(self, action: #selector(Board.press(button: )), for: .touchUpInside);
        view.addSubview(button);
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
//                 Button Functions                 ////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @objc func pickPreset(button: UIButton){
        loops_synths.selectedSegmentIndex = 0
        loops = [];
        preset = button.currentTitle!
        count4 = 0;
        let key: String? = "mp3";
        let file_paths = Bundle.main.urls(forResourcesWithExtension: key, subdirectory: preset);
        var files = [String]();
        for _ in file_paths!{
            files.append(file_paths![count4].deletingPathExtension().lastPathComponent)
            count4 += 1;
        }
        files = files.sorted(by: { $0 < $1 })
        count4 = 0;
        btnColors = [];
        for i in btns {
            if files[count4].first == "a" {
                i.setImage(#imageLiteral(resourceName: "blue_btn"), for: .normal)
            } else if files[count4].first == "b" {
                i.setImage(#imageLiteral(resourceName: "purple_btn"), for: .normal)
                if files[count4].dropFirst().first == "b" {
                    i.setImage(#imageLiteral(resourceName: "pink_btn"), for: .normal)
                }
            } else if files[count4].first == "c" {
                i.setImage(#imageLiteral(resourceName: "green_btn"), for: .normal)
                if files[count4].dropFirst().first == "c" {
                    i.setImage(#imageLiteral(resourceName: "yellow_btn"), for: .normal)
                }
            } else if files[count4].first == "l" {
                i.setImage(#imageLiteral(resourceName: "cyan_btn"), for: .normal)
                if files[count4].dropFirst().first == "l" {
                    i.setImage(#imageLiteral(resourceName: "orange_btn"), for: .normal)
                }
                if files[count4].dropFirst().first == "l" {
                    i.setImage(#imageLiteral(resourceName: "red_btn"), for: .normal)
                }
            }
            btnColors.append(i.currentImage!);
            do{try loops.append(AVAudioFile(forReading: URL.init(fileURLWithPath: Bundle.main.path(forResource: String(files[count4]), ofType: key, inDirectory: preset)!)))}catch{print(error)}
            count4 += 1;
        }
        count4 = 0;
        
        ////////////////////
        
        for _ in loops {
            channelsnodes[count4].stop()
            channelsnodes[count4].reset()
            count4 += 1
        }
        count4 = 0
        tempchannelsnodes = channelsnodes
        for i in channels {
            i.stop();
            i.reset();
            i.attach(channelsnodes[count4])
            //let pitch = AVAudioUnitTimePitch()
            //pitch.pitch = 0
            //i.attach(pitch)
            //i.connect(channelsnodes[count4], to: pitch, format: nil)
            //i.connect(pitch, to: i.outputNode, format: nil)
            i.connect(channelsnodes[count4], to: i.outputNode, format: nil)
            //note
            let frameCount: AVAudioFrameCount = AVAudioFrameCount(loops[count4].length)
            channelsnodes[count4].prepare(withFrameCount: frameCount)
            //channelsnodes[count4].scheduleFile(loops[count4], at: nil, completionHandler: nil)
            tempchannelsnodes[count4].scheduleSegment(loops[count4], startingFrame: 0, frameCount: frameCount, at: nil, completionHandler: nil)
            do{try i.start()}catch{print(error)}
            count4 += 1;
        }
        btnMode = "loop"
    }
    
    @objc func press(button: UIButton){
        if btnMode == "loop" {
            count4 = 0
            for i in btns {
                if i == button {
                    if looptoggler[btns.index(of: i)!] == 1 {
                        looptoggler[btns.index(of: i)!] = 0
                        button.alpha = 1.0
                    } else {
                        looptoggler[btns.index(of: i)!] = 1
                        button.alpha = 0.5
                    }
                }
                count4 += 1
            }
        } else {
        }
    }
    
    @objc func savePreset(button: UIButton){
        
    }
    
    @objc func progressLog(){
        print(loopProgress.progress)
        loopProgress.progress += Float(0.13);
        if loopProgress.progress >= 1.00 {
            loopProgress.progress = 0.00;
        }
        if loopProgress.progress == 0.00 {
            
            let frameCount: AVAudioFrameCount = AVAudioFrameCount(loops[0].length)
            for i in tempchannelsnodes {
                if looptoggler[tempchannelsnodes.index(of: i)!] == 1 {
                    channelsnodes[tempchannelsnodes.index(of: i)!].scheduleSegment(loops[tempchannelsnodes.index(of: i)!], startingFrame: 0, frameCount: frameCount, at: nil, completionHandler: nil)
                }
            }
        }
    }
    
    @objc func playACT(button: UIButton){
        if button.currentImage == #imageLiteral(resourceName: "btnPlay"){
            if looptoggler != [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] {
                let frameCount: AVAudioFrameCount = AVAudioFrameCount(loops[0].length)
                for i in tempchannelsnodes {
                    if looptoggler[tempchannelsnodes.index(of: i)!] == 1 {
                        channelsnodes[tempchannelsnodes.index(of: i)!].scheduleSegment(loops[tempchannelsnodes.index(of: i)!], startingFrame: 500, frameCount: frameCount, at: nil, completionHandler: nil)
                    }
                }
                for i in channelsnodes {
                    if(startTime == nil) {
                        let kStartDelayTime: Float = 0.1; // sec
                        let outputFormat: AVAudioFormat? = i.outputFormat(forBus:0);
                        let startSampleTime: AVAudioFramePosition? = (i.lastRenderTime?.sampleTime)! + AVAudioFramePosition(kStartDelayTime * Float((outputFormat?.sampleRate)!));
                        startTime = AVAudioTime(sampleTime: startSampleTime!, atRate: (outputFormat?.sampleRate)!)
                    }
                    i.play(at: startTime)
                }
                
                let key: String? = "mp3";
                let file_paths = Bundle.main.urls(forResourcesWithExtension: key, subdirectory: preset);
                do{
                    let file = try AVAudioFile(forReading: file_paths![0])
                    let audioNodeFileLength = AVAudioFrameCount(file.length)
                    proval = Double(Double(audioNodeFileLength) / 44100) //Divide by the AVSampleRateKey in the recorder settings
                }catch{}
                button.setImage(#imageLiteral(resourceName: "btnPause"), for: .normal);
                timer = Timer.scheduledTimer(timeInterval: Double(proval/8), target: self, selector: #selector(Board.progressLog), userInfo: nil , repeats: true)
                timer.fire()
                loopProgress.progress = 0.00;
            }
        } else {
            button.setImage(#imageLiteral(resourceName: "btnPlay"), for: .normal);
            timer.invalidate()
            loopProgress.progress = 0.00;
            for i in channelsnodes {
                i.stop()
                i.reset()
            }
        }
    }
    
    @objc func recordACT(button: UIButton){
        if button.backgroundColor == nil{
            button.backgroundColor = .white;
        } else {
            button.backgroundColor = nil;
        }
    }
    
    @objc func editACT(button: UIButton){
        if button.backgroundColor == nil{
            button.backgroundColor = .white;
        } else {
            button.backgroundColor = nil;
        }
    }
    
    /////UI Rotationary Commands/////////////////////////////////////////////////////////////////////////////
    
    @objc func presets(button: UIButton){
        let play_width = Int(screen.width/5)
        let hideComponents = [volumeMeter, gainMeter, lowpassMeter, highpassMeter, reverbMeter, duckerMeter, pitchMeter, volumeLBL, gainLBL, lowpassLBL, highpassLBL, reverbLBL, duckerLBL, pitchLBL, volumeLBL, btn_edit, btn_record, playLBL, editLBL, recordLBL, loops_synths]
        if presets_btn_var == false {
            button.setTitle("Close", for: .normal);
            scroll_view.isHidden = false;
            for i in hideComponents{
                i.isHidden = true;
            }
            if scroll_view2.isHidden == false || scroll_view3.isHidden == false{
                scroll_view2.isHidden = true;
                scroll_view3.isHidden = true;
                drums_synths.isHidden = true;
                btnSynthPresets.setTitle("Synth Presets", for: .normal);
                presets_btn_var2 = false;
            }
            btn_play.frame = CGRect(x:0,y:0,width:btnPresets.frame.height*2, height:btnPresets.frame.height*2);
            btn_play.center.x = btn8.center.x;
            btn_play.center.y = btnPresets.center.y;
            presets_btn_var = true;
        } else {
            button.setTitle("Loop Presets", for: .normal);
            scroll_view.isHidden = true;
            for i in hideComponents{
                i.isHidden = false;
            }
            btn_play.frame = CGRect(x:Int(screen.width/2)-play_width/2, y:Int(screen.height/2), width:play_width, height:play_width);
            presets_btn_var = false;
        }
    }
    
    @objc func synthPresets(button: UIButton){
        let play_width = Int(screen.width/5)
        let hideComponents = [volumeMeter, gainMeter, lowpassMeter, highpassMeter, reverbMeter, duckerMeter, pitchMeter, volumeLBL, gainLBL, lowpassLBL, highpassLBL, reverbLBL, duckerLBL, pitchLBL, volumeLBL, btn_edit, btn_record, playLBL, editLBL, recordLBL, loops_synths]
        if presets_btn_var2 == false {
            button.setTitle("Close", for: .normal);
            for i in hideComponents{
                i.isHidden = true;
            }
            if scroll_view.isHidden == false{
                scroll_view.isHidden = true;
                btnPresets.setTitle("Loop Presets", for: .normal);
                presets_btn_var = false;
            }
            btn_play.frame = CGRect(x:0,y:0,width:btnPresets.frame.height*2, height:btnPresets.frame.height*2);
            btn_play.center.x = btn8.center.x;
            btn_play.center.y = btnPresets.center.y;
            if drums_synths.selectedSegmentIndex == 0 {
                view_scroll2.isHidden = false;
                view_scroll3.isHidden = true;
                scroll_view2.isHidden = false;
                scroll_view3.isHidden = true;
            } else {
                view_scroll2.isHidden = true;
                view_scroll3.isHidden = false;
                scroll_view2.isHidden = true;
                scroll_view3.isHidden = false;
            }
            drums_synths.isHidden = false;
            presets_btn_var2 = true;
        } else {
            button.setTitle("Synth Presets", for: .normal);
            for i in hideComponents{
                i.isHidden = false;
            }
            btn_play.frame = CGRect(x:Int(screen.width/2)-play_width/2, y:Int(screen.height/2), width:play_width, height:play_width);
            scroll_view2.isHidden = true;
            scroll_view3.isHidden = true;
            drums_synths.isHidden = true;
            presets_btn_var2 = false;
        }
    }
    
    @objc func switchSynth(button: UISegmentedControl){
        if button.selectedSegmentIndex == 0 {
            view_scroll2.isHidden = false;
            view_scroll3.isHidden = true;
            scroll_view2.isHidden = false;
            scroll_view3.isHidden = true;
        } else {
            view_scroll2.isHidden = true;
            view_scroll3.isHidden = false;
            scroll_view2.isHidden = true;
            scroll_view3.isHidden = false;
        }
    }
    
    @objc func switchMode(button: UISegmentedControl){
        if button.selectedSegmentIndex == 0 {
            btnMode = "loop"
            if btnColors == [#imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "blue_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "blue_btn")]{
                btnColors = [#imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn"), #imageLiteral(resourceName: "cyan_btn")];
            }
            for i in btns {
                i.setImage(btnColors[btns.index(of: i)!], for: .normal)
                i.alpha = CGFloat(btnAlphas[btns.index(of: i)!])
            }
        } else {
            btnMode = "synth"
            for i in btns {
                i.setImage(#imageLiteral(resourceName: "cyan_btn"), for: .normal)
                btnAlphas[btns.index(of: i)!] = Double(i.alpha)
                i.alpha = 1.0
            }
            btns[4].setImage(#imageLiteral(resourceName: "blue_btn"), for: .normal)
            btns[9].setImage(#imageLiteral(resourceName: "blue_btn"), for: .normal)
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
//             Loading User Interface               ////////////////////////////////////////////////////////
//                                                  ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension Board {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channel1 = AVAudioEngine()
        channel2 = AVAudioEngine()
        channel3 = AVAudioEngine()
        channel4 = AVAudioEngine()
        channel5 = AVAudioEngine()
        channel6 = AVAudioEngine()
        channel7 = AVAudioEngine()
        channel8 = AVAudioEngine()
        channel9 = AVAudioEngine()
        channel10 = AVAudioEngine()
        synth1 = AVAudioEngine()
        synth2 = AVAudioEngine()
        synth3 = AVAudioEngine()
        synth4 = AVAudioEngine()
        synth5 = AVAudioEngine()
        synth6 = AVAudioEngine()
        synth7 = AVAudioEngine()
        synth8 = AVAudioEngine()
        
        let channel1node = AVAudioPlayerNode()
        let channel2node = AVAudioPlayerNode()
        let channel3node = AVAudioPlayerNode()
        let channel4node = AVAudioPlayerNode()
        let channel5node = AVAudioPlayerNode()
        let channel6node = AVAudioPlayerNode()
        let channel7node = AVAudioPlayerNode()
        let channel8node = AVAudioPlayerNode()
        let channel9node = AVAudioPlayerNode()
        let channel10node = AVAudioPlayerNode()
        
        channelsnodes = [channel1node, channel2node, channel3node, channel4node, channel5node, channel6node, channel7node, channel8node, channel9node, channel10node]
        
        let synth1node = AVAudioPlayerNode()
        let synth2node = AVAudioPlayerNode()
        let synth3node = AVAudioPlayerNode()
        let synth4node = AVAudioPlayerNode()
        let synth5node = AVAudioPlayerNode()
        let synth6node = AVAudioPlayerNode()
        let synth7node = AVAudioPlayerNode()
        let synth8node = AVAudioPlayerNode()
        
        synthsnodes = [synth1node, synth2node, synth3node, synth4node, synth5node, synth6node, synth7node, synth8node]
        
        channels = [channel1, channel2, channel3, channel4, channel5, channel6, channel7, channel8, channel9, channel10]
        synths = [synth1, synth2, synth3, synth4, synth5, synth6, synth7, synth8]
        
        
        let sliders = [volumeMeter, gainMeter, lowpassMeter, highpassMeter, reverbMeter, duckerMeter, pitchMeter]
        let sliderLBLs = [volumeLBL, gainLBL, lowpassLBL, highpassLBL, reverbLBL, duckerLBL, pitchLBL]
        
        count = 0;
        let sliderDimensions = Int(screen.width)/(sliders.count*2+1);
        
        for i in sliders{
            count += 1;
            i.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2));
            i.frame = CGRect(x:2*sliderDimensions*count-sliderDimensions,y:Int(Double(screen.height)*0.75),width:sliderDimensions,height:Int(screen.height/4-screen.height/20));
            view.addSubview(i);
            sliderLBLs[count-1].frame = CGRect(x:2*sliderDimensions*count-sliderDimensions,y:Int(Double(screen.height)*0.75)-Int(screen.height/25),width:sliderDimensions,height:Int(screen.height/40));
            sliderLBLs[count-1].backgroundColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 180.0/255.0, alpha: 1.0);
            sliderLBLs[count-1].textColor = .white;
            sliderLBLs[count-1].font = sliderLBLs[count-1].font.withSize(sliderLBLs[count-1].frame.height * 1/2);
            sliderLBLs[count-1].adjustsFontSizeToFitWidth = true;
            sliderLBLs[count-1].textAlignment = .center;
            view.addSubview(sliderLBLs[count-1]);
        }
        
        volumeLBL.text = "Volume"
        gainLBL.text = "Gain"
        lowpassLBL.text = "Lowpass"
        highpassLBL.text = "Highpass"
        reverbLBL.text = "Reverb"
        duckerLBL.text = "Ducker"
        pitchLBL.text = "Pitch"
        
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
        btns = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn10];
        var btn_images = [#imageLiteral(resourceName: "red_btn"),#imageLiteral(resourceName: "orange_btn"),#imageLiteral(resourceName: "yellow_btn"),#imageLiteral(resourceName: "green_btn"),#imageLiteral(resourceName: "blue_btn"),#imageLiteral(resourceName: "purple_btn"),#imageLiteral(resourceName: "pink_btn"),#imageLiteral(resourceName: "cyan_btn")];
        var btn_assignments = [7, 7, 7, 7, 7, 7, 7, 7, 7, 7];
        
        for i in 0..<btns.count {
            defineBTN(btns[i], btn_frames[i], btn_images[btn_assignments[i]]);
            btns[i].titleLabel?.adjustsFontSizeToFitWidth = true;
        }
        
        lblTitle.frame = CGRect(x: screen.width/5, y: screen.height/24, width: screen.width/5*3, height: screen.height/12);
        lblTitle.backgroundColor = .black;
        lblTitle.font = lblTitle.font.withSize(lblTitle.frame.height * 1/2)
        lblTitle.textAlignment = .center;
        lblTitle.text = "AUXboard";
        lblTitle.textColor = .white;
        view.addSubview(lblTitle);
        
        btnPresets.frame = CGRect(x: Int(sliders[0].frame.minX), y: Int(btn6Frame.maxY+(btnDimensions/3)), width: Int(screen.width/9), height: 30);
        btnPresets.setTitle("Loop Presets", for: .normal);
        btnPresets.setTitleColor(.blue, for: .normal)
        btnPresets.contentHorizontalAlignment = .left;
        btnPresets.titleLabel?.adjustsFontSizeToFitWidth = true;
        btnPresets.addTarget(self, action: #selector(Board.presets(button: )), for: .touchUpInside);
        view.addSubview(btnPresets);
        
        btnSynthPresets.frame = CGRect(x: Int(sliders[sliders.count-1].frame.maxX-screen.width/9), y: Int(btn6Frame.maxY+(btnDimensions/3)), width: Int(screen.width/9), height: 30);
        btnSynthPresets.setTitle("Synth Presets", for: .normal);
        btnSynthPresets.setTitleColor(.blue, for: .normal)
        btnSynthPresets.contentHorizontalAlignment = .right;
        btnSynthPresets.titleLabel?.adjustsFontSizeToFitWidth = true;
        btnSynthPresets.addTarget(self, action: #selector(Board.synthPresets(button: )), for: .touchUpInside);
        view.addSubview(btnSynthPresets);
        
        scroll_view.frame = CGRect(x:0,y: Int(btnPresets.frame.maxY+(btnDimensions/3)), width:Int(screen.width), height: Int(screen.height-(screen.height/2+50)));
        view_scroll.frame = CGRect(x:0,y: 0, width:Int(screen.width), height: Int(screen.height+1000));
        scroll_view.contentSize = CGSize(width: view_scroll.frame.width, height: view_scroll.frame.height);
        scroll_view2.frame = CGRect(x:0,y: Int(btnPresets.frame.maxY+(btnDimensions/3)), width:Int(screen.width), height: Int(screen.height-(screen.height/2+50)));
        view_scroll2.frame = CGRect(x:0,y: 0, width:Int(screen.width), height: Int(screen.height+1000));
        scroll_view2.contentSize = CGSize(width: view_scroll2.frame.width, height: view_scroll2.frame.height)
        view_scroll3.frame = CGRect(x:0,y: 0, width:Int(screen.width), height: Int(screen.height+1000));
        scroll_view3.frame = CGRect(x:0,y: Int(btnPresets.frame.maxY+(btnDimensions/3)), width:Int(screen.width), height: Int(screen.height-(screen.height/2+50)));
        scroll_view3.contentSize = CGSize(width: view_scroll3.frame.width, height: view_scroll3.frame.height);
        
        view.addSubview(scroll_view);
        scroll_view.addSubview(view_scroll);
        view.addSubview(scroll_view2);
        scroll_view2.addSubview(view_scroll2);
        view.addSubview(scroll_view3);
        scroll_view3.addSubview(view_scroll3);
        scroll_view.isHidden = true;
        scroll_view2.isHidden = true;
        scroll_view3.isHidden = true;
        
        let color_step = 1.0/Double(reverse_placing);
        
        btnSavePreset.frame = CGRect(x: 20, y: 0
            , width: Int(screen.width-40), height: 50);
        btnSavePreset.backgroundColor = UIColor(red: 0.0/255.0, green: 160.0/255.0, blue: 180.0/255.0, alpha: 1.0);
        btnSavePreset.setTitle("Save Current Loops As New Preset", for: UIControlState(rawValue: 0));
        btnSavePreset.setTitleColor(.black, for: .normal);
        btnSavePreset.titleLabel?.adjustsFontSizeToFitWidth = true;
        btnSavePreset.addTarget(self, action: #selector(Board.savePreset(button:)), for: .touchUpInside);
        view_scroll.addSubview(btnSavePreset);

        drums_synths.frame = CGRect(x: Int(screen.width/3), y: Int(btnPresets.frame.maxY+(btnDimensions/3)-40)
            , width: Int(screen.width/3), height: 30);
        drums_synths.insertSegment(withTitle: "Melody", at: 0, animated: false);
        drums_synths.insertSegment(withTitle: "Rhythym", at: 1, animated: false);
        drums_synths.selectedSegmentIndex = 0;
        drums_synths.addTarget(self, action: #selector(Board.switchSynth(button:)), for: UIControlEvents.valueChanged);
        view.addSubview(drums_synths);
        drums_synths.isHidden = true;
        
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
            button.addTarget(self, action: #selector(Board.pickPreset(button: )), for: .touchUpInside);
            view_scroll.addSubview(button);
        }
        
        let color_step2 = 1.0/Double(reverse_placing2);
        count2 = 0.0
        count3 = 0.0
        for i in samples {
            count2 += 1;
            count3 += 1;
            if count2 > Double(reverse_placing2){
                count3 -= 2;
            }
            let frame2 = CGRect(x: 20, y: 20+Int(40*count2)
                , width: Int(screen.width-40), height: 30);
            let button2 = UIButton();
            button2.frame = frame2;
            button2.backgroundColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 160.0/255.0, alpha: CGFloat(count3*color_step2))
            button2.setTitle(i, for: UIControlState(rawValue: 0));
            view_scroll2.addSubview(button2);
        }
        let color_step3 = 1.0/Double(reverse_placing3);
        count2 = 0.0
        count3 = 0.0
        for i in samples2 {
            count2 += 1;
            count3 += 1;
            if count2 > Double(reverse_placing3){
                count3 -= 2;
            }
            let frame3 = CGRect(x: 20, y: 20+Int(40*count2)
                , width: Int(screen.width-40), height: 30);
            let button3 = UIButton();
            button3.frame = frame3;
            button3.backgroundColor = UIColor(red: 0.0/255.0, green: 200.0/255.0, blue: 160.0/255.0, alpha: CGFloat(count3*color_step3))
            button3.setTitle(i, for: UIControlState(rawValue: 0));
            view_scroll3.addSubview(button3);
        }
        
        let play_width = Int(screen.width/5)
        btn_play.frame = CGRect(x:Int(screen.width/2)-play_width/2, y:Int(screen.height/2), width:play_width, height:play_width);
        btn_play.imageView!.contentMode = .scaleAspectFill;
        btn_play.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill;
        btn_play.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        btn_play.setImage(#imageLiteral(resourceName: "btnPlay"), for: .normal);
        btn_play.addTarget(self, action: #selector(Board.playACT(button: )), for: .touchUpInside);
        view.addSubview(btn_play);
        
        btn_record.frame = CGRect(x:Int(screen.width/2)-(play_width/2)*2,y:Int(screen.height/2),width:play_width/2,height:play_width/2);
        btn_record.center.y = btn_play.center.y;
        btn_record.imageView!.contentMode = .scaleAspectFill;
        btn_record.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill;
        btn_record.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        btn_record.setImage(#imageLiteral(resourceName: "btnPlay"), for: .normal);
        btn_record.addTarget(self, action: #selector(Board.recordACT(button: )), for: .touchUpInside);
        view.addSubview(btn_record);
        
        btn_edit.frame = CGRect(x:Int(screen.width/2)+(play_width/2),y:Int(screen.height/2),width:play_width/2,height:play_width/2);
        btn_edit.center.y = btn_play.center.y;
        btn_edit.imageView!.contentMode = .scaleAspectFill;
        btn_edit.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill;
        btn_edit.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
        btn_edit.setImage(#imageLiteral(resourceName: "btnPlay"), for: .normal);
        btn_edit.addTarget(self, action: #selector(Board.editACT(button: )), for: .touchUpInside);
        view.addSubview(btn_edit);
        
        editLBL.frame = CGRect(x:0,y:0, width: volumeLBL.frame.width, height: volumeLBL.frame.height);
        editLBL.center.x = btn_edit.center.x;
        editLBL.center.y = btn_edit.center.y + (btn_edit.frame.height/2+btn_edit.frame.height/3);
        editLBL.font = editLBL.font.withSize(editLBL.frame.height * 1/2);
        editLBL.adjustsFontSizeToFitWidth = true;
        editLBL.textAlignment = .center;
        editLBL.text = "Edit";
        editLBL.textColor = .red;
        view.addSubview(editLBL);
        
        recordLBL.frame = CGRect(x:0,y:0, width: volumeLBL.frame.width, height: volumeLBL.frame.height);
        recordLBL.center.x = btn_record.center.x;
        recordLBL.center.y = btn_record.center.y + (btn_record.frame.height/2+btn_record.frame.height/3);
        recordLBL.font = recordLBL.font.withSize(recordLBL.frame.height * 1/2);
        recordLBL.adjustsFontSizeToFitWidth = true;
        recordLBL.textAlignment = .center;
        recordLBL.text = "Record";
        recordLBL.textColor = .red;
        view.addSubview(recordLBL);
        
        playLBL.frame = CGRect(x:0,y:0, width: volumeLBL.frame.width, height: volumeLBL.frame.height);
        playLBL.center.x = btn_play.center.x;
        playLBL.center.y = btn_play.center.y + (btn_play.frame.height/2);
        playLBL.adjustsFontSizeToFitWidth = true;
        playLBL.font = playLBL.font.withSize(playLBL.frame.height * 1/2)
        playLBL.textAlignment = .center;
        playLBL.text = "Play";
        playLBL.textColor = .red;
        view.addSubview(playLBL);
        
        loopProgress.frame = CGRect(x:0,y:0,width:btnSynthPresets.frame.minX-btnPresets.frame.maxX-btnPresets.frame.width,height:btnSynthPresets.frame.height);
        loopProgress.center.x = btn_play.center.x;
        loopProgress.center.y = (btnPresets.frame.minY+btn7.frame.maxY)/2;
        view.addSubview(loopProgress)
        
        loops_synths.frame = CGRect(x: Int(screen.width/3), y: Int(loopProgress.frame.maxY+(btnDimensions/3)-40)
            , width: Int(screen.width/3), height: 30);
        loops_synths.insertSegment(withTitle: "Loop", at: 0, animated: false);
        loops_synths.insertSegment(withTitle: "Synth", at: 1, animated: false);
        loops_synths.addTarget(self, action: #selector(Board.switchMode(button:)), for: UIControlEvents.valueChanged);
        view.addSubview(loops_synths);
        loops_synths.isHidden = false;
        
        
    }
}

