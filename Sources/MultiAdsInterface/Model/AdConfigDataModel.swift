import Foundation

public class AdConfigDataModel {
    public var tap: [String]?
    public  var failed: [String: String]?
    public var native: Int?
    public var banner: Int?
    public  var showAds: Bool
    public init(tap: [String]? = nil, native: Int? = nil, banner: Int? = nil, failed: [String: String]? = nil, showAds: Bool = false) {
        self.tap = tap
        self.native = native
        self.banner = banner
        self.failed = failed
        self.showAds = showAds
    }

    public static func copyWith(tap: [String]? = nil, native: Int? = nil, banner: Int? = nil, failed: [String: String]? = nil, showAds: Bool = false) -> AdConfigDataModel {
        return AdConfigDataModel(tap: tap, native: native, banner: banner, failed: failed, showAds: showAds)
    }

    public static func defaultConfig() -> AdConfigDataModel {
        return AdConfigDataModel(tap: ["1.0","1.1", "1.2"], native: 1, banner: 1, failed: ["1.0": "1.2"], showAds: false)
    }
    
    

    public static func fromJson(data: [String: Any]) -> AdConfigDataModel {
        print("Parsing ✅")
//        var tap:[String] = []
//        for value in data["tap"] as! [Any] {
//            tap.append(String(describing: value))
//        }
       
        return AdConfigDataModel(
            tap:  data["tap"] as? [String],
            native: (data["native"] as? Int) ?? 0,
            banner: (data["banner"] as? Int) ?? 0,
            failed: (data["failed"] as? [String: String]) ?? ["1.0":"2.0"],
            showAds: (data["showAds"] as? Bool) ?? false
        )
    }
    
    


    
}

extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
}

