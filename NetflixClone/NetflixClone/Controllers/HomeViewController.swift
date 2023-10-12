//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Nikita  on 9/9/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles = ["Trending Movies","Popular", "Trending TV", "Top Rated", "Upcoming Movies"]
    
    private let homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
      
        homeFeedTableView.dataSource = self
        homeFeedTableView.delegate = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTableView.tableHeaderView = headerView
        
        configurateNavBar()
        getTrendingMovies()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
    
    private func configurateNavBar() {
        let containerView = UIControl(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.image = UIImage(named: "netflixLogo")
        containerView.addSubview(image)
        let logoBarButtonItem = UIBarButtonItem(customView: containerView)
        logoBarButtonItem.width = 20
        navigationItem.leftBarButtonItem = logoBarButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        navigationController?.navigationBar.tintColor = .label
    }
    //Sticky header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = defaultOffset + scrollView.contentOffset.y
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
   //Retreiving trending movies data from api 
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
}
