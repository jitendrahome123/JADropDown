//
//  JADropDown.swift

//
//  Created by Agarwal, on 5/25/18.
//  Copyright © 2018 Agarwal. All rights reserved.
//

import UIKit
/************************************
 ********  JADropDown ENUM   ********
 ************************************/
public enum EnumJADropDownSelectionType : Int {
    case noSelection = 0,singleSelection,multipleSelection
}

public enum imagePosition: Int {
    case left = 0,right,noPosition
}

/************************************
 *****  JADropDown Control Protocol   *****
 ************************************/
public protocol JADropDownDelegate: class {
    func didReceivedJADropDownSeletedItems(items : [AnyObject],index:Int)
    func didReceivedJADropDownSingleSeletedtems(items : [String: AnyObject],index:Int)
}
public class JADropDown: UIView, UITableViewDelegate, UITableViewDataSource {
    var viewBGTableView =  UIView()
    var displayData: [AnyObject]?
    var bgButton: UIButton!
    var delegate: JADropDownDelegate?
    var selectionType:EnumJADropDownSelectionType!
    public var indexValue:Int?
    public var xPadding: CGFloat = 0.0
    public var imageType = ImageType()
    public var fontType = TitleFont()
    public var selectColorBG =  UIColor()
    public var imgPositionType:imagePosition!
    public  var selectionBold = BoldSelection()
    public var width: CGFloat = isiPad() ? 250 : 180
    public var height: CGFloat = isiPad() ? 250 : 160
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    // initialization tableView
    let tableViewCustom: UITableView = {
        var tableViewCustom = UITableView()
        tableViewCustom.frame =  CGRect(x: 0, y: 0, width: isiPad() ? 300 : 200, height: isiPad() ? 250 : 160)
        tableViewCustom.backgroundColor = colorClear
        tableViewCustom.separatorStyle = .none
        tableViewCustom.showsHorizontalScrollIndicator = true;
        tableViewCustom.showsVerticalScrollIndicator = true;
        tableViewCustom.isScrollEnabled = true
        tableViewCustom.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableViewCustom.estimatedRowHeight = 35.0
        tableViewCustom.rowHeight = UITableViewAutomaticDimension
        return tableViewCustom
        
    }()
    
    
    // MARK:- Set Image
    public func setImage(imgeType: UIImage) {
        self.imageType = ImageType(selectionImage: imgeType)
    }
    
    // MARK:- SET SELCTION BOLD
    public func setSelectionBold(isBold:Bool, size: CGFloat) {
        self.selectionBold = BoldSelection(isBold: isBold, fontSize: size)
    }
    // MARK:- Set Background Color
    public func setBackgroundColor(color backgroundColor: UIColor){
        
        colorTableViewBG = backgroundColor
        bgColor = colorTableViewBG
    }
    public var bgColor: UIColor = colorTableViewBG {
        didSet {
            self.tableViewCustom.backgroundColor = colorTableViewBG
        }
    }
    // MARK:- Title Color
    public func setTitleColor(color: UIColor) {
        colorDefultTitleColor = color
    }
    
    // MARK:- Set Font
    public func setFont(fontFamily: String ,  size:CGFloat, property:EnumFontProperty) {
        self.fontType = TitleFont(fontName: fontFamily, fontSize: Int(size), property: EnumFontProperty(rawValue: property.rawValue))
        
    }
    // MARK:- Set Width
    public var setWidth: CGFloat = 0.0 {
        didSet {
            self.width = setWidth
            self.tableViewCustom.frame.size.width = self.width
        }
    }
    // MARK:- Set Height
    public var setHeight: CGFloat = 0.0 {
        didSet {
            self.height = setHeight
            self.tableViewCustom.frame.size.height = self.height
        }
    }
    
