//
//  AdvancePageControlView.swift
//  pika_speak
//
//  Created by Nghiêm Huy on 1/28/21.
//

import Foundation
import UIKit

public class AdvancedPageControlView: UIView{
    public var numberOfPages:Int {get {return drawer.numberOfPages} set(val){ drawer.numberOfPages = val }}

    public var drawer:AdvancedPageControlDraw = SlideDrawer()
    
    public func setCurrentItem(offset:CGFloat,width:CGFloat){
        self.drawer.currentItem = CGFloat(offset ) / CGFloat(width)
        setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        drawer.draw(rect)
    }
    
}
