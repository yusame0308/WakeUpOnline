//
//  HomeViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import SnapKit
import Combine

final class HomeViewController: UIViewController {

    private lazy var homeTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: cellID)
        return tv
    }()

    // リロードボタン
    private let reloadButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        return UIButton(configuration: config)
    }()

    // インディケーター
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .white
        indicator.backgroundColor = .systemGray
        indicator.layer.cornerRadius = 5.0
        indicator.layer.opacity = 0.7
        indicator.isHidden = true
        return indicator
    }()

    private let cellID = "homeCellID"

    private var users = [User]() {
        didSet {
            homeTableView.reloadData()
        }
    }

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: HomeViewModelable = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        setupLayout()
        bind()

        Task {
            await viewModel.fetchUserList()
        }
    }

    // NavigationBarの設定
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: reloadButton)
    }

    private func setupLayout() {
        view.addSubview(homeTableView)
        view.addSubview(indicator)

        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }

    private func bind() {
        viewModel.userListSubject
            .sink { [weak self] userList in
                self?.users = userList
            }
            .store(in: &subscriptions)

        viewModel.isLoadingSubject
            .sink { [weak self] isLoading in
                self?.indicator.isHidden = !isLoading
                if isLoading {
                    self?.indicator.startAnimating()
                } else {
                    self?.indicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)

        viewModel.errorAlertSubject
            .sink { [weak self] message in
                let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &subscriptions)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell // swiftlint:disable:this force_cast
        cell.selectionStyle = .none
        cell.render(with: users[indexPath.row])
        return cell
    }

    // Cellを押してユーザ詳細画面を表示
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailViewController = UserDetailViewController(user: users[indexPath.row])
        userDetailViewController.modalPresentationStyle = .pageSheet
        present(userDetailViewController, animated: true)
    }

}
