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
    typealias Success = ((String) -> Void)?
    
    var db: Firestore { get }
    
    func getData<T: Codable>(_ path: String, id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
    func getDatas<T: Codable>(_ path: String, failure: ((String) -> Void)?, success: (([T?]) -> Void)?)
    
    func insertData<T: Codable>(_ path: String, data: T, failure: Failure, success: Success)
    func updateData(_ path: String, docId: String, data: [String: Any], success: (() -> Void)?)
}

enum APIResultError: Swift.Error {
    case getData(String?)
    case insertDataWithout(String?)
}

class Api: ApiProtocol {
    
    // MARK: - Public properties
    
    var db = Firestore.firestore()
    
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
    
    func getDatas<T: Codable>(_ path: String, failure: ((String) -> Void)?, success: (([T?]) -> Void)?) {
        db.collection(path).addSnapshotListener { snapshot, error in
                guard let query = snapshot else {
                    failure?(error?.localizedDescription ?? "")
                    return
                }
                
                let models = query.documents.map { try? $0.data(as: T.self) }
                
                success?(models)
            }
    }
    
    // MARK: - Post
    
    func insertData<T: Codable>(_ path: String, data: T, failure: Failure, success: Success) {
        
        var ref: DocumentReference?
        do {
            ref = try db.collection(path).addDocument(from: data)
            success?(ref?.documentID ?? "")
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    // MARK: - Update
    
    func updateData(_ path: String, docId: String, data: [String: Any], success: (() -> Void)?) {
        db.collection(path).document(docId).updateData(data)
        success?()
    }
    
}
