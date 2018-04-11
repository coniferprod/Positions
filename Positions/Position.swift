import GRDB

class Position: Record {
    var id: Int64?
    var latitude: Double     // degrees
    var longitude: Double    // degrees
    var altitude: Double     // meters
    var timestamp: Date
    var description: String? // freeform description
    
    init(latitude: Double, longitude: Double, altitude: Double, timestamp: Date, description: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.timestamp = timestamp
        self.description = description
        
        super.init()
    }
    
    // MARK: - Record overrides
    
    /// The table name
    override class var databaseTableName: String {
        return "position"
    }
    
    /// Initialize from a database row
    required init(row: Row) {
        id = row["id"]
        latitude = row["latitude"]
        longitude = row["longitude"]
        altitude = row["altitude"]
        timestamp = row["timestamp"]
        description = row["description"]
        
        super.init(row: row)
    }
    
    /// The values persisted in the database
    override func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["latitude"] = latitude
        container["longitude"] = longitude
        container["altitude"] = altitude
        container["timestamp"] = timestamp
        container["description"] = description
    }
    
    /// When relevant, update record ID after a successful insertion
    override func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
