//
//  Board.swift
//  JakeNathanson-Lab3
//
//  Created by Jake N on 9/27/18.
//  Copyright © 2018 JakeNathanson. All rights reserved.
//

import UIKit

class Board: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
         Drawing code
    }
    */
    var history = globalhistory.array{
    didSet{
        
        for pointline in history {
        //print(history.count)
            if(pointline.shake==true)
                {
                backgroundColor = UIColor(red: 0, green: 0, blue: 0.0, alpha: 0.5)
               
            } else {
                
                backgroundColor = UIColor.clear
                
            }
            
            
        }
       
        
        }}
    
    
    //let history = globalhistory.array

    
    //var drawer = UIBezierPath()
    
    
    var currline:pointline?{
        didSet{
            //print (currline!.points)
            
            currline!.path = createQuadPath(points: (currline!.points))
            //print(currline!.tagger)
            //print(currline!.points.count)
            //var needDraw=Array(currline!.points[currline!.tagger ... currline!.points.count])
            //var needDrawPath=createQuadPath(points: (needDraw))
            //print(currline!.path)
            setNeedsDisplay()
      
            

        }
    }
 
    override func draw(_ rect: CGRect) {

        let path1 = UIBezierPath()
        let path2 = UIBezierPath()
        
        if(currline?.path != nil){
            
            //print(currline?.done)
            for pointline in history {
                if (pointline.done==true){
                    //print(pointline.tagger)
                    pointline.color.setStroke()
                    pointline.color.setFill()
                    
                    pointline.path.lineWidth = CGFloat((pointline.thick))
                    pointline.path.stroke()}
                let scircle = UIBezierPath()
                let ecircle = UIBezierPath()
                scircle.addArc(withCenter: (pointline.startCircle), radius: CGFloat((pointline.thick))/2.0, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
                scircle.fill()
                ecircle.addArc(withCenter: (pointline.endCircle), radius: CGFloat((pointline.thick))/2.0, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
                ecircle.fill()
                
                
                
                
            }
            
            currline?.color.setStroke()
            currline?.path.lineWidth=CGFloat((currline?.thick)!)
            currline?.path.stroke()
            
            //
            
            currline?.color.setFill()

            path1.addArc(withCenter: (currline?.startCircle)!, radius: CGFloat((currline?.thick)!)/2.0, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            path1.fill()
            path2.addArc(withCenter: (currline?.endCircle)!, radius: CGFloat((currline?.thick)!)/2.0, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            path2.fill()

            
            //history.append(currline!)
            
           // print(currline?.done)
            if (currline!.done==true){
                history.append(currline!)
                //print("done")
                //print(history.count)

            }

            }

        
        
        
        
        
    }
    
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        
        let x = ((second.x + first.x)/2.00);
        let y = ((second.y + first.y)/2.00);
        let midpoint=CGPoint(x: x, y: y)
        return midpoint
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
    
    
    
}
