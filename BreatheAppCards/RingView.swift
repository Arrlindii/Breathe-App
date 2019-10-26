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
    let ringWidth: CGFloat
    
    var body: some View {
        BackgroundRing(ringWidth: ringWidth)
        .overlay(ForgroundRingView(percentage: percentage, ringWidth: ringWidth), alignment: .center)
    }

}

struct BackgroundRing: View {
    let ringWidth: CGFloat
    
    var body: some View {
        let color = Color.init(red: 9/255, green: 25/255, blue: 23/255)
        return Circle().strokeBorder(color, lineWidth: ringWidth)
    }
}


struct ForgroundRingView: View {
    var percentage: Double = 0.5
    let ringWidth: CGFloat

    var body: some View {
        let color1 = Color.init(red: 56/255, green: 199/255, blue: 191/255)
        let color2 = Color.init(red: 47/255, green: 245/255, blue: 220/255)
        let spectrum = Gradient(colors: [ color1, color2])
        let conic = AngularGradient(gradient: spectrum, center: .center, angle: .radians(getEndAngle().radians))
        let ring = RingShape(startAngle: getStartAngle(), endAngle: getEndAngle(), ringWidth: ringWidth).fill(conic)
        let ringHead = RingHead(endAngle: getEndAngle(), ringWidth: ringWidth).fill(color2)
        return ring.overlay(ringHead)
    }
    
    func getStartAngle() -> Angle {
        return Angle.radians(-.pi/2)
    }
    
    func getEndAngle() -> Angle {
        return Angle.radians(2*Double.pi*percentage - Double.pi/2)
    }
}

struct RingHead: Shape {
    var endAngle: Angle
    let ringWidth: CGFloat
    
    var animatableData: Double {
        get {return endAngle.radians}
        set {endAngle = Angle(radians: newValue)}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = (min(rect.width, rect.height) - ringWidth)/2
        let center = CGPoint(x: rect.midX - ringWidth/2, y: rect.midY - ringWidth/2)
        let point = getRotationPoint(angle: endAngle.radians, radius: radius, center: center)
        let frame = CGRect(x: point.x, y: point.y, width: ringWidth, height: ringWidth)
        path.addRoundedRect(in: frame, cornerSize: frame.size)
        return path
     }
    
    func getRotationPoint(angle: Double, radius: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                       y: center.y + CGFloat(sin(angle)) * radius)
    }
}

struct RingShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    let ringWidth: CGFloat

    var animatableData: Double {
        get {return endAngle.radians}
        set {endAngle = Angle(radians: newValue)}
    }

    func path(in rect: CGRect) -> Path {
          var path = Path()
          let center = CGPoint(x: rect.midX, y: rect.midY)
          let radius = (min(rect.width, rect.height) - ringWidth)/2
         path.addArc(center: center,
                   radius: radius,
                   startAngle: startAngle,
                   endAngle: endAngle, clockwise: false)
         return path.strokedPath(.init(lineWidth: ringWidth, lineCap: CGLineCap.round))
    }
}
