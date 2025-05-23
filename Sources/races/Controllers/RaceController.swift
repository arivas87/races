import Vapor
import Fluent

struct RaceController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let races = routes.grouped("races")
        races.get(use: index)
        races.post(use: create)
        races.group(":raceID") { race in
            race.get(use: read)
            race.put(use: update)
            race.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> [Race] {
        try await Race.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Race {
        let race = try req.content.decode(Race.self)
        try await race.save(on: req.db)
        return race
    }
    
    func read(req: Request) async throws -> Race {
        guard let race = try await Race.find(req.parameters.get("raceID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return race
    }
    
    func update(req: Request) async throws -> Race {
        let updatedRace = try req.content.decode(Race.self)
        guard let race = try await Race.find(req.parameters.get("raceID"), on: req.db) else {
            throw Abort(.notFound)
        }
        race.name = updatedRace.name
        race.details = updatedRace.details
        race.date = updatedRace.date
        race.latitude = updatedRace.latitude
        race.longitude = updatedRace.longitude
        try await race.save(on: req.db)
        return race
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let race = try await Race.find(req.parameters.get("raceID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await race.delete(on: req.db)
        return .noContent
    }
}
