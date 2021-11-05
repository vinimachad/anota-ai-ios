//
//  APIEndpoint.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ApiProtocol {
    typealias Failure = ((String) -> Void)?
    typealias Success = (() -> Void)?
    
    var db: Firestore { get }
    
    func insertData<T: Codable>(_ path: String, id: String, data: T, failure: Failure, success: Success)
    func insertDataWithoutId<T: Codable>(_ path: String, data: T, failure: ((String) -> Void)?, success: ((String) -> Void)?)
    func getData<T: Codable>(_ path: String, id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
}

enum APIResultError: Swift.Error {
    case getData(String?)
    case insertDataWithout(String?)
}

class Api: ApiProtocol {
    
    // MARK: - Public properties
    
    var db = Firestore.firestore()
    
    // MARK: Private properties
    
    private var defaultJSONEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        return encoder
    }
    
    // MARK: - Post
    
    func insertData<T: Codable>(_ path: String, id: String, data: T, failure: Failure, success: Success) {
        do {
            try db.collection(path).document(id).setData(from: data)
            success?()
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    func insertDataWithoutId<T: Codable>(_ path: String, data: T, failure: ((String) -> Void)?, success: ((String) -> Void)?) {
        var ref: DocumentReference?
        
        do {
            ref = try db.collection(path).addDocument(from: data)
            success?(ref?.documentID ?? "")
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    
    // MARK: - Get
    
    func getData<T: Codable>(_ path: String, id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?) {
        
        db.collection(path).document(id).addSnapshotListener { snapshot, error in
            guard let document = snapshot else {
                failure?(error?.localizedDescription ?? "")
                return
            }
            guard let model = try? document.data(as: T.self) else { return }
            
            success?(model)
        }
    }
}
