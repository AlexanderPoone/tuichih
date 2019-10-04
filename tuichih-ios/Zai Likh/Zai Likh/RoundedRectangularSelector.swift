//
//  RoundedRectangularSelector.swift
//  Zai Likh
//
//  Created by Victor Poon on 2/10/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//


import SwiftUI

struct RoundedRectangularSelector: View {
    
    let points = [        Segment(
        useWidth:  (1.00, 1.00, 1.00),
        xFactors:  (0.60, 0.40, 0.50),
        useHeight: (1.00, 1.00, 0.00),
        yFactors:  (0.05, 0.05, 0.00)
        ),
                          Segment(
                            useWidth:  (1.00, 1.00, 0.00),
                            xFactors:  (0.05, 0.00, 0.00),
                            useHeight: (1.00, 1.00, 1.00),
                            yFactors:  (0.20, 0.30, 0.25)
        ),
                          Segment(
                            useWidth:  (1.00, 1.00, 0.00),
                            xFactors:  (0.00, 0.05, 0.00),
                            useHeight: (1.00, 1.00, 1.00),
                            yFactors:  (0.70, 0.80, 0.75)
        ),
                          Segment(
                            useWidth:  (1.00, 1.00, 1.00),
                            xFactors:  (0.40, 0.60, 0.50),
                            useHeight: (1.00, 1.00, 1.00),
                            yFactors:  (0.95, 0.95, 1.00))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: xOffset + width * 0.95,
                        y: height * (0.20)
                    )
                )
                
                self.points.forEach {
                    path.addLine(
                        to: .init(
                            x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                            y: height * $0.useHeight.0 * $0.yFactors.0
                        )
                    )
                    
                    path.addQuadCurve(
                        to: .init(
                            x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                            y: height * $0.useHeight.1 * $0.yFactors.1
                        ),
                        control: .init(
                            x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                            y: height * $0.useHeight.2 * $0.yFactors.2
                        )
                    )
                }
            }
            .fill(Color(.sRGB, red: 0.643, green: 0.776, blue: 0.224, opacity: 0.5))
        }
    }
}

struct RoundedRectangularSelector_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangularSelector()
    }
}
