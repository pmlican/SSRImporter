//
//  ViewController.swift
//  test1
//
//  Created by wanghaiwei on 2019/8/20.
//  Copyright © 2019 Shenzhen Hupzon Energy Technology Co., Ltd. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //swift 5 later
        //let result = textInput.filter { !$0.isNewline && !$0.isWhitespace }
    }

    @IBAction func clickImport(_ sender: NSButton) {
        if textView.string.isEmpty {
            let alert = NSAlert()
            alert.messageText = "提示"
            alert.informativeText = "请输入ssr://链接"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        let a = String(textView.string.filter { !" \n\t\r".contains($0) })
        let arr = a.split(separator: ",")
        for ssr in arr {
            let command = "open " + ssr
            _ = shell(command)
        }

    }
    func shell(_ command: String) -> String {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return output
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

