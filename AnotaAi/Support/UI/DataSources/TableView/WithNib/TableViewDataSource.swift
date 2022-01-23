//
//  TableViewDataSource.swift
//  app-template
//
//  Created by Vinicius Galhardo Machado on 25/04/21.
//

import UIKit
import Reusable

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var scrollDelegate: UIScrollViewDelegate?
    
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            registerNibs()
        }
    }
    
    var sections: [TableSectionProtocol] = [] {
        didSet {
            tableView?.reloadData()
            registerNibs()
        }
    }
    
    private func registerNibs() {
        for section in sections {
            tableView?.registerNib(section.cellType)
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight()
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
