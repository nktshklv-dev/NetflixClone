//
//  DownloadsViewController.swift
//  NetflixClone
//
//  Created by Nikita  on 9/9/23.
//

import UIKit

class DownloadsViewController: UIViewController {

    
    private var titles: [TitleItem] = []
    
    private let downloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        view.addSubview(downloadedTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        let title = titles[indexPath.row]
        guard let posterPath = title.poster_path else { return UITableViewCell()}
        print(posterPath)
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown", posterURL: posterPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitle(with: titles[indexPath.row]) {[weak self] result in
                switch result {
                case .success(_):
                    print("Deleted from the database")
                    self?.titles.removeAll()
                    DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
                        switch result {
                        case .success(let titles):
                            self?.titles = titles
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        default:
            break;
            
        }
        
    }
}
