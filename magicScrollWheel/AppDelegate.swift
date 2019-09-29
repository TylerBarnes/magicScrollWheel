//
//  AppDelegate.swift
//  magicScrollWheel
//
//  Created by Aleksandr Kozhevnikov on 31/03/2019.
//  Copyright © 2019 Aleksandr Kozhevnikov. All rights reserved.
//


import Foundation
import IOKit.hid
import Cocoa
import CoreGraphics

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var magicScrollController: MagicScrollController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(showMenuPopup)
        }
        popover.behavior = NSPopover.Behavior.transient;
        popover.contentViewController = PopoverViewController.freshController()
        self.startMagicScroll()
    }
    
    func startMagicScroll() {
        magicScrollController = MagicScrollController()
        magicScrollController?.run()
    }
    
    func stopMagicScroll() {
        magicScrollController?.stop()
        magicScrollController = nil
    }
    
    @objc func showMenuPopup() {
        print("menu should be showed")
        
        if popover.isShown {
            popover.performClose(self)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func toggleMagicScroll() -> Bool {
        if magicScrollController != nil {
            self.stopMagicScroll()
        } else {
            self.startMagicScroll()
        }
        return magicScrollController != nil
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

