//
//  WelcomeViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import Foundation

protocol WelcomeProtocol: WelcomeViewModelProtocol {
    var onSuccessGetQRCodeValue: ((Table) -> Void)? { get set }
    var onFailureGetQRCodeValue: ((String) -> Void)? { get set }
    func startScan()
    func stopScan()
}

class WelcomeViewModel {
    
    // MARK: - Public properties
    
    var scannerView = QRScannerView()
    var onSuccessGetQRCodeValue: ((Table) -> Void)?
    var onFailureGetQRCodeValue: ((String) -> Void)?
    
    // MARK: - Private properties
    
    private var tableId: String?
    private var personRequest: Person? = Person()
    private var createPersonUseCase: CreatePersonUseCaseProtocol
    
    // MARK: - Init
    
    init(createPersonUseCase: CreatePersonUseCaseProtocol) {
        self.createPersonUseCase = createPersonUseCase
        scannerView.delegate = self
    }
    
    private func validation() {
        guard let _ = personRequest?.name else {
            onFailureGetQRCodeValue?("Você deve preencher seu nome para continuarmos")
            startScan()
            return
        }
        createPerson()
    }
}

extension WelcomeViewModel: WelcomeProtocol {
    
    // MARK: - Updates
    
    func didChangeName(_ text: String?) {
        personRequest?.name = text
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
    
    // MARK: - Request
    
    private func createPerson() {
        guard let personRequest = personRequest else { return }
        createPersonUseCase.execute(
            request: personRequest,
            success: { [weak self] person in
                let tableRequest = Table(id: self?.tableId ?? "", persons: [person])
                self?.onSuccessGetQRCodeValue?(tableRequest)
            }, failure: { [weak self] error in
                self?.onFailureGetQRCodeValue?(error)
                self?.startScan()
            }
        )
    }
}

extension WelcomeViewModel: QRScannerViewDelegate {
    
    func qrScanningDidFail() {
        print("fail")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        tableId = str
        validation()
    }
    
    func qrScanningDidStop() {
        print("stop")
    }
}
