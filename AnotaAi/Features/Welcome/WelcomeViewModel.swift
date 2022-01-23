//
//  WelcomeViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import Foundation

protocol WelcomeProtocol: WelcomeViewModelProtocol {
    
    var onCreateTable: (() -> Void)? { get set }
    var onPutPassword: (() -> Void)? { get set }
    var onSuccessGetQRCodeValue: ((Table) -> Void)? { get set }
    var onFailureGetQRCodeValue: ((String) -> Void)? { get set }

    func didCreateTable(_ password: String?)
    func passwordValidation(_ password: String?)
    
    func startScan()
    func stopScan()
}

class WelcomeViewModel {
    
    // MARK: - Public properties
    
    var scannerView = QRScannerView()
    var onCreateTable: (() -> Void)?
    var onPutPassword: (() -> Void)?
    var onSuccessGetQRCodeValue: ((Table) -> Void)?
    var onFailureGetQRCodeValue: ((String) -> Void)?
    
    // MARK: - Private properties
    
    private var table: Table = Table(id: "02") // (id: "03")
    private var personRequest: Person = Person(name: "Letycia") // (name: "Letycia")
    private var createTableUseCase: CreateTableUseCaseProtocol
    private var getTableUseCase: GetTableUseCaseProtocol
    private var addPersonUseCase: AddPersonUseCaseProtocol
    private var createSessionUseCase: CreateSessionUseCaseProtocol
    
    // MARK: - Init
    
    init(
        getTablesUseCase: GetTableUseCaseProtocol,
        createTablesUseCase: CreateTableUseCaseProtocol,
        addPersonUseCase: AddPersonUseCaseProtocol,
        createSessionUseCase: CreateSessionUseCaseProtocol
    ) {
        self.getTableUseCase = getTablesUseCase
        self.createTableUseCase = createTablesUseCase
        self.addPersonUseCase = addPersonUseCase
        self.createSessionUseCase = createSessionUseCase
        scannerView.delegate = self
        validation()
    }
    
    // MARK: - Validations
    
    private func hasTableValidation(_ error: String) {
        if error == "empty_error" {
            onCreateTable?()
        } else {
            onFailureGetQRCodeValue?(error)
        }
    }
    
    private func validation() {
        guard let _ = personRequest.name else {
            onFailureGetQRCodeValue?("must_fill_name_error".localize(.error))
            startScan()
            return
        }
        getTable(id: table.id)
    }
    
    // MARK: - Request
    
    private func addPerson() {
        let path = "tables/\(table.id)/persons"
        personRequest.tableId = table.id
        
        addPersonUseCase.execute(
            path,
            request: personRequest,
            success: { [weak self] person in
                self?.createSession(person)
            },
            failure: { [weak self] error in
                self?.onFailureGetQRCodeValue?(error)
            }
        )
    }
    
    private func createSession(_ token: String) {
        personRequest.token = token
        createSessionUseCase.execute(userSession: personRequest, success: { [weak self] in
            PersonManager.shared.createPerson(person: self?.personRequest)
            self?.onSuccessGetQRCodeValue?(self?.table ?? Table())
        }, failure: { [weak self] error in
            self?.onFailureGetQRCodeValue?(error.localizedDescription)
        })
    }
    
    private func getTable(id: String) {
        getTableUseCase.execute(
            "tables",
            id: id,
            failure: { [weak self] error in
                self?.hasTableValidation(error)
            },
            success: { [weak self] table in
                self?.table = table
                self?.onPutPassword?()
            }
        )
    }
    
    private func createTable(_ password: String) {
        table.password = password
        createTableUseCase.execute(
            "tables",
            id: table.id,
            request: table,
            success: { [weak self] in
                self?.addPerson()
            },
            failure: { [weak self] error in
                self?.onFailureGetQRCodeValue?(error)
            }
        )
    }
}

extension WelcomeViewModel: WelcomeProtocol {
    
    func passwordValidation(_ password: String?) {
        if let pass = password, !pass.isEmpty, pass == table.password {
            addPerson()
            return
        }
        onFailureGetQRCodeValue?("password_insert_error".localize(.error))
    }
    
    // MARK: - Updates
    
    func didChangeName(_ text: String?) {
        personRequest.name = text
    }
    
    func didCreateTable(_ password: String?) {
        if let password = password, !password.isEmpty {
            createTable(password)
            return
        }
        onFailureGetQRCodeValue?("password_create_error".localize(.error))
    }
    
    // MARK: - Scan
    
    func startScan() {
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    func stopScan() {
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
}

extension WelcomeViewModel: QRScannerViewDelegate {
    
    func qrScanningDidFail() {
        onFailureGetQRCodeValue?("try_scan_again_error".localize(.error))
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        table.id = str ?? ""
        validation()
    }
}
