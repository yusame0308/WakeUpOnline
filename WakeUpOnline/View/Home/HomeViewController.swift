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
        tv.showsVerticalScrollIndicator = false
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: cellID)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(homeTableView)

        homeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wakeUpInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell // swiftlint:disable:this force_cast
        cell.render(with: wakeUpInfos[indexPath.row])
        return cell
    }

}
