# Web Scraping Tool

Web Scraping for iOS App.

## Scraping for Example
 - Find automatically stock status in EC. ex) Nintendo Switch
 - Check for start booking in EC. ex) Supreme

## Usage
1. Set Website URL and Search Keyword.  
2. Run Scraping. Do not close this app while scraping. It need to allow Push Notifications.  
3. It will notify to you when matching keyword on Website.

It is necessary to known the keyword you want to detect, such as "in stock" or "Pre-order".

<p width="100%">
  <img src="https://raw.githubusercontent.com/256hax/swiftui-web-scraping-tool/master/docs/screen_shot/scraping_list_with_device.png" width="33%">
  <img src="https://raw.githubusercontent.com/256hax/swiftui-web-scraping-tool/master/docs/screen_shot/add_scraping_with_device.png" width="33%"> 
  <img src="https://raw.githubusercontent.com/256hax/swiftui-web-scraping-tool/master/docs/screen_shot/run_scraping_with_device.png" width="33%">
</p>

## Features
- Web Scraping
- Search Keyword support Regular Expression
- Push Notifications when matching keyword

## Notes
- It need to allow Push Notifications.
- Scraping frequency is fixed. It will prevent overload Website.
- Some Website prohibit scraping. Check terms and conditions before Scraping.
- Search Keyword finding HTML source. It will be matching keyword even if the keyword is not displayed on the screen. In that case, check HTML source, then try adjusting it with a regular expression.

---

# For Developers

## Technologies
- Overview: Vanilla SwiftUI
- Main Interface: SwiftUI
- Life Cycle: UIKit App Delegate
- DB: Core Data

## TODO
- Support XCTest

---

# For Japanese

Webサイトを自動的に巡回するウェブスクレイピングツールです。

## 利用シーン
- すぐに売り切れてしまう人気商品の入荷の自動チェック　（例）Nintendo Switchなど
- 商品の予約受付が開始されたかどうかの自動チェック　（例）Supremeの商品など

## 使い方
1. スクレイピング（巡回）したいWebサイトのURLと検出したいキーワードを設定します。
2. スクレイピングを実行します。スクレイピング中はこのアプリを閉じないでください。アプリを閉じると停止されます。また、通知の許可設定も必要です。
3. 定期的にスクレイピングを実行し、Webサイト上にキーワードが表示されると、アプリが通知します。

「在庫あり」または「予約はこちら」などの検出したいキーワードを知っている必要があります。

## 機能
- スクレイピング（自動巡回）
- キーワードは正規表現に対応
- 検出時のプッシュ通知

## 注意事項
- スクレイピングを実行すると、通知の許可設定が表示されるため、許可をお願いします。
- スクレイピングする頻度はあらかじめ固定しています。これは対象のWebサイトに意図せず負荷をかけないようにするためです。
- スクレイピングするWebサイトによっては、禁止されている場合があるため、調べてからご利用ください。
- 検出キーワードは、厳密にはHTMLソース内を探します。そのため、Webサイト上にキーワードが表示されていなくても、キーワード検出される場合があります。その場合は、HTMLソースを直接見ながら、正規表現でうまく調整してみてください。