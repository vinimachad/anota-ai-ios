//
//  WelcomeViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import Foundation

protocol WelcomeProtocol: WelcomeViewModelProtocol {
    var onSuccessGetQRCodeValue: ((String) -> Void)? { get set }
    var onFailureGetQRCodeValue: (() -> Void)? { get set }
    func startScan()
    func stopScan()
}

class WelcomeViewModel {
    
    // MARK: - Public properties
    
    var scannerView = QRScannerView()
    var onSuccessGetQRCodeValue: ((String) -> Void)?
    var onFailureGetQRCodeValue: (() -> Void)?
    
    // MARK: - Private properties
    
    // MARK: - Init
    
    init() {
        scannerView.delegate = self
    }
    
}

extension WelcomeViewModel: WelcomeProtocol {
    
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
        onSuccessGetQRCodeValue?(str ?? "")
    }
    
    func qrScanningDidStop() {
        print("stop")
    }
}
