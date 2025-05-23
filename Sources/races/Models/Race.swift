import Fluent
import Vapor

final class Race: Model, Content, @unchecked Sendable {
    static let schema = "races"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "details")
    var details: String

    @Field(key: "date")
    var date: Date
    
    @Field(key: "latitude")
    var latitude: Float
    
    @Field(key: "longitude")
    var longitude: Float

    init() {}

    init(id: UUID? = nil, name: String, details: String, date: Date, latitude: Float, longitude: Float) {
        self.id = id
        self.name = name
        self.details = details
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
}
