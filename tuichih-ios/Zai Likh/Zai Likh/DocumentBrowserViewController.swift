//
//  DocumentBrowserViewController.swift
//  Zai Likh
//
//  Created by Victor Poon on 10/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import UIKit

class DocumentBrowserViewController: UIViewController {
  
  var currentDocument: MarkupDocument?
  var editingDocument = false
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var browserDelegate = DocumentBrowserDelegate()
  lazy var documentBrowser: UIDocumentBrowserViewController = {
    let browser = UIDocumentBrowserViewController()
    
    browser.allowsDocumentCreation = true
    browser.browserUserInterfaceStyle = .dark
    browser.view.tintColor = UIColor(named: "RazeGreen") ?? .white
    browser.delegate = browserDelegate
    
    return browser
  }()
  
  func installDocumentBrowser() {
    view.pinToInside(view: documentBrowser.view)
    browserDelegate.presentationHandler = { [weak self] url, error in
      
      guard error == nil else {
        //present error to user e.g UIAlertController
        return
      }
      
      if let url = url, let self = self {
        self.openDocument(url: url)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    installDocumentBrowser()
  }
  
}

extension DocumentBrowserViewController {
  
  func openDocument(url: URL) {
    
    //1.
    guard isDocumentCurrentlyOpen(url: url) == false else {
      return
    }
    
    
    closeMarkupController {
      //2.
      let document = MarkupDocument(fileURL: url)
      document.open { openSuccess in
        guard openSuccess else {
          return
        }
        self.currentDocument = document
        self.displayMarkupController()
      }
    }
  }
  
  //3.
  private func isDocumentCurrentlyOpen(url: URL) -> Bool {
    if let document = currentDocument {
      if document.fileURL == url && document.documentState != .closed  {
        return true
      }
    }
    return false
  }
  
  private func closeCurrentDocument()  {
    currentDocument?.close()
    currentDocument = nil
  }
  
}

extension DocumentBrowserViewController: MarkupViewControllerDelegate {
  
  //1.
  func displayMarkupController() {
    
    guard !editingDocument, let document = currentDocument else {
      return
    }
    
    editingDocument = true
    let controller = MarkupViewController.freshController(markup: document.markup, delegate: self)
    present(controller, animated: true)
  }
  
  //2.
  func closeMarkupController(completion: (() -> Void)? = nil) {
    
    let compositeClosure = {
      self.closeCurrentDocument()
      self.editingDocument = false
      completion?()
    }
    
    if editingDocument {
      dismiss(animated: true) {
        compositeClosure()
      }
    } else {
      compositeClosure()
    }
  }
  
  func markupEditorDidFinishEditing(_ controller: MarkupViewController, markup: MarkupDescription) {
    currentDocument?.markup = markup
    closeMarkupController()
  }
  
  func markupEditorDidUpdateContent(_ controller: MarkupViewController, markup: MarkupDescription) {
    currentDocument?.markup = markup
  }
  
}

extension DocumentBrowserViewController {
  func openRemoteDocument(_ inboundURL: URL, importIfNeeded: Bool) {
    documentBrowser.revealDocument(at: inboundURL, importIfNeeded: importIfNeeded) { (url, error) in
      if let error = error {
        print("import did fail - should be communicated to user - \(error)")
      } else if let url = url {
        self.openDocument(url: url)
      }
    }
  }
}
