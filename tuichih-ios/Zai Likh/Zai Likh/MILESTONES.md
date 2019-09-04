#  <#Title#>
"action_settings" = "設定";


Lemma boundary highlighting
WebKit WKWebView
word list: animation rounded rectangle

Flask wsig

http://jsfiddle.net/wUgXk/1/
<color "background-color">#202020</color>



<textarea name="Text1" cols="40" rows="5"></textarea>



@font-face {
  font-family: Kaiti;
  src: url(AdobeKaitiStd-Regular.otf);
}

body {
    background: #202020;
}

textarea {
  height: 400px;
    background: #1A1A1A;
    border-radius: 2em;
    border: none;
    margin: 2em;
    padding: 0.8em;
    
    color: #A2A2A2;
    font-family: Kaiti;
    font-size: 1.1em;
    padding-left: 1.5em;
    
    outline: none;
    box-shadow: 0 4px 6px -5px hsl(0, 0%, 40%), inset 0px 4px 6px -5px hsl(0, 0%, 2%)
}



https://medium.com/@masonchang1991/wkwebview%E4%BB%8B%E7%B4%B9%E8%88%87javascript%E8%B3%87%E6%96%99%E4%B8%B2%E6%8E%A5-5588936e9e39
    func loadWebUrl() {
        let url = URL(string: "https://google.com.tw")
        let request = URLRequest(url: url!)
        testWebView.load(request)
    }

    lazy var testWebView: WKWebView = { [unowned self] in
      let wkWebView = WKWebView(frame: self.view.frame)
      wkWebView.uiDelegate = self
      wkWebView.navigationDelegate = self
      return wkWebView
    }()

        func sendMessageToWeb() {
        let message: String = "I'm come from iOS App"
        wkWebView.evaluateJavaScript("callJSFromApp('\(message)')"), completionHandler: {
            (object, error) in
            print("completed with ob \(object)")
            print("completed with er \(error)")
        })
    }

    func sendDicationaryToWeb() {
        let userstateDic: [String: Any] = ["vip": false,
                                           "token": "123"]
        // Convert swift dictionary into encoded json
        do {
            let serializedData = try! JSONSerialization.data(withJSONObject: userstateDic, options: .prettyPrinted)
            let encodedData = serializedData.base64EncodedString(options: .endLineWithLineFeed)
            // This WKWebView API to calls userStateFromApp function defined in js
            wkWebView.evaluateJavaScript("dicationaryFromApp('\(encodedData)')", completionHandler: { (object, error) in
                print("completed with object, \(object)")
                print("completed with error, \(error)")
            })
        }
    }

    class ScriptMessageHandler: NSObject {
        // 設置代理，把抓到的JS事件轉發給代理處理
        weak var delegate: WKScriptMessageHandler?
    }

    extension ScriptMessageHandler: WKScriptMessageHandler {
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let target = delegate {
                target.userContentController(userContentController, didReceive: message)
            }
        }
    }

        lazy var wkWebView: WKWebView = {
        [unowned self] in
        let wkWebView = WKWebView()
        //取web默認的配置選項
        let configuration = wkWebView.configuration
        //指定處理JS事件的對象，該對象必須遵守WKScripMessageHandler協議
        let handler = ScriptMessageHandler()
        handler.delegate = self
        // 接收網頁會丟出來的任務名 handler是誰去接這個
        configuration.userContentController.add(handler, name: Task.navigationTask.rawValue)
        return wkWebView
    }()

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let task = Task(rawValue: message.name) {
            switch task {
            case .navigationTask:
                // 轉換JS丟過來的參數型別從 Any 到我們要的型別
                if let dic = message.body as? [String: Any] {
                    handleMessage(dic)
                }
            }
        }
    }

        fileprivate func handleMessage(_ dic: [String: Any]) {
        guard let action = dic["navigation"] as? String else { return }
        print(action)
    }
