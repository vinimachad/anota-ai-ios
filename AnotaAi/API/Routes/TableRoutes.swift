//
//  TableRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import FirebaseFirestore

protocol TableRoutesProtocol {
    typealias Failure = ((String) -> Void)?
    typealias Success = (() -> Void)?
    
    func createTable(request: Table, failure: Failure, success: Success)
    func tableData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
    func addPersonsInTable<T: Codable>(request: T, tableId: String, failure: ((String) -> Void)?, success: ((String) -> Void)?)
}

class TableRoutes {
    
    private let provider: ApiProtocol = Api()
}

extension TableRoutes: TableRoutesProtocol {
    
    func createTable(request: Table, failure: Failure, success: Success) {
        do {
            try provider.db.collection("tables").document(request.id).setData(from: request)
            success?()
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    func addPersonsInTable<T: Codable>(request: T, tableId: String, failure: ((String) -> Void)?, success: ((String) -> Void)?) {
        var ref: DocumentReference?
        do {
            ref = try provider.db.collection("tables").document(tableId).collection("persons").addDocument(from: request)
            success?(ref?.documentID ?? "")
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    func tableData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?) {
        provider.db.collection("tables").document(id).addSnapshotListener { snapshot, error in
            guard let document = snapshot else {
                failure?(error?.localizedDescription ?? "")
                return
            }
            guard let model = try? document.data(as: T.self) else {
                failure?("DECODER")
                return
            }
            
            success?(model)
        }
    }
}
