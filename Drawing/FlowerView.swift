//
//  ContentView.swift
//  Drawing
//
//  Created by Ryan Leach on 11/5/19.
//  Copyright © 2019 Ryan Leach. All rights reserved.
//

import SwiftUI

struct Flower: Shape {
	// How much to move this petal away from the center
	var petalOffset: Double = -20
	
	// How wide to make each petal
	var petalWidth: Double = 100
	
	func path(in rect: CGRect) -> Path {
		// The path that will hold all petals
		var path = Path()
		
		// Count from 0 up to pi * 2, moving up pi / 8 each time
		for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
			//rotate the petal by the current value of our loop
			let rotation = CGAffineTransform(rotationAngle: number)
			
			// move the petal to be at the center of our view
			let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
			
			// create a path for this petal using our properties plus a fixed Y and height
			let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
			
			let rotatedPetal = originalPetal.applying(position)
			
			// add it to our main path
			path.addPath(rotatedPetal)
		}
		
		return path
	}
}

struct FlowerView: View {
	@State private var petalOffset = -20.0
	@State private var petalWidth = 100.0
	
    var body: some View {
		VStack {
			Flower(petalOffset: petalOffset, petalWidth: petalWidth)
				.fill(Color.red, style: FillStyle(eoFill: true))
//				.stroke(Color.red, lineWidth: 1)
			
			Text("Offset")
			Slider(value: $petalOffset, in: -40...40).padding([.horizontal, .bottom])
			
			Text("Width")
			Slider(value: $petalWidth, in: 0...100).padding(.horizontal)
		}
		
		
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
