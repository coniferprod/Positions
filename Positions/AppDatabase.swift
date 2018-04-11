import GRDB

struct AppDatabase {
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        // Connect to the database
        // See https://github.com/groue/GRDB.swift/#database-connections
        dbQueue = try DatabaseQueue(path: path)
        
        // Use DatabaseMigrator to define the database schema
        // See https://github.com/groue/GRDB.swift/#migrations
        try migrator.migrate(dbQueue)
        
        return dbQueue
    }
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// This migrator is exposed so that migrations can be tested.
    // See https://github.com/groue/GRDB.swift/#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("createPositions") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "position") { t in
                // An integer primary key auto-generates unique IDs
                t.column("id", .integer).primaryKey()
                
                t.column("latitude", .double).notNull()
                t.column("longitude", .double).notNull()
                t.column("altitude", .double).notNull()
                t.column("timestamp", .date).notNull()
                t.column("description", .text)
            }
        }
        
        return migrator
    }
}
