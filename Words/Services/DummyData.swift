//
//  DummyData.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import Foundation

enum DummyData {
    
    static func load<T: Decodable>(_ filename: String) -> T? {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
            print("Couldn't find \(filename).")
            return nil
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename)")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Couldn't parse \(filename) as \(T.self):\n\(error)")
            return nil
        }
    }
    
    static func available(_ filename: String) -> Bool {
        guard let _ = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
            print("Couldn't find \(filename).")
            return false
        }
        
        return true
    }
}
