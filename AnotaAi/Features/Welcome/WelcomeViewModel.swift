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
    
    private var table: Table = Table()
    private var personRequest: Person = Person()
    private var createTableUseCase: CreateTableUseCaseProtocol
    private var getTableUseCase: GetTableUseCaseProtocol
    private var addPersonUseCase: AddPersonUseCaseProtocol
    
    // MARK: - Init
    
    init(
        getTablesUseCase: GetTableUseCaseProtocol,
        createTablesUseCase: CreateTableUseCaseProtocol,
        addPersonUseCase: AddPersonUseCaseProtocol
    ) {
        self.getTableUseCase = getTablesUseCase
        self.createTableUseCase = createTablesUseCase
        self.addPersonUseCase = addPersonUseCase
        scannerView.delegate = self
    }
    
    // MARK: - Validations
    
    private func hasTableValidation(_ error: String) {
        if error == "DECODER" {
            onCreateTable?()
        } else {
            onFailureGetQRCodeValue?(error)
        }
    }
    
    private func validation() {
        guard let _ = personRequest.name else {
            onFailureGetQRCodeValue?("Você deve preencher seu nome para continuarmos")
            startScan()
            return
        }
        getTable(id: table.id)
    }
    
    // MARK: - Request
    
    private func addPerson() {
        personRequest.tableId = table.id
        
        addPersonUseCase.execute(
            request: personRequest,
            success: { [weak self] person in
                // todo - create session
                self?.onSuccessGetQRCodeValue?(self?.table ?? Table())
            },
            failure: { [weak self] error in
                self?.onFailureGetQRCodeValue?(error)
            }
        )
    }
    
    private func getTable(id: String) {
        getTableUseCase.execute(id: id, failure: { [weak self] error in
            self?.hasTableValidation(error)
        }, success: { [weak self] table in
            self?.table = table
            self?.onPutPassword?()
        })
    }
    
    private func createTable(_ password: String) {
        table.password = password
        createTableUseCase.execute(request: table, success: { [weak self]  in
            self?.addPerson()
        }, failure: { [weak self] error in
            self?.onFailureGetQRCodeValue?(error)
        })
    }
}

extension WelcomeViewModel: WelcomeProtocol {
    
    func passwordValidation(_ password: String?) {
        if let pass = password, !pass.isEmpty, pass == table.password {
            addPerson()
            return
        }
        onFailureGetQRCodeValue?("Campo de texto vazio ou senha incorreta!")
    }
    
    // MARK: - Updates
    
    func didChangeName(_ text: String?) {
        personRequest.name = text
    }
    
    func didCreateTable(_ password: String?) {
        if let password = password, !password.isEmpty {
            createTable(password)
        }
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
        print("fail")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        table.id = str ?? ""
        validation()
    }
    
    func qrScanningDidStop() {
        print("stop")
    }
}
