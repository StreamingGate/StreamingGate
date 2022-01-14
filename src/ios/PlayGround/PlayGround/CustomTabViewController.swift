//
//  CustomTabViewController.swift
//  SG_YouTube
//
//  Created by chuiseo-MN on 2022/01/13.
//

import Foundation
import UIKit
import Combine

class CustomTabViewController: UIViewController {
    @IBOutlet weak var playViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tabBarStackView: UIStackView!
    @IBOutlet weak var playViewHeight: NSLayoutConstraint!
    @IBOutlet weak var playContainerView: UIView!
    @IBOutlet weak var tabBarSeparatorView: UIView!
    @IBOutlet weak var bottomWhiteView: UIView!
    @IBOutlet weak var homeTabImageView: UIImageView!
    @IBOutlet weak var homeTabLabel: UILabel!
    @IBOutlet weak var myTabImageView: UIImageView!
    @IBOutlet weak var CreateTabImageView: UIImageView!
    @IBOutlet weak var myTabLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @Published var selectedTanIndex = 0
    private var cancellable: Set<AnyCancellable> = []
    
    var safeTop: CGFloat = 0
    var safeBottom: CGFloat = 0
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        safeTop = self.view.safeAreaInsets.top
        safeBottom = self.view.safeAreaInsets.bottom
        playViewHeight.constant = UIScreen.main.bounds.height - safeTop - safeBottom
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
        guard let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? HomeNavigationController else { return }
        self.removeChildViewController()
        self.addChild(homeVC)
        self.containerView.addSubview((homeVC.view)!)
        homeVC.view.frame = self.containerView.bounds
        homeVC.didMove(toParent: self)
        homeVC.playDelegate = self
        homeVC.friendDelegate = self
        homeVC.searchDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playViewHeight.constant = UIScreen.main.bounds.height - safeTop - safeBottom
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            playViewHeight.constant = UIScreen.main.bounds.width
        } else {
            playViewHeight.constant = UIScreen.main.bounds.height - safeTop - safeBottom
        }
    }
    
    func bindData() {
        $selectedTanIndex.receive(on: RunLoop.main)
            .sink { [weak self] index in
                guard let self = self else { return }
                switch index {
                case 0:
                    // 홈탭
                    self.homeTabImageView.image = UIImage(named: "homeIcon_fill")
                    self.myTabImageView.image = UIImage(named: "my_empty")
                case 2:
                    // 마이탭
                    self.homeTabImageView.image = UIImage(named: "homeIcon_empty")
                    self.myTabImageView.image = UIImage(named: "my_fill")
                default:
                    // 생성탭은 UI 딱히 안 바뀔 예정
                    break
                }
            }.store(in: &cancellable)
    }
    
    func setupUI() {
        homeTabLabel.font = UIFont.caption
        myTabLabel.font = UIFont.caption
    }
    
    @IBAction func homeTabDidTap(_ sender: Any) {
        guard let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? HomeNavigationController else { return }
        self.selectedTanIndex = 0
        self.removeChildViewController()
        self.addChild(homeVC)
        self.containerView.addSubview((homeVC.view)!)
        homeVC.view.frame = self.containerView.bounds
        homeVC.didMove(toParent: self)
        homeVC.playDelegate = self
        homeVC.friendDelegate = self
        homeVC.searchDelegate = self
    }
    
    @IBAction func createTabDidTap(_ sender: Any) {
        guard let popOverVC = UIStoryboard(name: "Create", bundle: nil).instantiateViewController(withIdentifier: "CreateNavigationController") as? CreateNavigationController else { return }
        self.selectedTanIndex = 1
        popOverVC.modalPresentationStyle = .overFullScreen
        popOverVC.modalTransitionStyle = .crossDissolve
        self.present(popOverVC, animated: true, completion: nil)
    }
    
    @IBAction func myTabDidTap(_ sender: Any) {
        guard let myVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPageNavigationController") as? MyPageNavigationController else { return }
        self.selectedTanIndex = 2
        self.removeChildViewController()
        self.addChild(myVC)
        self.containerView.addSubview((myVC.view)!)
        myVC.view.frame = self.containerView.bounds
        myVC.didMove(toParent: self)
        myVC.playDelegate = self
    }
    
    func removeChildViewController(){
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for i in viewControllers {
                if (i as? PlayViewController) == nil {                
                    i.willMove(toParent: nil)
                    i.removeFromParent()
                    i.view.removeFromSuperview()
                }
            }
        }
    }
    
    func removePlayer() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for i in viewControllers {
                if (i as? PlayViewController) != nil {
                    i.willMove(toParent: nil)
                    i.removeFromParent()
                    i.view.removeFromSuperview()
                }
            }
        }
    }
}

extension CustomTabViewController: playOpenDelegate, friendListOpenDelegate, searchOpenDelegate{
    func openPlayer() {
        playContainerView.isHidden = false
        if let playVC = self.children.first(where: { vc in
            vc is PlayViewController
        }) as? PlayViewController {
            print("exist")
            playVC.isMinimized = false
            self.playViewTopMargin.constant = 0
            self.tabBarHeight.constant = 0
            self.tabBarStackView.isHidden = true
            self.tabBarSeparatorView.isHidden = true
            self.bottomWhiteView.isHidden = true
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.view.backgroundColor = UIColor.black
            }
        } else {
            print("new")
            guard let playVC = UIStoryboard(name: "Play", bundle: nil).instantiateViewController(withIdentifier: "PlayViewController" ) as? PlayViewController else { return }
            self.addChild(playVC)
            self.playContainerView.addSubview((playVC.view)!)
            playVC.view.frame = self.playContainerView.bounds
            playVC.didMove(toParent: self)
            playVC.safeTop = safeTop
            playVC.safeBottom = safeBottom
            tabBarHeight.constant = 0
            tabBarStackView.isHidden = true
            tabBarSeparatorView.isHidden = true
            bottomWhiteView.isHidden = true
        }
    }
    
    func openFriendList() {
        guard let popOverVC = UIStoryboard(name: "Friend", bundle: nil).instantiateViewController(withIdentifier: "FriendListViewController" ) as? FriendListViewController else { return }
        popOverVC.modalPresentationStyle = .overFullScreen
        popOverVC.modalTransitionStyle = .crossDissolve
        self.present(popOverVC, animated: true, completion: nil)
    }
    
    func openSearch() {
        guard let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController" ) as? SearchViewController else { return }
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.modalTransitionStyle = .crossDissolve
        self.present(searchVC, animated: true, completion: nil)
    }
}


protocol playOpenDelegate {
    func openPlayer()
}

protocol friendListOpenDelegate {
    func openFriendList()
}

protocol searchOpenDelegate {
    func openSearch()
}


