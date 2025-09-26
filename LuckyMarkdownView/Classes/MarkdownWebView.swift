//
//  MarkdownWebView.swift
//  LuckyMarkdownView
//
//  Created by mac on 2025/9/26.
//

import UIKit
import WebKit

public class MarkdownWebView: WKWebView {

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    public override func buildMenu(with builder: any UIMenuBuilder) {
            
        builder.remove(menu: .learn)
        builder.remove(menu: .lookup)
        builder.remove(menu: .share)
        
        super.buildMenu(with: builder)
    }

    
    
    public private(set) var configuation: WKWebViewConfiguration
    public private(set) var updateHeightHandler: UpdateContentHeightHandler
    public private(set) var selectionHandler: SelectionHandler
    
    
    public init(configuation: WKWebViewConfiguration = .init(), updateHeightHandler: UpdateContentHeightHandler = .init(), selectionHandler: SelectionHandler = .init()) {
        
        self.configuation = configuation
        self.updateHeightHandler = updateHeightHandler
        self.selectionHandler = selectionHandler
        self.configuation.userContentController.addScriptHandler(handler: self.updateHeightHandler)
        self.configuation.userContentController.addScriptHandler(handler: self.selectionHandler)
        super.init(frame: .zero, configuration: self.configuation)
        if let style = String.styledHtmlUrl {
            load(URLRequest(url: style))
        }
        navigationDelegate = self
        uiDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension MarkdownWebView: WKNavigationDelegate, WKUIDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        
        return .allow
    }
}

extension MarkdownWebView {
    
    public func selectTextAtCoordinates(x: CGFloat, y: CGFloat) {
        let script = """
            var element = document.elementFromPoint(\(x), \(y));
            if (element) {
                var range = document.createRange();
                range.selectNodeContents(element);
                var selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
            }
        """
        
        evaluateJavaScript(script) { (result, error) in
            if let error = error {
                print("Error selecting text: \(error.localizedDescription)")
            } else {
                print("Text selected at position: (\(x), \(y))")
            }
        }
    }
    
    public func load(markdown: String) {
        let markdown = markdown.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        configuration.userContentController.removeAllUserScripts()
        let us = WKUserScript(markdown: markdown)
        configuration.userContentController.addUserScript(us)
        reload()
    }
    
    
}
