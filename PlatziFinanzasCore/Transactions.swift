import Foundation

public protocol transactions {
    var transName: String { get set }
    var transValue: Float { get set }
    var transDate: Date { get set }
    var transCategory: transactionCategory? { get }
    var transValid: Bool? { get }
    var transHandler: transactionHandler? { get }
}

public enum transactionIs {
    case gain(
        gainName: String,
        gainValue: Float,
        gainDate: Date,
        gainValid: Bool,
        gainType: gainCategory
    )
    
    case debit(
        debitName: String,
        debitValue: Float,
        debitDate: Date,
        debitValid: Bool,
        debitType: debitCategory
    )
}

public enum transactionExceptions : Error {
    case saldoNegativo
}

public enum transactionCategory: Int {
    case earn, expend
}

extension transactionCategory: Codable {  }

public class Transaction: Codable {
    
    public var fireBaseID: String?
    public var uuid = UUID()
    public var transName: String
    public var transValue: Float
    public var transDate: Date
    public var transCategory: transactionCategory?
    public var transDescription: String
    //public var transValid: Bool?
    //public var transHandler: transactionHandler?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case value
        case category
        case name
        case date
        case description
    }
    
    public init(transName: String, transValue: Float, transDate: Date, transCategory: transactionCategory, transDescription: String) {
        self.transName = transName
        self.transValue = transValue
        self.transDate = transDate
        self.transCategory = transCategory
        self.transDescription = transDescription
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uuid = try container.decode(UUID.self, forKey: .uuid)
        transName = try container.decode(String.self, forKey: .name)
        transValue = try container.decode(Float.self, forKey: .value)
        transDate = try container.decode(Date.self, forKey: .date)
        transCategory = try container.decode(transactionCategory.self, forKey: .category)
        transDescription = try container.decode(String.self, forKey: .description)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(transName, forKey: .name)
        try container.encode(transValue, forKey: .value)
        try container.encode(transDate, forKey: .date)
        try container.encode(transCategory, forKey: .category)
        try container.encode(transDescription, forKey: .description)
    }
    
    public func data() -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        
        guard let data = try? jsonEncoder.encode(self) else {
            return nil
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        return json
    }
}

extension Transaction: Hashable {
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    public var hashValue: Int {
        return uuid.hashValue
    }
}
