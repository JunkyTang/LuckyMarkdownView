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
    
    var disableSelect: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(wbView)
        wbView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(view)
            make.width.height.equalTo(80)
        }
        
        view.addSubview(btn1)
        btn1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(btn.snp.right)
            make.width.height.equalTo(80)
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
    
    lazy var btn: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setTitle("action", for: .normal)
        tmp.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        return tmp
    }()
    
    lazy var btn1: UIButton = {
        let tmp = UIButton(type: .system)
        tmp.setTitle("action", for: .normal)
        tmp.addTarget(self, action: #selector(clickAction1), for: .touchUpInside)
        return tmp
    }()
    
    
    lazy var wbView: MarkdownWebView = {
        let tmp = MarkdownWebView()
        tmp.updateHeightHandler.funcForUpdateHeight = {
            print($0)
        }

        return tmp
    }()
    
    func loadMarkdown(file: String = "sample1") {
        let path = Bundle.main.path(forResource: file, ofType: "md")!
        let url = URL(fileURLWithPath: path)
        let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        wbView.load(markdown: markdown)
    }
    
    

    @objc func clickAction() {
        
        disableSelect = !disableSelect
        
    }
    @objc func clickAction1() {
        
        wbView.selectTextAtCoordinates(x: 120, y: 400)

    }
}

