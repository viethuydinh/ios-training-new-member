//
//  AlertCustomView.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 22/07/2021.
//

import UIKit

class AlertCustomView: UIView, NibLoadableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private var callback:(()->Void)?
    
    convenience init(title: String,content: String,isHiddenCancel: Bool = false,callback:(()->Void)?){
        self.init()
        self.titleLabel.text = title
        self.contentLabel.text = content
        self.cancelButton.isHidden = isHiddenCancel
        self.callback = callback
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        connectNibUI()
        self.setupButton()
        self.contentView.corner(radius: 10.0)
    }
    
    func setupButton() {
        self.okButton.corner(radius: 4.0)
        self.okButton.setTitleColor(.white, for: .normal)
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.layer.borderColor = UIColor.frenchBlue.cgColor
        self.cancelButton.corner(radius: 4.0)
    }
    
    func show(superView: UIView) {
        self.showWithAnimation(animatedView: contentView, in: superView)
    }
    
    func hide() {
        self.hideWithAnimation(animatedView: contentView, callback: callback)
    }
    
    func hideCancel() {
        self.hideWithAnimation(animatedView: contentView, callback: nil)
    }
    
    @IBAction func onClickOk(_ sender: Any) {
        self.hide()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.hideCancel()
    }

}
