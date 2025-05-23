import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost",
                username: "vapor",
                password: "vapor",
                database: "races",
                tls: .disable
            )
        ),
        as: .psql
    )

    // register routes
    app.migrations.add(CreateRace())
    
    try app.register(collection: RaceController())
}
