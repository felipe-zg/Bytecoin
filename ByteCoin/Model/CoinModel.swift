import Foundation

struct CoinModel: Decodable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
