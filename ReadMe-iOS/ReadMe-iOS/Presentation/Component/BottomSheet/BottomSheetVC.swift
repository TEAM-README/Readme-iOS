//
//  BottomSheetVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import UIKit

import SnapKit

final class BottomSheetVC: UIViewController {
  
  enum BottomSheetType {
    case filter
    case actionSheet
  }
  
  // MARK: - Vars & Lets Part
  
  private let contentVC: UIViewController
  private let dimmerView = UIView()
  private let bottomSheetView = UIView()
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  private var filterHeight: CGFloat = UIScreen.main.bounds.width * 532 / 390
  private var actionHeight: CGFloat = UIScreen.main.bounds.width * 172 / 390
  private var bottomSheetType: BottomSheetType = .filter
  
  // MARK: - Initialize
  init(contentViewController: UIViewController, type: BottomSheetType = .filter) {
    self.contentVC = contentViewController
    self.bottomSheetType = type
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configUI()
    setLayout()
    setTapGesture()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    showBottomSheet()
  }
}

// MARK: - UI & Layout Part
extension BottomSheetVC {
  private func configUI() {
    self.view.backgroundColor = .clear
    dimmerView.backgroundColor = .black.withAlphaComponent(0.6)
    dimmerView.alpha = 0.6
    
    addChild(contentVC) // contentVC를 BottomSheetVC의 자식으로 설정
    bottomSheetView.addSubview(contentVC.view) // contentVC의 view가 맨 앞에 등장하도록
    contentVC.didMove(toParent: self)
    
    bottomSheetView.backgroundColor = .clear
    bottomSheetView.layer.cornerRadius = 20
    bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    bottomSheetView.clipsToBounds = true
  }
  
  private func setLayout() {
    view.addSubviews([dimmerView, bottomSheetView])
    
    dimmerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
    
    bottomSheetView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).inset(topConstant)
    }
    self.view.layoutIfNeeded()
    
    contentVC.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension BottomSheetVC {
  
  // MARK: - Custom Method
  
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    let statusBarHeight: CGFloat = getStatusBarHeight()
    var topConstant = safeAreaHeight - statusBarHeight - filterHeight
    
    if bottomSheetType == .actionSheet {
      topConstant = safeAreaHeight - statusBarHeight - actionHeight
    }
    
    bottomSheetView.snp.updateConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(topConstant)
    }
    
    UIView.animate(withDuration: 0.25,
                   delay: 0,
                   options: .curveEaseIn,
                   animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func setTapGesture() {
    let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
    dimmerView.addGestureRecognizer(dimmerTap)
    dimmerView.isUserInteractionEnabled = true
  }
  
  private func hideBottomSheetAndGoBack(completion: (() -> Void)? = nil) {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    let topConstant = safeAreaHeight + bottomPadding
    bottomSheetView.snp.updateConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(topConstant)
    }
    
    UIView.animate(withDuration: 0.25,
                   delay: 0,
                   options: .curveEaseIn,
                   animations: {
      self.dimmerView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: true, completion: completion)
      }
    }
  }
  
  // MARK: - @objc
  
  @objc
  private func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
}

extension BottomSheetVC: BottomSheetDelegate {
  func dismissButtonTapped(completion: (() -> Void)? = nil) {
    hideBottomSheetAndGoBack(completion: completion)
  }
}
