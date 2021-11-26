import Fluent
import Vapor

func routes(_ app: Application) throws {
    //MARK - web view
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    //MARK: - api test
    let test = app.grouped("test")
    
    //http://127.0.0.1:8080/test/hello
    test.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    //http://127.0.0.1:8080/test/json
    test.get("json") { req -> [String: String] in
        return ["id": "1", "msg": "Hello", "item": "car"]
    }
    
    //http://127.0.0.1:8080/test/model
    test.get("model") { req -> String in
        return ["id": 1, "msg": "Hello", "item": "car"].toJSONString(encoding: .utf8)!
    }
    
    //http://127.0.0.1:8080/test/hank
    test.get(":path") { req -> String in
        if let path = req.parameters.get("path") {
            return "Hello, \(path)"
        }
        return "Hello, Nobody"
    }
    
    //http://127.0.0.1:8080/test/number?i=7&d=8
    test.get("number") { req -> String in
        do {
            let model = try req.query.decode(NumberModel.self)
            return "\(model.i) and \(model.d) is a great number"
        } catch {
            throw Abort(.internalServerError)
        }
    }
    
    //http://127.0.0.1:8080/test/demo
    test.get("demo") { req -> String in
        let model = DemoModel(ID: 1, Name: "hank", Items: ["cat","dog"])
        guard let json = model.toDictionary()?.toJSONString(encoding: .utf8) else {
            throw Abort(.badRequest)
        }
        return json
    }
    
    try app.register(collection: TodoController())
}

struct NumberModel: Codable {
    var i: Int
    var d: Double
}

struct DemoModel: Codable {
    var ID: Int?
    var Name: String?
    var Items: [String]?
}