    // initialization  EDSDrop DOWN VIEW
    public init(frame: CGRect?,xPosition: CGFloat, yPosition: CGFloat, inView:UIView, data:DataItems,selectionType:EnumJADropDownSelectionType, imagePosition:imagePosition, delegate:JADropDownDelegate){
        
        var aFrame: CGRect!
        if let _ = frame {
            aFrame = frame
        }
        else{
            aFrame =  CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        super.init(frame: aFrame!)
        
        if data.arrayData.count > 0 {
            self.removeFromSuperview()
            xPadding = 5.0
            self.delegate = delegate
            self.imgPositionType = imagePosition
            
            self.frame =  inView.frame
            self.displayData =  data.arrayData as [AnyObject]
            self.selectionType = selectionType
            
            print(self.width)
            if let _ = frame{
                self.viewBGTableView.frame = CGRect(x: frame!.origin.x + xPadding, y: yPosition + frame!.size.height + 25 , width:self.width + 20, height: self.height)
            }else{
                self.viewBGTableView.frame = CGRect(x: xPosition, y: yPosition, width: self.width, height: self.height)
            }
            self.viewBGTableView.layer.cornerRadius = isiPad() ?  8.0 :  6.0
            self.viewBGTableView.backgroundColor = colorViewBGForTableView
            self.backgroundColor =  colorClear
            bgButton = UIButton()
            bgButton.frame = self.frame
            bgButton.backgroundColor = colorClear
            bgButton.setTitle("", for: .normal)
            bgButton.addTarget(self, action: #selector(JADropDown.tapDismissDropDown), for:.touchUpInside)
            self.addSubview(bgButton)
            self.cellIdentifier()
            self.viewBGTableView.addSubview(tableViewCustom)
            self.addSubview(viewBGTableView)
        }
        
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
/***************************************************
 ********  EDSDropDown USER DEFINE FUNCTION   ********
 ***********************************************/
 extension JADropDown {
    // set tableView cellIdentifier
    func cellIdentifier() {
        let podBundle = Bundle(for: JADropDown.self)
        tableViewCustom.register(UINib(nibName:"JADropDownCell", bundle:podBundle), forCellReuseIdentifier:"JADropDownCell")
        tableViewCustom.delegate = self
        tableViewCustom.dataSource = self
        tableViewCustom.backgroundColor = bgColor
        
    }
    // Update orginal array
    private func updateArrayWith(withIndex index:Int, data:[String: AnyObject]){
        self.displayData?.remove(at: index)
        self.displayData?.insert(data as AnyObject, at: index)
        self.reloadSingleRow(row: index, section: 0)  // section is 0 , There is no section till now
        self.delegate?.didReceivedJADropDownSingleSeletedtems(items:data, index: index)
        
    }
    // Reset the Orignal Array
    private func reSetArray(){
        var newDictFormat =  [String: AnyObject]()
        for (index, value) in (displayData?.enumerated())! {
            newDictFormat = value as! [String : AnyObject]
            if value["buttonToggleSelection"] as! Bool ==  true {
                newDictFormat["buttonToggleSelection"]  = false as AnyObject?
                self.updateArrayWith(withIndex: index, data: newDictFormat)
            }
        }
        
    }
    
    // RELOAD PARTICULAR ROW EDSDrop DOWN
    private func reloadSingleRow(row:Int, section:Int) {
        let indexPath = IndexPath(item:row, section:section)
        self.tableViewCustom.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK:- UITAPGESTURE  EDSDrop DOWN  REMOVE AND SET FILTER VALUE INRTO CUSTOM DELEGATE
    @objc func tapDismissDropDown(){
        self.removeFromSuperview()
        if let _ = indexValue{
            self.filterEDSDropDownSeletedItems(withSelectionType: self.selectionType, index: self.indexValue!)
        }
        else
        {
            delegate?.didReceivedJADropDownSeletedItems(items:[],index: -1)
        }
    }
    
    // MARK:- REMOVE THE EDSDrop DOWN WITH FILTTER
    private func removeDropDownView(){
        self.filterEDSDropDownSeletedItems(withSelectionType: self.selectionType, index: self.indexValue!)
        self.removeFromSuperview()
    }
    
    // MARK:-  FILTER THE SELETED VALUE IN EDSDropDOWN AND  SET FILTER VALUE INRTO CUSTOM DELEGATE
    private func filterEDSDropDownSeletedItems(withSelectionType selectionTypeValue:EnumJADropDownSelectionType, index:Int?) {
        if selectionTypeValue == .noSelection{
            var filteredArray = [AnyObject]()
            let dict = self.displayData![index!] as! [String: AnyObject]
            filteredArray.append(dict as AnyObject)
            self.delegate?.didReceivedJADropDownSeletedItems(items:safeArrayDataWith(forArrayData: filteredArray), index: index!)
        }
        else{
            let predicate =  NSPredicate(format: "buttonToggleSelection == %@", NSNumber(value: true))
            let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate])
            let filteredArray = self.displayData?.filter { compoundPredicate.evaluate(with: $0) }
            self.delegate?.didReceivedJADropDownSeletedItems(items: safeArrayDataWith(forArrayData: filteredArray), index: index!)
        }
    }
    
    /***************************************************
     ******** EDSDropDown ACTION ********
     ***********************************************/
    // MARK:- checkBox Button Handle
    public func updateCheackBoxWith(withSelectionType selectionTypeValue:EnumJADropDownSelectionType, index:Int, dataScource:AnyObject){
        var newDictFormat = dataScource as! [String: AnyObject]
        self.selectionType = selectionTypeValue
        self.indexValue = index
        switch selectionType.rawValue {
        case 0:
            self.removeDropDownView()
        case 1,2:
            
            if selectionTypeValue == .singleSelection {
                self.reSetArray()
            }
            if newDictFormat["buttonToggleSelection"] as! Bool ==  true {
                newDictFormat["buttonToggleSelection"]  = false as AnyObject?
                
            }
            else if newDictFormat["buttonToggleSelection"] as! Bool ==  false {
                newDictFormat["buttonToggleSelection"] = true as AnyObject?
                
            }
            self.updateArrayWith(withIndex: index, data: newDictFormat)
            
        default:
            break
        }
    }
}
/***************************************************
 ******** TABLE VIEW DELEGATE AND DATA SOURCE  ********
 ***********************************************/
public extension JADropDown {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JADropDownCell.self), for: indexPath) as! JADropDownCell
        cell .selectionType = selectionType
        cell.imagePosition = imgPositionType
        cell.imageType =  self.imageType
        cell .imgCheckBoxLeft.tag = indexPath.row
        cell .imgCheckBoxRight.tag = indexPath.row
        cell.fontType = self.fontType
        cell.selectionBold = self.selectionBold
        cell.titleColor =  colorDefultTitleColor
        cell .datasource = self.displayData?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataScource = self.displayData?[indexPath.row]
        self.updateCheackBoxWith(withSelectionType:selectionType, index: indexPath.row, dataScource: dataScource!)
        
    }
}



