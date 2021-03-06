//
//  ViewController.swift
//  LionEventsExample
//
//  Created by wilden on 2015/6/5.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit
import LionEvents
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    var mFirstButtonListener:EventListener?
    let mButton:UIButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
    private func createMutilsEvents(){
        // if want to remove target listener handler
        mFirstButtonListener = mButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onButtonFirstHandler)
        mButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onButtonAlwaysHandler)
    }
    
    private func onButtonFirstHandler(){
        mButton.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aListener: mFirstButtonListener!)
    }
    
    private func onButtonAlwaysHandler(){
        println("no removeListener")
    }
    
    
    
    
    
    
    
    
    private func createUIKitEvent(){
        let _button:UIButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
        _button.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onButtonHandler)
        _button.addEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE, aHandler: onButtonHandler)
        _button.addEventListener(LNButtonEvents.TOUCH_DOWN, aHandler: onButtonHandler)
    }
    
    private func onButtonHandler(e:LNEvent){
        switch e.type {
        case LNButtonEvents.TOUCH_DOWN.rawValue:
            println("\(e.type)")
        case LNButtonEvents.TOUCH_UP_INSIDE.rawValue:
            println("\(e.type)")
        case LNButtonEvents.TOUCH_UP_OUTSIDE.rawValue:
            println("\(e.type)")
        default:
            break
        }
        let _dispatcher:EventDispatcher = e.target as! EventDispatcher
        let _btn:UIButton = e.currentTarget as! UIButton
        
        // remove Listener by EventType
        _btn.removeEventListener(LNButtonEvents.TOUCH_DOWN)
        _btn.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE)
        _btn.removeEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE)
        
        // or
        _btn.removeAllEventListener()
        
        //
        _btn.removeEventListener(nil)
    }
    
    
    var mModel:Model = Model()
    var mModelWillRemoveListener:EventListener?
    private func doWillRemoveEventListeners(){
        //mModel.addEventListener(Model.ADD, aHandler: onMondelWillRemoveHandler)
        mModelWillRemoveListener = mModel.addEventListener(Model.ADD, aHandler: onMondelWillRemoveHandler)
    }
    
    private func onMondelWillRemoveHandler(){
        mModel.removeEventListener(Model.ADD, aListener: mModelWillRemoveListener!)
    }
    
    
    
    
    
    private func createCustomEventObject(){
        let _model:Model = Model()
        _model.addEventListener(Model.ADD, aHandler: onModelChangeHandler)
        _model.addEventListener(Model.DEC, aHandler: onModelChangeHandler)
    }
    
    private func onModelChangeHandler(aEvent:LNEvent){
        let _target:Model = aEvent.target as! Model
        let _currentTarget:Model = aEvent.currentTarget as! Model
        println("\(aEvent.type),\(_target.index)")
        removeCustomEventObject(_target)
    }
    
    private func removeCustomEventObject(aModel:Model){
        aModel.removeEventListener(Model.DEC)
        aModel.removeEventListener(Model.ADD)
        // aModel.removeEventListener(nil) // remove model All Event Handler
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

