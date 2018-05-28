//
// JADropDownCellswift

//
//  Created by Agarwal, JitendraKumar(AWF) on 3/22/18.
//  Copyright © 2018 Agarwal. All rights reserved.
//

import UIKit

 public class JADropDownCell: UITableViewCell {
    
    // MARK : DECLARATIONS
    @IBOutlet weak var imgCheckBoxRight: UIImageView!
    @IBOutlet weak var imgCheckBoxLeft: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgWidthConstRight: NSLayoutConstraint!
    @IBOutlet weak var imgWidthConstLeft: NSLayoutConstraint!
    public var seletedColor: UIColor?
    public var imageType: ImageType!
    public var selectionBold: BoldSelection!
    public var index:Int?
    public var selectionType:EnumJADropDownSelectionType!
    public var imagePosition: imagePosition!
    public var fontType: TitleFont!
    
    var didTapCheackBoxHandler: ((_ indexValue: Int, _ selectionType:EnumJADropDownSelectionType, _ dataScouce: AnyObject?) -> ())?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.backgroundColor = UIColor.clear
    }
  
    
    var datasource: AnyObject? {
        didSet {
            
            if self.datasource != nil{
                
                fontType.fontName == "" ?  self.setDefalutFont() : self.setCustomFont()
                switch (selectionType.rawValue){
                case 0:       // no selction
                    self.hideCheckBox()
                    
                case 1,2:
                    self.datasource!["buttonToggleSelection"] as! Bool ? (self.imagePosition.rawValue == 0 ? self.showCheckBoxLeft() : self.showCheckBoxRight()) : self.setCheckDeSeleted()
                    
                default: break
                    
                }
            }
            if let _ =  datasource!["name"] as? String {
                self.labelTitle.text =  datasource!["name"] as? String
            }
            else{
                self.labelTitle.text =  datasource! as? String
            }

        }
    }
    // Hide the image view
    private func hideCheckBox() {
        self.imgWidthConstLeft.constant = 0.0
        self.imgWidthConstRight.constant = 0.0
        self.setClearColorBG()
    }
    // Set the Image as Right position
    private func showCheckBoxRight() {
        self.imgWidthConstRight.constant = 23
        self.imgCheckBoxRight.layoutIfNeeded()
        self.imgCheckBoxRight.image = self.imageType.selectionImage
        if selectionBold.isBold {
            self.setBold()
        }
    }
    // Set the image as Left Position
    private func showCheckBoxLeft() {
        self.imgWidthConstLeft.constant = 23
        self.imgCheckBoxLeft.layoutIfNeeded()
        self.imgCheckBoxLeft.image = self.imageType.selectionImage
        if selectionBold.isBold {
            self.setBold()
        }
    }
    
    // Clear the image
    private func setCheckDeSeleted() {
        self.hideCheckBox()
        self.imgCheckBoxLeft.image = UIImage(named: "")
        self.imgCheckBoxRight.image = UIImage(named: "")
     }
    // Set background color
    private func setBackgroundColor(bgColor: UIColor){
        self.backgroundColor = bgColor
    }
    //  Set Clear background color
    private func setClearColorBG() {
        self.backgroundColor = UIColor.clear
    }
    // Set the Default font
    private func setDefalutFont() {
        self.labelTitle.font =   UIFont(name:defalutFont, size: CGFloat(defultFontSize))
    }
    // Set the Custom Font
    private func setCustomFont() {
     self.labelTitle.font =   UIFont(name:fontType.fontName, size: CGFloat(fontType.fontSize))
    
        self.setFontProperty(value: fontType.property.rawValue)
        print(self.fontType.property.rawValue)
        
    }
    
    // MARK: - Set The Font property
    private func setFontProperty(value:  Int){
        switch value {
        case 0:          // Normal Font
            self.labelTitle.font = UIFont.systemFont(ofSize: CGFloat(fontType.fontSize))
            
        case  1 :            // Bold
               self.labelTitle.font  = UIFont.boldSystemFont(ofSize: CGFloat(fontType.fontSize))
        case 2:              //italic
            self.labelTitle.font =   UIFont.italicSystemFont(ofSize: CGFloat(fontType.fontSize) )
     
        default: break
            
        }
        
    }
    
    // Set Bold
    private func setBold() {
     self.labelTitle.font  = UIFont.boldSystemFont(ofSize: CGFloat(selectionBold.fontSize))
    }
  
    internal var titleColor: UIColor = colorDefultTitleColor{
        didSet {
            self.labelTitle?.textColor = titleColor
        }
    }
    
    
}
//
//// MARK:- DEFINE EXTENSION
//extension UILabel {
//    func underline() {
//        if let textString = self.text {
//            let attributedString = NSMutableAttributedString(string: textString)
//           
//            attributedString.addAttribute(kCTUnderlineStyleAttributeName as NSAttributedStringKey, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
//            attributedText = attributedString
//        }
//    }
//}

