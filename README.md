# WebViewLocalStorage
A small project to demonstrate the use of localStorage and `WKWebView`s.

## A few notes:
* This app shows off using a `NSHTTPCookieStorage` shared across a group (so multiple apps could, conceivably, share the same cookies)
* The app also allows arbitrary loads so you can test with URLs that may not be served via https
* To really test the persistence of your cookies you'll need to put the right.html and left.html files somewhere interesting and replace the `http://your.website.example.com/` with the URL for those files
* You can use either `NSURLSession`s to load the data into your `WKWebView` or `NSURLRequest`s, they both work equally well, when it comes to persisting cookie and localStorage data
* NB. You also need to make sure you set an expiry date on your cookies, otherwise they'll be treated as session cookies only and be cleared on app restart