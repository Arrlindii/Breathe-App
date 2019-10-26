//
//  RingView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 20.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//
import SwiftUI

struct RingView: View {
    var percentage: Double = 0.5

    init(percentage: Double) {
        self.percentage = percentage
    }

    var body: some View {
        let color1 = Color.init(red: 56/255, green: 199/255, blue: 191/255)
        let color2 = Color.init(red: 47/255, green: 245/255, blue: 220/255)
        let spectrum = Gradient(colors: [ color1, color2])
        let conic = AngularGradient(gradient: spectrum, center: .center, angle: .radians(getEndAngle()))
        let ringShape = RingShape(percentage: percentage).fill(conic, style: FillStyle.init())
        let ringHead = RingHead(percentage: percentage).fill(color2)
        return ringShape.overlay(ringHead)
    }
    
    func getEndAngle() -> Double {
        return 2*Double.pi*percentage - Double.pi/2
    }
}

struct RingHead: Shape {
    var percentage: Double
    //TODO: Access this from outside
    private let ringWidth: CGFloat = 50.0
    
    //TODO: Change this completely
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = (min(rect.width, rect.height) - ringWidth)/2
        let center = CGPoint(x: rect.midX - ringWidth/2, y: rect.midY - ringWidth/2)
        
        let point = getRotationPoint(angle: getEndAngle(), radius: radius, center: center)
        
        let x = point.x
        let y = point.y
        let frame = CGRect(x: x, y: y, width: ringWidth, height: ringWidth)
        path.addRoundedRect(in: frame, cornerSize: frame.size)
        return path
     }
    
    func getRotationPoint(angle: Double, radius: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                       y: center.y + CGFloat(sin(angle)) * radius)
    }
     
    func getEndAngle() -> Double {
        return 2*Double.pi*percentage - Double.pi/2
    }
}

struct RingShape: Shape {
    var percentage: Double
    //TODO: Access this from outside
    private let ringWidth: CGFloat = 50.0

    var animatableData: Double {
        get {return percentage}
        set {percentage = newValue}
    }

    func getLinePoint(angle: Double, radius: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                       y: center.y + CGFloat(sin(angle)) * radius)
    }

    func path(in rect: CGRect) -> Path {
          var path = Path()
          let center = CGPoint(x: rect.midX, y: rect.midY)
          let radius = (min(rect.width, rect.height) - ringWidth)/2
        
         let startAngle = Angle.radians(-.pi/2)
         let endAngle = Angle.radians(2*Double.pi*percentage - Double.pi/2)
         path.addArc(center: center,
                   radius: radius,
                   startAngle: startAngle,
                   endAngle: endAngle, clockwise: false)
         return path.strokedPath(.init(lineWidth: ringWidth, lineCap: CGLineCap.round))
    }
    
    func getEndAngle() -> Double {
        return 2*Double.pi*percentage - Double.pi/2
    }
}


struct BackgroundCircle: View {
    var body: some View {
        let color = Color.init(red: 9/255, green: 25/255, blue: 23/255)
        return Circle().strokeBorder(color, lineWidth: 50)
    }
}
