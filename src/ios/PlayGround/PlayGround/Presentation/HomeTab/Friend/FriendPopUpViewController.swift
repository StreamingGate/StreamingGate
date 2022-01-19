//
//  FriendPopUpViewController.swift
//  PlayGround
//
//  Created by chuiseo-MN on 2022/01/14.
//

import Foundation
import UIKit

class FriendPopUpViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var onlineMarkView: UIView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        popUpView.layer.cornerRadius = 5
        profileImageView.layer.cornerRadius = 45 / 2
        profileImageView.backgroundColor = UIColor.placeHolder
        onlineMarkView.layer.cornerRadius = 6
        nickNameLabel.font = UIFont.Component
        roomNameLabel.font = UIFont.Content
        roomNameLabel.textColor = UIColor.customDarkGray
        watchButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}