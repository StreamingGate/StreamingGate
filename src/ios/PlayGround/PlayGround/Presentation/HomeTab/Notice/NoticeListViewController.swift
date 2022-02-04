//
//  NoticeListViewController.swift
//  PlayGround
//
//  Created by chuiseo-MN on 2022/01/14.
//

import Foundation
import UIKit
import Combine

class NoticeListViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var friendRequestButton: UIButton!
    @IBOutlet weak var friendRequestCountView: UIView!
    @IBOutlet weak var friendRequestCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var friendRequestBackView: UIView!
    
    var navVC: HomeNavigationController?
    let viewModel = NoticeViewModel()
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nav = self.navigationController as? HomeNavigationController else { return }
        self.navVC = nav
        bindViewModel()
        setupUI()
        self.viewModel.loadNotice(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadFriendRequest(vc: self)
    }
    
    func bindViewModel() {
        self.viewModel.$noticeList.receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &cancellable)
        self.viewModel.$friendRequestList.receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] list in
                guard let self = self else { return }
                self.friendRequestCountLabel.text = "\(list.count)"
            }.store(in: &cancellable)
    }
    
    func setupUI() {
        titleLabel.font = UIFont.SubTitle
        friendRequestButton.layer.cornerRadius = 20
        friendRequestButton.setTitle("", for: .normal)
        friendRequestCountView.layer.cornerRadius = 10
        friendRequestBackView.layer.cornerRadius = 20
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navVC?.coordinator?.pop()
    }
    
    @IBAction func friendRequestButtonDidTap(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Notice", bundle: nil).instantiateViewController(withIdentifier: "FriendRequestViewController") as? FriendRequestViewController else { return }
        vc.viewModel.updateViewModel(vm: self.viewModel)
        self.navVC?.pushViewController(vc, animated: true)
    }
}

extension NoticeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as? NoticeCell else {
            return UITableViewCell()
        }
        cell.updateUI(info: self.viewModel.noticeList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
