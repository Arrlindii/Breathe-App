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
    let backgroundColor: Color
    
    var body: some View {
        BackgroundRing(ringWidth: ringWidth, color: backgroundColor)
        .overlay(ForgroundRingView(percentage: percentage, ringWidth: ringWidth), alignment: .center)
    }

}

struct BackgroundRing: View {
    let ringWidth: CGFloat
    var color: Color
    
    var body: some View {
        return Circle().strokeBorder(color, lineWidth: ringWidth)
    }
}


struct ForgroundRingView: View {
    var percentage: Double = 0.5
    let ringWidth: CGFloat

    var body: some View {
        let spectrum = Gradient(colors: [ Color.mintGreenColor, Color.darkMintColor])
        let conic = AngularGradient(gradient: spectrum, center: .center, angle: .radians(getEndAngle().radians))
        let ring = RingShape(startAngle: getStartAngle(), endAngle: getEndAngle(), ringWidth: ringWidth).fill(conic)
        let ringHead = RingHead(endAngle: getEndAngle(), ringWidth: ringWidth).fill(Color.darkMintColor)
        return ring.overlay(ringHead)
    }
    
    func getStartAngle() -> Angle {
        return Angle.radians(-.pi/2)
    }
    
    func getEndAngle() -> Angle {
        return Angle.radians(2*Double.pi*percentage - Double.pi/2)
    }
}

private struct RingHead: Shape {
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

private struct RingShape: Shape {
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

#if DEBUG
struct RingView_Previews : PreviewProvider {
    static var previews: some View {
        Color.black.overlay(
            HStack {
                ForgroundRingView(percentage: 1, ringWidth: 35.0)
                    .frame(maxWidth: 300, maxHeight: 300)
            }
        )
    }
}
#endif
