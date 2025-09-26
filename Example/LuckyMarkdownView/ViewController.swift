//
//  ViewController.swift
//  LuckyMarkdownView
//
//  Created by JunkyTang on 09/26/2025.
//  Copyright (c) 2025 JunkyTang. All rights reserved.
//

import UIKit
import SnapKit
import LuckyMarkdownView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(wbView)
        wbView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadMarkdown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    lazy var wbView: MarkdownWebView = {
        let tmp = MarkdownWebView()
        return tmp
    }()
    
    func loadMarkdown(file: String = "sample1") {
        let path = Bundle.main.path(forResource: file, ofType: "md")!
        let url = URL(fileURLWithPath: path)
        let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        wbView.load(markdown: markdown)
    }
    
    

}

