//
//  SlideDrawer.swift
//  pika_speak
//
//  Created by Nghiêm Huy on 1/28/21.
//

import Foundation
import UIKit
public class SlideDrawer:AdvancedPageControlDrawerParent, AdvancedPageControlDraw {
    
    public func draw(_ rect: CGRect) {
        drawIndicators(rect)
        drawCurrentItem(rect)
    }
    
    func drawIndicators(_ rect: CGRect) {
        for i in 0..<numberOfPages{
            let centeredYPosition = getCenteredYPosition(rect, dotSize: height)
            let y =  rect.origin.y + centeredYPosition
            let x = getCenteredXPosition(rect,itemPos: CGFloat(i), dotSize: width,space: space, numberOfPages: numberOfPages)
            drawItem(CGRect(x: x, y:  y, width: CGFloat(width ), height: CGFloat(height))
                , raduis:radius,color: dotsColor)
        }
    }
    
    fileprivate func drawCurrentItem(_ rect: CGRect) {
        let centeredYPosition = getCenteredYPosition(rect, dotSize: height)
        let y = rect.origin.y + centeredYPosition
        let x = getCenteredXPosition(rect, itemPos: currentItem, dotSize: width,space: space, numberOfPages: numberOfPages)
        drawItem(CGRect(x: x, y:  y , width: width , height: height )
            , raduis:radius,color: indicatorColor)
    }
}
