//
//  MoviesTableViewDataSource.swift
//  MovieLibrary
//
//  Created by Jagjot Singh on 30/03/21.
//

import Foundation
import UIKit

class MoviesTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var apiClient : APIClient!

    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var didSelectMovie : (T) -> () = {_ in }

    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> (), didSelectMovie : @escaping (T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.didSelectMovie = didSelectMovie
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        self.didSelectMovie(item)
    }
}
