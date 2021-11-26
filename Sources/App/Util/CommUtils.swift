
import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any]? {
        if let data = try? JSONEncoder().encode(self) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

public extension Int {
    func toString() -> String {
        return String(format: "%d",self)
    }
}

public extension UInt {
    func toString() -> String {
        return String(format: "%ld",self)
    }
}

public extension Double {
    func toString() -> String {
        return String(format: "%.6f",self)
    }
    
    func toString(f: Int) -> String {
        return String(format: "%.\(f)f",self)
    }
}

public extension Float {
    func toString() -> String {
        return String(format: "%.6f",self)
    }
    
    func toString(f: Int) -> String {
        return String(format: "%.\(f)f",self)
    }
}

public extension Data {
    func toString(encoding: String.Encoding) -> String? {
        //print("Data \(data.count) bytes")
        if self.count > 0 {
            return String(data: self, encoding: encoding)
        }
        return nil
    }
    
    func toDictionary() -> [String: Any]? {
        do {
            guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { return nil }
            guard let dic = json as? [String: Any] else { return nil }
            return dic
        }
    }
}

public extension NSDictionary {
    func toJSONString(encoding: String.Encoding) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
}

public extension Dictionary {
    func toJSONString(encoding: String.Encoding) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
    
    func getString(key: String) -> String {
        if let dic = self as? [String: Any] {
            if let v = dic[key] as? String {
                return v
            } else if let value = dic[key] {
                if !(value is NSNull) {
                    return String(describing: value)
                }
            }
        }
        return ""
    }

    func getInt(key: String) -> Int {
        if let dic = self as? [String: Any] {
            if let i = dic[key] as? Int {
                return i
            }
            if let i = dic[key] as? UInt {
                return Int(i)
            }
            if let v = dic[key] as? String, let i = Int(v) {
                return i
            }
        }
        return 0
    }
        
    func getFloat(key: String) -> Float {
        if let dic = self as? [String: Any] {
            if let i = dic[key] as? Int {
                return Float(i)
            }
            if let i = dic[key] as? UInt {
                return Float(i)
            }
            if let f = dic[key] as? Float {
                return f
            }
            if let f = dic[key] as? Double {
                return Float(f)
            }
            if let v = dic[key] as? String, let i = Int(v) {
                return Float(i)
            }
            if let v = dic[key] as? String, let f = Float(v) {
                return f
            }
        }
        return 0
    }
    
    func getDouble(key: String) -> Double {
        if let dic = self as? [String: Any] {
            if let i = dic[key] as? Int {
                return Double(i)
            }
            if let i = dic[key] as? UInt {
                return Double(i)
            }
            if let f = dic[key] as? Float {
                return Double(f)
            }
            if let f = dic[key] as? Double {
                return f
            }
            if let v = dic[key] as? String, let i = Int(v) {
                return Double(i)
            }
            if let v = dic[key] as? String, let f = Double(v) {
                return f
            }
        }
        return 0
    }
        
    func getBoolean(key: String) -> Bool {
        if let dic = self as? [String: Any] , let b = dic[key] as? Bool {
            return b
        }
        return false
    }
        
    func getDict(key: String) -> [String: Any] {
        if let dic = self as? [String: Any] {
            if let value = dic[key] as? [String: Any] {
                return value
            }
        }
        return [:]
    }
        
    func getJsonArray(key: String) -> [[String: Any]] {
        if let dic = self as? [String: Any] {
            if let value = dic[key] as? [[String: Any]] {
                return value
            }
        }
        return []
    }
        
    func getArray(key: String) -> [Any] {
        if let dic = self as? [String: Any] {
            if let value = dic[key] as? [Any] {
                return value
            }
        }
        return []
    }
}

public extension Array {
    func toJSONString(encoding: String.Encoding) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
}

public extension NSArray {
    func toJSONString(encoding: String.Encoding) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
}

public extension String {
    func toInt() -> Int {
        if let i = Int(self) {
            return i
        }
        if let i = UInt(self) {
            return Int(i)
        }
        return 0
    }
        
    func toFloat() -> Float {
        if let f = Float(self) {
            return f
        }
        if let f = Double(self) {
            return Float(f)
        }
        return 0
    }

    func toDouble() -> Double {
        if let f = Double(self) {
            return f
        }
        return 0
    }
    
    func toArray(encoding: String.Encoding) -> [[String:Any]]? {
        if let data = self.data(using: encoding) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toDictionary(encoding: String.Encoding) -> [String: Any]? {
        if let data = self.data(using: encoding) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[..<fromIndex])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[toIndex...])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

public class CommUtils {
    public static func isEmptyString(_ text: String?) -> Bool {
        return text == nil || (text?.isEmpty)!
    }
    
    public static func systemCountryCode() -> String {
        let languageCode = Locale.current.languageCode!
        let regionCode = Locale.current.regionCode!
        if regionCode.isEmpty {
            return languageCode
        }
        return String(format: "%@-%@", languageCode, regionCode)
    }
    
    public static func createDirectory(_ subDir: String) -> String {
        let rootPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        var filePathUrl = rootPath.appendingPathComponent("temp")!
        if !FileManager.default.fileExists(atPath: filePathUrl.path) {
            try? FileManager.default.createDirectory(atPath: filePathUrl.path, withIntermediateDirectories: true, attributes: nil)
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try? filePathUrl.setResourceValues(resourceValues)
        }
        filePathUrl = filePathUrl.appendingPathComponent(subDir)
        if !FileManager.default.fileExists(atPath: filePathUrl.path) {
            try? FileManager.default.createDirectory(atPath: filePathUrl.path, withIntermediateDirectories: true, attributes: nil)
        }
        return filePathUrl.path
    }

    public static func getFilePathFromURL(_ fileUrl: String?) -> String {
        let subDir = self.getSubDirFromURL(fileUrl)
        let filename = self.getFilenameFromURL(fileUrl)
        if filename.starts(with: "staticmap") {
            return String(format: "%@/%@.jpg", self.createDirectory(subDir), subDir)
        }
        return String(format: "%@/%@", self.createDirectory(subDir), self.urlDecode(filename))
    }
    
    public static func getFilePathFromURL(_ fileUrl: String?, subDir: String) -> String {
        let filename = self.getFilenameFromURL(fileUrl)
        if filename.starts(with: "staticmap") {
            return String(format: "%@/%@.jpg", self.createDirectory(subDir), subDir)
        }
        return String(format: "%@/%@", self.createDirectory(subDir), self.urlDecode(filename))
    }
    
    public static func getSubDirFromURL(_ fileUrl: String?) -> String {
        guard let urlString = fileUrl, let url = URL(string: urlString) else {
            if var array = fileUrl?.components(separatedBy: "/") {
                if array.count > 3 {
                    array.removeFirst()
                    array.removeFirst()
                    array.removeFirst()
                    var text = ""
                    for dir in array {
                        text = "\(text)\(CommUtils.isEmptyString(text) ? "" : "_")\(dir)"
                    }
                    return text
                }
            }
            return ""
        }
        var text = ""
        for dir in url.pathComponents {
            if dir != "/" {
                text = "\(text)\(CommUtils.isEmptyString(text) ? "" : "_")\(dir)"
            }
        }
        return text
    }
    
    public static func getFilenameFromURL(_ fileUrl: String?) -> String {
        guard let urlString = fileUrl, let url = URL(string: urlString) else {
            let array = fileUrl?.components(separatedBy: "/")
            guard let filename = array?.last else {
                return ""
            }
            return filename
        }
        return url.lastPathComponent
    }
    
    public static func urlEncode(_ text: String) -> String {
        return text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    public static func urlDecode(_ text: String) -> String {
        return text.removingPercentEncoding!
    }
}
