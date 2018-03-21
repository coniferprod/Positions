//
//  PositionViewModel.swift
//  Positions
//
//  Created by Jere Käpyaho on 14.3.2018.
//  Copyright © 2018 Conifer Productions Oy. All rights reserved.
//

import Foundation

typealias CoordinateStringPair = (String, String)

class PositionViewModel {
    let position: Position
    
    // MARK: - Initialization
    
    init(withPosition position: Position) {
        self.position = position
    }
    
    // MARK: - String representation
    
    func decimalStringPairFromCoordinates() -> CoordinateStringPair {
        // Returns a named tuple with two formatted strings
        return (latitude: decimalStringFromDegrees(position.latitude), longitude: decimalStringFromDegrees(position.longitude))
    }
    
    private func decimalStringFromDegrees(_ degrees: Double) -> String {
        let degreesString = String(format: "%.5f", degrees)
        return "\(degreesString)\u{00B0}"
    }
    
    func stringFromAltitude() -> String {
        let altitudeString = String(format: "%.2f", position.altitude)
        return "\(altitudeString) m"
    }
}
