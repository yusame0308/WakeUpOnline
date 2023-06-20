//
//  HomeViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private let cellID = "homeCellID"

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
        config.baseForegroundColor = .darkBrown
        return UIButton(configuration: config)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        setupLayout()
    }

    // NavigationBarの設定
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: reloadButton)
    }

    private func setupLayout() {
        view.addSubview(homeTableView)

        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wakeUpInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell // swiftlint:disable:this force_cast
        cell.selectionStyle = .none
        cell.render(with: wakeUpInfos[indexPath.row])
        return cell
    }

    // Cellを押した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }

}
