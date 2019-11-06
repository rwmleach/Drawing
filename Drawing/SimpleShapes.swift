//
//  ContentView.swift
//  Drawing
//
//  Created by Ryan Leach on 11/5/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		
		return path
	}
}

struct Arc: InsettableShape {
	var startAngle: Angle
	var endAngle: Angle
	var clockwise: Bool
	var insetAmount: CGFloat = 0
	
	func path(in rect: CGRect) -> Path {
		let rotationAdjustment = Angle.degrees(90)
		let modifiedStart = startAngle - rotationAdjustment
		let modifiedEnd = endAngle - rotationAdjustment
		
		var path = Path()
		path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
		
		return path
	}
	
	func inset(by amount: CGFloat) -> some InsettableShape {
		var arc = self
		arc.insetAmount += amount
		return arc
	}
	
	
}

struct SimpleShapes: View {
    var body: some View {
		VStack {
			Circle()
				.strokeBorder(Color.purple, lineWidth: 40)
			Arc(startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
				.strokeBorder(Color.green, lineWidth: 10)
				.frame(width: 100, height: 100)
			HStack {
				Triangle()
				.stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
				.frame(width: 100, height: 100)
				Triangle()
				.stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
				.frame(width: 200, height: 200)
			}
		}
		
		
    }
}

struct SimpleShapes_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
