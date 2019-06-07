import UIKit

class CustomUICollectionViewCell: UICollectionViewCell {
    
    var textLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        textLabel = UILabel(frame: CGRect(x:1, y:2, width:frame.width-2, height:frame.height-4))
        textLabel?.text = "nil"
        textLabel?.backgroundColor = UIColor.white
        textLabel?.layer.borderColor = UIColor.blue.cgColor
        textLabel?.layer.borderWidth = 1
        textLabel?.layer.cornerRadius = 5
        textLabel?.isUserInteractionEnabled = true
        textLabel?.textAlignment = NSTextAlignment.center
        
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
    }
    
}
