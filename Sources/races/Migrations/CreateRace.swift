import Fluent

struct CreateRace: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("races")
            .id()
            .field("name", .string, .required)
            .field("details", .string, .required)
            .field("date", .date, .required)
            .field("latitude", .float, .required)
            .field("longitude", .float, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("races").delete()
    }
}
