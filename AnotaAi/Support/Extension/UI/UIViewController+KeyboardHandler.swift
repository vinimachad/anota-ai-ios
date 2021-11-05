//
//  UIViewController+KeyboardHandler.swift
//  AnotaAi
//
//  Created by Vitor Mesquita on 24/09/21.
//

import UIKit

protocol KeyboardHandler {
    var scrollView: UIScrollView? { get }
    var shouldFixContent: Bool { get }
    
    func startObserveKeyboard()
    func stopObserveKeyboard()
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
    func keyboardDidShow(notification: Notification)
    func keyboardDidHide(notification: Notification)
}

extension KeyboardHandler where Self: UIViewController {
    
    var shouldFixContent: Bool {
        return false
    }
    
    func startObserveKeyboard() {
        let notificationCenter = NotificationCenter.default
        
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardWillHide(notification: notification)
            }
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardDidHideNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardDidHide(notification: notification)
            }
        
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardWillShow(notification: notification)
            }
        _ = notificationCenter.addObserver(
            forName: UIResponder.keyboardDidChangeFrameNotification,
            object: nil,
            queue: nil) { [weak self] notification in
                self?.keyboardDidShow(notification: notification)
            }
    }
    
    func stopObserveKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrameCG = keyboardValue.cgRectValue
        let keyboarFrame = view.convert(keyboardFrameCG, from: view.window)
        manageScrollByKeyboard(keyboarFrame)
    }
    
    func keyboardWillHide(notification: Notification) {
        manageScrollByKeyboardHide()
    }
    
    func keyboardDidShow(notification: Notification) {
        guard let scrollView = scrollView else { return }
        scrollView.isScrollEnabled = (shouldFixContent) ? false : scrollView.isScrollEnabled
    }
    
    func keyboardDidHide(notification: Notification) {
        guard let scrollView = scrollView else { return }
        scrollView.isScrollEnabled = (shouldFixContent) ? true : scrollView.isScrollEnabled
    }
    
    // MARK: - ScrollView
    
    func manageScrollByKeyboard(_ keyboardFrame: CGRect) {
        guard let scrollView = scrollView else { return }
        
        scrollView.contentInset.bottom = keyboardFrame.height - view.safeAreaInsets.bottom + 16
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        view.layoutIfNeeded()
        scrollView.layoutIfNeeded()
    }
    
    func manageScrollByKeyboardHide() {
        guard let scrollView = scrollView else { return }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.layoutIfNeeded()
    }
}
