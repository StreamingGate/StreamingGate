//
//  AccountEditViewController.swift
//  SG_YouTube
//
//  Created by chuiseo-MN on 2022/01/03.
//

import Foundation
import UIKit

class AccountEditViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    var coordinator: AccountEditCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = UIFont.SubTitle
        nicknameLabel.textColor = UIColor.placeHolder
        nicknameLabel.font = UIFont.caption
        nicknameTextField.font = UIFont.Content
        profileImageView.backgroundColor = UIColor.placeHolder
        profileImageView.layer.cornerRadius = 30
        guard let userInfo = UserManager.shared.userInfo else { return }
        profileImageView.downloadImageFrom(link: userInfo.profileImage, contentMode: .scaleAspectFill)
        nicknameTextField.text = userInfo.nickName
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        coordinator?.dismiss()
    }
    
    @IBAction func withdrawButtonDidTap(_ sender: Any) {
        coordinator?.dismissToRoot()
    }
}
