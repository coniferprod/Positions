import Foundation

struct Position {
    var latitude: Double     // degrees
    var longitude: Double    // degrees
    var altitude: Double     // meters
    var timestamp: Int       // milliseconds since epoch
    var description: String? // freeform description
}
