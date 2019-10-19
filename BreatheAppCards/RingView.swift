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
        let conic = AngularGradient(gradient: spectrum, center: .center, angle: .degrees(-90))
        return RingShape(percentage: percentage).fill(conic, style: FillStyle.init())
    }
}

struct RingShape: Shape {
    private var percentage: Double

    init(percentage: Double) {
        self.percentage = percentage
    }

    var animatableData: Double {
        get {return percentage}
        set {percentage = newValue}
    }

    func getLinePoint(angle: Double, radius: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint(x: center.x + CGFloat(cos(angle)) * radius,
                       y: center.y + CGFloat(sin(angle)) * radius)
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        let innerRadius = radius / 1.3
        let outerRadius = innerRadius +
            (radius - innerRadius)
        let startAngle = Angle.radians(-.pi/2)
        let angle = getEndAngle()
        let endAngle = Angle.radians(angle)

        var path = Path()
        path.addArc(center: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        let linePoint = getLinePoint(angle: angle, radius: outerRadius, center: center)
        path.addLine(to: linePoint)
        path.addArc(center: center, radius: outerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.closeSubpath()
        return path
    }

    func getEndAngle() -> Double {
        return 2*Double.pi*percentage - Double.pi/2
    }
}



struct GradientCircle: View {
    var body: some View {
        let spectrum = Gradient(colors: [ .green, .blue, .green])
        let conic = AngularGradient(gradient: spectrum, center: .center, angle: .degrees(-90))
        return Circle().strokeBorder(conic, lineWidth: 50)
    }
}

struct BackgroundCircle: View {
    var body: some View {
        let color = Color.init(red: 9/255, green: 25/255, blue: 23/255)
        return Circle().strokeBorder(color, lineWidth: 50)
    }
}
