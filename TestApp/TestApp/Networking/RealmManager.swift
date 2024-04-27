//
//  RealmManager.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let realm: Realm
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to instantiate Realm: \(error)")
        }
    }
    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("Error saving object to Realm: \(error.localizedDescription)")
        }
    }
    func load<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
}
