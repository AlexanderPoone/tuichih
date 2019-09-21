//
//  MainViewController.swift
//  Zai Likh
//
//  Created by Victor Poon on 10/9/2019.
//  Copyright © 2019 SoftFeta. All rights reserved.
//

import UIKit
import WebKit

protocol MainViewControllerDelegate {
  func toggleLeftPanel()
  func toggleRightPanel()
  func collapseSidePanels()
}

extension MainViewController: OneBarViewControllerDelegate {
  func didSelectAnimal(_ animal: Animal) {
//    imageView.image = animal.image
//    titleLabel.text = animal.title
//    creatorLabel.text = animal.creator
    
    delegate?.collapseSidePanels()
  }
}

class MainViewController: UIViewController {
    
    var mUndoStack:[Operation] = [] // What the heck is an OperationQueue ?
    var mRedoStack:[Operation] = []
    let mPb = UIPasteboard()
    
    var delegate: MainViewControllerDelegate?

    // MARK: Button actions
    @IBAction func kittiesTapped(_ sender: Any) {
      delegate?.toggleLeftPanel()
    }
    
    @IBAction func puppiesTapped(_ sender: Any) {
      delegate?.toggleRightPanel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load text into WebKitView
        
        // Load in-app buffer (e.g. is the file starred) into WebKitView
        
        //        UIPasteboard is used to share data among apps. While that isn’t an issue in itself, a problem arose when developers started to use it to store generated identifiers and share the identifiers with all other interested apps. One library using this trick is OpenUDID.
        //
        //        In iOS 7, pasteboards created with +[UIPasteboard pasteboardWithName:create:] and +[UIPasteboard pasteboardWithUniqueName] are now only visible to apps in the same application group, which makes OpenUDID much less useful than it once was.
        
        
        mPb.addItems([[String : Any]])
        mPb.setItems([[String : Any]], options: [UIPasteboard.OptionsKey : Any])
        // Do any additional setup after loading the view.
    }
    
    func cut() {
        // Set selection if highlighted portion
        
        // Otherwise, the entire text
        
        
        
        copy();
        ColorTile *theTile = [self colorTileForOrigin:currentSelection];
        if (theTile) {
            CGPoint tilePoint = theTile.tileOrigin;
            [tiles removeObject:theTile];
            CGRect tileRect = [self rectFromOrigin:tilePoint inset:TILE_INSET];
            [self setNeedsDisplayInRect:tileRect];
        }
        
    }
    
    func copy() {
        // Set selection if highlighted portion
        
        // Otherwise, the entire text
        
         let gpBoard = UIPasteboard.general //UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
        ColorTile *theTile = [self colorTileForOrigin:currentSelection];
        if (theTile) {
            NSData *tileData = [NSKeyedArchiver archivedDataWithRootObject:theTile];
            if (tileData) {
                [gpBoard setData:tileData forPasteboardType:ColorTileUTI];
            }
        }
    }
    
    func paste() {
        // javascript will get the cursor
        let gpBoard = UIPasteboard.general //UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
        let pbType:[String] = [] //NSArray *pbType = [NSArray arrayWithObject:ColorTileUTI];
        ColorTile *theTile = [self
            colorTileForOrigin:currentSelection];
        if (theTile == nil && gpBoard.contains(pasteboardTypes: pbType)) {
            gpBoard.data(forPasteboardType: "") // NSData *tileData = [gpBoard
                dataForPasteboardType:ColorTileUTI];
            ColorTile *theTile = (ColorTile *)[NSKeyedUnarchiver
                unarchiveObjectWithData:tileData];
            if (theTile) {
                theTile.tileOrigin = self.currentSelection;
                [tiles addObject:theTile];
                CGRect tileRect = [self
                    rectFromOrigin:currentSelection inset:TILE_INSET];
                [self setNeedsDisplayInRect:tileRect];
            }
        }
    }
    
    func undo() {
        // Pull from undo stack, add to redo stack
    }
    
    func redo() {
        // Pull from redo stack, add to undo stack
    }
    
    func save() {
        // Dialog to write to disk
    }
    
    func share() {
        // System bottom card
    }
    
    func find() {
        // Dialog to find, support Regex
    }
    
    func star() {
        // Starred item
        // Changed icon to colored/greyscale
        // Add to favourites
    }
    
    func skip() {
        // Send javascript
    }
    
    func next() {
        // Send javascript
    }
}
