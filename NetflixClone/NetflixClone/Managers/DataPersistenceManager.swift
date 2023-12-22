//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 12/22/23.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToDaveData
        case failedToDeleteData
        case failedToFetchData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitle(with model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.vote_average = model.vote_average ?? 0.0
        item.vote_count = Int64(model.vote_count ?? 0)
        item.release_date = model.release_date
        
        do {
            try context.save()
            completion(.success(()))
        }
        catch {
            completion(.failure(DatabaseError.failedToDaveData))
        }
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        }
        catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
        
    }
    
    func deleteTitle(with item: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(item)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
