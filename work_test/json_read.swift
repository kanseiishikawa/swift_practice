import Foundation

struct Start_Point:Codable {
    var X: Int
    var Y: Int
    
}

struct cross:Codable {
    var Start_Point: Start_Point
    var Width: Int
    var Height: Int
    var Area: Int
}

struct text_result: Codable {
    var Text: String
    var Pos: Start_Point
}

struct img_data :Codable {
    var cross: cross
    var text_area_rate: Float
    var text: [text_result]?
}

func getJSON() -> [img_data] {
    //let fileName = "img_test.json"
    let path = Bundle.main.path(forResource: "img_data", ofType: "json" )!
    // ファイルを読み込みモードで開く
    let file = FileHandle(forReadingAtPath: path )!
    let data = file.readDataToEndOfFile()
    let contentString = String(data: data, encoding: .utf8)!
    file.closeFile()
    let jsonData = contentString.data(using: .utf8)!
    var json = [img_data]()
    
    do {
        json = try! JSONDecoder().decode( [img_data].self, from: jsonData )
    }
    
    return json
}
