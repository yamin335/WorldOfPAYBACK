//
//  JsonLoader.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation

class JsonLoader {
    static let shared = JsonLoader()
    private init() {}
    
    func loadLocalJsonFile<T: Decodable>(filename: String, ext: String?) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: ext)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
