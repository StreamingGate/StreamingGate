//
//  LiveChatCell.swift
//  SG_YouTube
//
//  Created by chuiseo-MN on 2022/01/10.
//

import Foundation
import UIKit

class LiveChatCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func setupUI(info : ChatData) {
        profileImageView.backgroundColor = UIColor.placeHolder
        profileImageView.layer.cornerRadius = 20
        nicknameLabel.font = UIFont.Tab
        nicknameLabel.textColor = UIColor.white
        contentLabel.textColor = UIColor.white
        contentLabel.font = UIFont.Component
        contentLabel.text = info.message
        nicknameLabel.text = info.nickname
    }
}