//
//  ViewController.swift
//  Demo
//
// Created by Agarwal, on 5/25/18.
//   Copyright © 2018 Agarwal. All rights reserved.
//

import UIKit
import JADropDown
class ViewController: UIViewController, JADropDownDelegate {

    var arraryItems =  [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        arraryItems = ["scrollview", "tabbar","tableview","webview","list view","page view"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func actionButtonSelection(_ sender: UIButton) {
        if sender.tag == 101 {
            self.noSelectionPopup(sender: sender)
            
        }else if sender.tag == 102 {
            self.singleSelectionPopup(sender: sender)
        }else {
            self.multipleSelectionPopup(sender: sender)
        }
        
        
    }
    
    // MARK:- Selection Type
    
    func noSelectionPopup(sender:UIButton) {
        //    let dropDownView =    EDSDropDown.init(frame: sender.frame, xPosition: 0, yPosition:  (sender.frame.origin.y - sender.frame.size.height) - 8, inView: self.view, data:DataItems(pdata: self.arraryItems as [AnyObject]), selectionType: .noSelection, delegate: self)
        //       self.view.addSubview(dropDownView)
        print("sender.frame \(sender.frame)")
        
        let dropDownView =  JADropDown.init(frame: sender.frame, xPosition: 0, yPosition: 0, inView: self.view, data: DataItems(pdata: self.arraryItems as [AnyObject]), selectionType: .noSelection, imagePosition: .noPosition, delegate: self)
        self.view.addSubview(dropDownView)
        
        
    }
    func singleSelectionPopup(sender:UIButton) {
        let dropDownView =    JADropDown.init(frame: sender.frame, xPosition: 0, yPosition:  (sender.frame.origin.y - sender.frame.size.height), inView: self.view, data:DataItems(pdata: self.arraryItems as [AnyObject]), selectionType: .singleSelection,imagePosition:.left, delegate: self)
        
        dropDownView.setImage(imgeType: #imageLiteral(resourceName: "tick"))
        self.view.addSubview(dropDownView)
    }
    func multipleSelectionPopup(sender:UIButton) {
        let dropDownView =    JADropDown.init(frame: sender.frame, xPosition: 0, yPosition:  (sender.frame.origin.y - sender.frame.size.height), inView: self.view, data:DataItems(pdata: self.arraryItems as [AnyObject]), selectionType: .multipleSelection,imagePosition:.right, delegate: self)
        dropDownView.setImage(imgeType: #imageLiteral(resourceName: "tick"))
        dropDownView.setSelectionBold(isBold: true, size: 14) //
        self.view.addSubview(dropDownView)
    }
    
    
}
// MARK:- EDSDropDownDelegate Delegate
extension ViewController {
    
    func didReceivedJADropDownSeletedItems(items: [AnyObject], index: Int) {
        print("Index =\(index)" +  "Items Are \(items)")
    }
    
    func didReceivedJADropDownSingleSeletedtems(items: [String : AnyObject], index: Int) {
        print("Index =\(index)" +  "Items Are \(items)")
    }
    
}
