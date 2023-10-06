import Foundation


struct Country: Codable {
    var name: String?
    var capital: String?
    var area: Double?
    var population: Int?
    var region: String?
    var subregion: String?
    var currencies: [Currencies]?
    var timezones: [String]?
    var flags: Flags?
    var latlng: [Double]?
    var continents: [String]?
}

//struct Currencies: Codable {
//    var currency: Currency?
//}
//
//struct Currency: Codable {
//    var name: String?
//    var symbol: String?
//}

struct Flags: Codable {
    var png: String?
    var svg: String?
}

struct Currencies: Codable {
    let eur: Eur?

    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
    }
}

struct Eur: Codable {
    let name, symbol: String?
}
