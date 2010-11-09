XSPost
======

クロスサイトPOSTをFlashを通じて実現する

Version
-------

+ 0.0.1 2010/10/14 リリース
+ 0.0.2 2010/10/29 JavascriptのAPIも書いた
+ 0.0.3 2010/10/30 コールバック機能の実装

Usage 
-----

crossdomain.xmlをPOSTするサーバのルートに設置します。
    <cross-domain-policy>
    <allow-access-from domain="*" />
    </cross-domain-policy>

Xspost.swfを読み込むためにHTMLに記述します。
記述する場所はどこでも構いません。
    <script type="text/javascript">
    xspost.embed('Xspost.swf');
    </script>

Javascriptからpostします。
xspost.post(url, params)を呼び出します。
paramsには以下の値を指定することができます。

+ data: 送信する内容。クエリ文字列。
+ success: 送信成功時のコールバック関数
+ failure: 送信失敗時のコールバック関数

サンプルコード
    <script type="text/javascript">
    $('form').bind('submit', function(){
      xspost.post('http://example.com/', {
        data: $('form').serialize(),
        success: function(){ alert('success'); },
        failure: function(){ alert('failure'); }
      });
      return false;
    });
    </script>

Attention
---------

xspostをインスタンス名として使えません。

Flashを読み込むのは少し時間が掛かるため、時間をおいてからpostする必要があります。

動作検証済みブラウザ

+ Mac
    + Firefox 3.6.12 with FlashPlayer 10.1.85
    + Safari 5.0.2 with FlashPlayer 10.1.85

+ Windows 7
    + Internet Explorer 8.0.7600 with FlashPlayer 10.0.45
    + Firefox 3.6.3 with FlashPlayer 10.1.85
    + Google Chrome 7.0.517 with FlashPlayer 10.1.85

+ Windows XP
    + Internet Explorer 8.0.6001 with FlashPlayer 9.0.47
    + Firefox 3.6.3 with FlashPlayer 10.0.42
    + Google Chrome 7.0.517 with FlashPlayer 10.0.42
    + Safari 5.0.2 with FlashPlayer 10.0.42
    + Opera 10.0 with FlashPlayer 10.0.42

Todo
----

+ jqueryのpostと同等の機能を作る。
+ crossdomain.xmlの位置を指定できる機能を作る。

 
copyright 2010 waco, released under the MIT license 
