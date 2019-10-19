//
//  FlowerView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 19.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation
import SwiftUI

struct GradientCircle: View {
    var body: some View {
        let color1 = Color.init(red: 81/255, green: 204/255, blue: 159/255)
        let color2 = Color.init(red: 154/255, green: 255/255, blue: 248/255)
        let spectrum = Gradient(colors: [ color1, color2])
        let conic =
            LinearGradient(gradient: spectrum, startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 0.5, y: 1))
        return Circle().fill(conic, style: FillStyle.init())
    }
}

struct FlowerAnimatableView: AnimatableModifier {
    var sides: Double
    var size: CGFloat
    var scale: CGFloat

    var animatableData: AnimatablePair<Double, CGFloat> {
        get {return AnimatablePair(sides, scale)}
        set {
            sides = newValue.first
            scale = newValue.second
        }
    }
    
    private var rect: CGSize{
        return CGSize(width: size*scale, height: size*scale)
    }
    
    func body(content: Content) -> some View {
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        let numberOfSides = Int(sides) + extra
        
        return ZStack {
            ForEach(Array(0..<numberOfSides), id: \.self) { i in
                return GradientCircle()
                    .frame(width: self.circleWidth(), height: self.circleWidth())
                    .opacity(self.getOpacity(at: i))
                    .offset(x: self.getOffset(at: i).x, y: self.getOffset(at: i).y)
            }
        }
    }
    
    func circleWidth() -> CGFloat {
        return (rect.width + (1-scale)*rect.width)/2
    }
    
    func getOpacity(at i: Int) -> Double {
        let maxOpacity = 0.55
        var opacity = sides - Double(i)
        opacity = max(0, min(1, opacity))
        return opacity*maxOpacity
    }
    
    func radius() -> Double {
        return Double(min(rect.width, rect.height))/4.0
    }
    
    func getOffset(at side: Int) -> CGPoint {
        let points = self.getPetalCenteres()
        let centerPoint = points[side]
        return self.getOffset(centerPoint)
    }
    
    func getOffset(_ center: CGPoint) -> CGPoint {
        let r = radius()
        return CGPoint(x: Double(center.x) - r/2, y: Double(center.y) - r/2)
    }
    
    func getPetalCenteres() -> [CGPoint] {
        let h = radius()
        let center = CGPoint(x: h/2, y: h/2)
        
        var points: [CGPoint] = []
        
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) + Double(self.scale)) * (360/Double(sides))
            let angleInRad = angle*Double.pi/180
            
            let pt = CGPoint(x: center.x + CGFloat(cos(angleInRad) * h), y: center.y + CGFloat(sin(angleInRad)*h))
            points.append(pt)
        }
        return points
    }
}

#if DEBUG
struct FlowerContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().background(Color.black)
    }
}
#endif
