//
//  Utility.swift
//  JADropDown
//
//  Created by Agarwal, JitendraKumar(AWF) on 5/15/18.
//  Copyright © 2018 Agarwal, JitendraKumar(AWF). All rights reserved.
//

import UIKit

class Utility: NSObject {
}

public enum EnumFontProperty : Int {
    case normal = 0,bold,italic
}
// Set Data properties
public struct DataItems {
    internal var arrayData =  [AnyObject]()
    
    internal init(pdata: [AnyObject]) {
        
        var dict = [String: AnyObject]()
        for index in 0..<pdata.count {
            dict = ["name":pdata[index] as AnyObject, "buttonToggleSelection": false as AnyObject]
            self.arrayData.append(dict as AnyObject)
        }
    }
}

//  Set the image properties
public struct ImageType {
    internal var selectionImage: UIImage?
}

//  Set a font properties
internal struct TitleFont {
    internal var fontName: String  = ""
    internal var fontSize: Int = 0
    internal var property: EnumFontProperty!
}

// Set Bold Selction

public struct BoldSelection {
    internal var isBold: Bool  = false
    internal var fontSize: CGFloat = 0.0
}
// MARK:- Identify Ipad
public func isiPad () -> Bool {
    
    if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
        return true
    }
    else {
        return false
    }
}
// MARK:-  This function return SafeData array.
func safeArrayDataWith<T>(forArrayData arrayData:[T]?)-> [T]{
    
    if let _ = arrayData{
        if arrayData!.count > 0 {
            return arrayData!
            
        }
        else{
            return []
        }
    }
    else{
        return []
    }
}


// MARK: Color
var colorTableViewBG = UIColor.groupTableViewBackground
let  colorViewBGForTableView =  UIColor.white
let colorClear = UIColor.clear
var colorDefultTitleColor = UIColor.black

// MARK:- DEFULT FONT
let defalutFont = "HelveticaNeue"
let defultFontSize = 14.0
