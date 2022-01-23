//
//  TableViewDataSourceWithoutNib.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 23/01/22.
//

import Foundation
import UIKit
import Reusable

class TableViewDataSourceWithoutNib: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var scrollDelegate: UIScrollViewDelegate?
    
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            register()
        }
    }
    
    var sections: [TableSectionWithoutNibProtocol] = [] {
        didSet {
            tableView?.reloadData()
            register()
        }
    }
    
    private func register() {
        for section in sections {
            section.registerCell(tableView: tableView)
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: section.cellType)
        section.bindCell(cell: cell, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].didSelectAt(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}
