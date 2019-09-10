//
//  ContainerViewController.swift
//  Zai Likh
//
//  Created by Victor Poon on 10/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  enum SlideOutState {
    case bothCollapsed
    case leftPanelExpanded
    case rightPanelExpanded
  }
  
  var centerNavigationController: UINavigationController!
  var MainViewController: MainViewController!
  
    
  var currentState: SlideOutState = .bothCollapsed {
    didSet {
      let shouldShowShadow = currentState != .bothCollapsed
      showShadowForMainViewController(shouldShowShadow)
    }
  }
  var leftViewController: OneBarViewController?
  var rightViewController: OneBarViewController?
  
  let centerPanelExpandedOffset: CGFloat = 90
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    MainViewController = UIStoryboard.MainViewController()
    MainViewController.delegate = self
    
    // wrap the MainViewController in a navigation controller, so we can push views to it
    // and display bar button items in the navigation bar
    centerNavigationController = UINavigationController(rootViewController: MainViewController)
    view.addSubview(centerNavigationController.view)
    addChild(centerNavigationController)
    
    centerNavigationController.didMove(toParent: self)
    
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
  }
}

private extension UIStoryboard {
  static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  static func leftViewController() -> OneBarViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? OneBarViewController
  }
  
  static func rightViewController() -> OneBarViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? OneBarViewController
  }
  
  static func MainViewController() -> MainViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
  }
}

// MARK: MainViewController delegate

extension ContainerViewController: MainViewControllerDelegate {
  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .leftPanelExpanded)

    if notAlreadyExpanded {
      addLeftPanelViewController()
    }

    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func addLeftPanelViewController() {
    guard leftViewController == nil else { return }

    if let vc = UIStoryboard.leftViewController() {
      vc.animals = Animal.allCats()
      addChildSidePanelController(vc)
      leftViewController = vc
    }
  }
  
  func animateLeftPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .leftPanelExpanded
      animateCenterPanelXPosition(
        targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .bothCollapsed
        self.leftViewController?.view.removeFromSuperview()
        self.leftViewController = nil
      }
    }
  }
  
  func toggleRightPanel() {
    let notAlreadyExpanded = (currentState != .rightPanelExpanded)

    if notAlreadyExpanded {
      addRightPanelViewController()
    }

    animateRightPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func addRightPanelViewController() {
    guard rightViewController == nil else { return }
    
    if let vc = UIStoryboard.rightViewController() {
      vc.animals = Animal.allDogs()
      addChildSidePanelController(vc)
      rightViewController = vc
    }
  }

  func animateRightPanel(shouldExpand: Bool) {
    if shouldExpand {
      currentState = .rightPanelExpanded
      animateCenterPanelXPosition(
        targetPosition: -centerNavigationController.view.frame.width + centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .bothCollapsed
        
        self.rightViewController?.view.removeFromSuperview()
        self.rightViewController = nil
      }
    }
  }
  
  func collapseSidePanels() {
    switch currentState {
    case .rightPanelExpanded:
      toggleRightPanel()
    case .leftPanelExpanded:
      toggleLeftPanel()
    default:
      break
    }
  }
  
  func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   usingSpringWithDamping: 0.8,
                   initialSpringVelocity: 0,
                   options: .curveEaseInOut, animations: {
                     self.centerNavigationController.view.frame.origin.x = targetPosition
    }, completion: completion)
  }
  
  func addChildSidePanelController(_ sidePanelController: OneBarViewController) {
    sidePanelController.delegate = MainViewController
    view.insertSubview(sidePanelController.view, at: 0)
    
    addChild(sidePanelController)
    sidePanelController.didMove(toParent: self)
  }
  
  func showShadowForMainViewController(_ shouldShowShadow: Bool) {
    if shouldShowShadow {
      centerNavigationController.view.layer.shadowOpacity = 0.8
    } else {
      centerNavigationController.view.layer.shadowOpacity = 0.0
    }
  }
}

// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
  @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
    let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)

    switch recognizer.state {
    case .began:
      if currentState == .bothCollapsed {
        if gestureIsDraggingFromLeftToRight {
          addLeftPanelViewController()
        } else {
          addRightPanelViewController()
        }
        
        showShadowForMainViewController(true)
      }
      
    case .changed:
      if let rview = recognizer.view {
        rview.center.x = rview.center.x + recognizer.translation(in: view).x
        recognizer.setTranslation(CGPoint.zero, in: view)
      }
      
    case .ended:
      if let _ = leftViewController,
        let rview = recognizer.view {
        // animate the side panel open or closed based on whether the view
        // has moved more or less than halfway
        let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
        animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
      } else if let _ = rightViewController,
        let rview = recognizer.view {
        let hasMovedGreaterThanHalfway = rview.center.x < 0
        animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
      }
      
    default:
      break
    }
  }
}
