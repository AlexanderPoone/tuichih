//
//  MarkupDocunent.swift
//  Zai Likh
//
//  Created by Victor Poon on 10/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import UIKit

enum DocumentError: Error {
  case unrecognizedContent
  case corruptDocument
  case archivingFailure
  
  var localizedDescription: String {
    switch self {
      
    case .unrecognizedContent:
      return NSLocalizedString("File is an unrecognised format", comment: "")
    case .corruptDocument:
      return NSLocalizedString("File could not be read", comment: "")
    case .archivingFailure:
      return NSLocalizedString("File could not be saved", comment: "")
    }
  }
  
}

class MarkupDocument: UIDocument {
  
  static let defaultTemplateName = BottomAlignedView.name
  static let filenameExtension = "rwmarkup"
  
  var markup: MarkupDescription = ContentDescription(template: defaultTemplateName) {
    didSet {
      updateChangeCount(.done)
    }
  }
  
  override func contents(forType typeName: String) throws -> Any {
    let data: Data
    do {
      data = try NSKeyedArchiver.archivedData(withRootObject: markup, requiringSecureCoding: false)
    } catch {
      throw DocumentError.archivingFailure
    }
    guard !data.isEmpty else {
      throw DocumentError.archivingFailure
    }
    return data
  }
  
  override func load(fromContents contents: Any, ofType typeName: String?) throws {
    // 1
    guard let data = contents as? Data else {
      throw DocumentError.unrecognizedContent
    }
    
    // 2
    let unarchiver: NSKeyedUnarchiver
    do {
      unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
    } catch {
      throw DocumentError.corruptDocument
    }
    unarchiver.requiresSecureCoding = false
    let decodedContent = unarchiver.decodeObject(of: ContentDescription.self,
                                                 forKey: NSKeyedArchiveRootObjectKey)
    guard let content = decodedContent else {
      throw DocumentError.corruptDocument
    }
    
    // 3
    markup = content
  }

}
