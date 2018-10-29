//
//  ViewController.swift
//  JakeNathanson-Lab3
//
//  Created by Jake N on 9/27/18.
//  Copyright © 2018 JakeNathanson. All rights reserved.
//

import UIKit
import MapKit
import WebKit

struct globalhistory {
    static var array: [pointline]=[]
}


class ViewController: UIViewController {

    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            globalhistory.array=[]
            canvas.history=[]
            current1?.points=[]
            current1?.startCircle = CGPoint()
            current1?.endCircle = CGPoint()
            current1?.color = UIColor(red: 0, green: 0, blue: 0.2, alpha: 1)
            current1?.thick = 1.0
            current1?.shake = true
            canvas.currline = current1
            imagetest.image = nil
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        canvas = Board(frame: view.frame)
        view.addSubview(canvas)
        current1 = pointline()
        imagetest.image = nil
    

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var current = pointline()
    
    var current1: pointline?
    var canvas: Board!
    
    var points: [CGPoint]=[]
    var counter=0
    var history: [pointline]=[]
    
    
    
    @IBAction func blue(_ sender: Any) {
        current1?.color = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
        print("blue")
    }
    
    @IBAction func red(_ sender: Any) {
        current1?.color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
        print("red")
        
    }
    
    @IBAction func green(_ sender: Any) {
        current1?.color = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
    }
    
    
    
    @IBAction func black(_ sender: Any) {
        current1?.color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
    }
    
    
    
    @IBAction func orange(_ sender: Any) {
        current1?.color = UIColor(red: 1, green: 0.70, blue: 0, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
        
    }
    
    @IBAction func picture(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imagetest.image = image
        
        }
        globalhistory.array=[]
        canvas.history=[]
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
        
        
    }
    
    @IBOutlet weak var imagetest: UIImageView!
    
    
    
    @IBAction func eraser(_ sender: Any) {
        
        current1?.color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func clearCanvas(_ sender: Any) {
        globalhistory.array=[]
        canvas.history=[]
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        current1?.shake = false
        canvas.currline = current1
        imagetest.image = nil
    }
   
    @IBAction func undoLine(_ sender: Any) {
        var count = canvas.history.count
        if (count==1){
            count=count-1
        }
        if (count>1){
            count=count-1
        }
        //canvas.history.count-1
    canvas.history=Array(canvas.history.prefix(count))
    globalhistory.array=Array(canvas.history.prefix(count))
        current1?.done = false
        current1?.points=[]
        current1?.startCircle = CGPoint()
        current1?.endCircle = CGPoint()
        canvas.currline = current1
    }
    
  
    
    @IBOutlet weak var thicknessValue: UISlider!
    @IBAction func thickness(_ sender: Any) {
        let thickness=30.0*thicknessValue.value
        current1?.thick = Double(thickness)
        print(thickness)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        current1?.points=[]
        current1!.done = false
        current1!.points.append(touchPoint)
        current1!.startCircle = touchPoint
        canvas.currline = current1
        current1!.tagger = current1!.tagger+1
        

       // current1.currline?.points.append(touchPoint)
        //points.append(touchPoint)
        //print("point is \(touchPoint)")
        //print(current1?.points ?? 0)
        
        
 
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                let touchPoint = (touches.first)!.location(in: view) as CGPoint
                current1!.points.append(touchPoint)
                //print(current1!.points)
                canvas.currline = current1
                
                //current1?.path = (createQuadPath(points: (current1?.points)!))
                //print(current1?.points)
        
        
//                print("You moved to \(touchPoint)")
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                let touchPoint = (touches.first)!.location(in: view) as CGPoint
//                print("You ended at \(touchPoint)")
                current1?.points.append(touchPoint)
                current1!.endCircle = touchPoint
                current1!.done = true
                canvas.currline = current1


                //print(current.points)
                //current.path = (createQuadPath(points: current.points))
                //current.paths.append(createQuadPath(points: current.points))
                        //print(current.paths)
                //history.append(current)
        
                //globalhistory.array.append(current)
                //counter=counter+1
                //current.points=[]
//        for pointline in globalhistory.array{
//
//            print(pointline.color)
//            print(pointline.path)
//
//            //pointline.path.fill()
//
//        }
        
        
        //print(createQuadPath(points: points))
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

