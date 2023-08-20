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

    private typealias DataSource = UITableViewDiffableDataSource<Int, User>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, User>

    private lazy var homeTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
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
    private lazy var dataSource = configureDataSource()

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: HomeViewModelable = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        setupLayout()
        setupAction()
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

    private func setupAction() {
        reloadButton.addAction(UIAction { [weak self] _ in
            Task {
                await self?.viewModel.reloadUserList()
            }
        }, for: .primaryActionTriggered)
    }

    private func bind() {
        viewModel.userListSubject
            .sink { [weak self] userList in
                self?.createSnapshot(with: userList)
            }
            .store(in: &cancellables)

        viewModel.isLoadingSubject
            .sink { [weak self] isLoading in
                self?.indicator.isHidden = !isLoading
                if isLoading {
                    self?.indicator.startAnimating()
                } else {
                    self?.indicator.stopAnimating()
                }
            }
            .store(in: &cancellables)

        viewModel.showUserDetailViewSubject
            .sink { [weak self] user in
                let userDetailViewController = UserDetailViewController(user: user)
                userDetailViewController.modalPresentationStyle = .pageSheet
                self?.present(userDetailViewController, animated: true)
            }
            .store(in: &cancellables)

        viewModel.errorAlertSubject
            .sink { [weak self] message in
                let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }

    private func configureDataSource() -> DataSource {
        return UITableViewDiffableDataSource(tableView: homeTableView) { [weak self] tableView, indexPath, user in
            guard let self = self else { return nil }

            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! HomeTableViewCell // swiftlint:disable:this force_cast
            cell.selectionStyle = .none
            cell.render(with: user)
            return cell
        }
    }

    private func createSnapshot(with userList: [User]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(userList)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension HomeViewController: UITableViewDelegate {

    // Cellを押してユーザ詳細画面を表示
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.handleDidSelectRowAt(indexPath)
    }

}
