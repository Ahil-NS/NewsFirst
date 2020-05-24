//
//  NewsWebViewController.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import WebKit

public class NewsWebViewController: UIViewController {
    
    var webURL: URL?
    
    lazy var webView: WKWebView = {
        var webView = WKWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsLinkPreview = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        webURL = URL(string: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(activityIndicator)
       
        activityIndicator.startAnimating()
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        activityIndicator.center = view.center
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let url = webURL else { return }
        webView.load(NSURLRequest(url: url) as URLRequest)
    }
}

extension NewsWebViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         activityIndicator.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationResponse: WKNavigationResponse,
                        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView,
                        didFailProvisionalNavigation navigation: WKNavigation!,
                        withError error: Error) {
        activityIndicator.stopAnimating()
        if webURL?.absoluteString.contains("https") == false {
                 if let string = webURL?.absoluteString.replacingOccurrences(of: "http", with: "https") {
                     webURL = URL(string: string)
                     guard let url = webURL else { return }
                     webView.load(NSURLRequest(url: url) as URLRequest)
                 }
             }
    }
    
    public func webView(_ webView: WKWebView,
                        didReceive challenge: URLAuthenticationChallenge,
                        completionHandler: @escaping (URLSession.AuthChallengeDisposition,
        URLCredential?) -> Void) {
        guard let trust = challenge.protectionSpace.serverTrust else {return}
        let cred = URLCredential(trust: trust)
        completionHandler(.useCredential, cred)
    }
    
}
extension NewsWebViewController: WKUIDelegate {
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                        for navigationAction: WKNavigationAction,
                        windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    public func webView(_ webView: WKWebView,
                        runJavaScriptAlertPanelWithMessage message: String,
                        initiatedByFrame frame: WKFrameInfo,
                        completionHandler: @escaping () -> Void) {
    }
}
