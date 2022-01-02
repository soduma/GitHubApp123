//
//  MainViewController.swift
//  GitHubApp
//
//  Created by 장기화 on 2021/12/31.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITableViewController {
    private let organization = "Apple"
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = organization + " Repository"
        tableView.register(MainListCell.self, forCellReuseIdentifier: "MainListCell")
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        
        setUpRefreshControl()
        fetchRepositories(of: organization)
    }
    
    func setUpRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return 200...299 ~= response.statusCode
            }
            .map { _, data -> [[String: Any]] in
//                guard let json = try? JSONDecoder().decode(Repository.self, from: data) else { return [[:]]}
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
//                print("🤡 \(result)")
                return result
            }
            .filter { result in
                return result.count > 0
            }
            .map { results in
                return results.compactMap { dic -> Repository? in // nil이 나올 수 있기때문에 컴팩트맵으로 nil 제거
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let starCount = dic["starCount"] as? Int,
                          let language = dic["language"] as? String else {
                              return nil
                          }
                    return Repository(id: id, name: name, description: description, starCount: starCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
//        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainListCell", for: indexPath) as? MainListCell else {
            return UITableViewCell() }
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        cell.setUp()
        cell.repository = currentRepo
        return cell
    }
}
