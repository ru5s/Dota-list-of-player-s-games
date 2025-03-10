//
//  RoundDiagramm.swift
//  Dota Dairy
//
//  Created by Den on 12/03/24.
//

import SwiftUI

//struct RoundDiagramm: View {
//    var body: some View {
//        Canvas {context,size in
//
//        }
//    }
//}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
}

struct RoundDiagramm: View {
    var pieSliceData: PieSliceData
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90) + pieSliceData.endAngle,
                        clockwise: false)
                }
                .fill(pieSliceData.color)
                .overlay(
                    Circle()
                        .foregroundColor(pieSliceData.endAngle.degrees == 360 ? Color.ddYellowGraphic : Color.ddRedGraphic)
                        .frame(width: 15, height: 15)
                        .position(x: geometry.size.width / 2 + (geometry.size.width / 2 - 0.035 * geometry.size.width) * CGFloat(cos((pieSliceData.endAngle - Angle(degrees: 90)).radians)),
                                  y: geometry.size.height / 2 + (geometry.size.width / 2 - 0.035 * geometry.size.width) * CGFloat(sin((pieSliceData.endAngle - Angle(degrees: 90)).radians)))
                )
                VStack {
                    Circle()
                        .foregroundColor(pieSliceData.endAngle.degrees == 360 ? Color.ddYellowGraphic : Color.ddRedGraphic)
                        .frame(width: 15, height: 15)
                    
                    Spacer()
                }
                Circle()
                    .scaleEffect(0.85)
                    .foregroundColor(Color.ddBlue)
            }
            .background(Color.ddRedGraphic)
            .clipShape(Circle())
        }
        .frame(width: 200, height: 200, alignment: .center)
        .aspectRatio(1, contentMode: .fit)
    }
}
#Preview {
    RoundDiagramm(pieSliceData: PieSliceData(startAngle: .degrees(0), endAngle: .degrees(130), color: Color.ddYellowGraphic))
}
