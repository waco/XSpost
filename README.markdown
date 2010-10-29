XSPost
======

クロスサイトPOSTをFlashを通じて実現する

Version
-------

+ 0.0.1 2010/10/14 リリース
+ 0.0.2 2010/10/29 JavascriptのAPIも書いた

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

+ data: 送信する内容。クエリ文字列ではなく、javascriptオブジェクト
+ success: 送信成功時のコールバック関数
+ failure: 送信失敗時のコールバック関数
+ response: 送信完了時のステータスコードを取得する。ただし、対応しているブラウザがほとんどない

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

スレッドセーフな感じではないので、同時に複数のpostをする場合、
コールバック関数が上書きされる可能性があります。

動作検証済みブラウザ

+ Mac
    + Firefox 3.6.12 with FlashPlayer 10.1.85.3
    + Safari 5.0.2 with FlashPlayer 10.1.85.3

+ Windows 7
    + Internet Explorer 8.0.7600 with FlashPlayer 10.0.45.2
    + Firefox 3.6.3 with FlashPlayer 10.1.85.3
    + Google Chrome 7.0.517 with FlashPlayer 10.1.85.3

Todo
----

+ スレッドセーフな感じにする。
+ embed関数をきれいにする。
+ jqueryのpostと同等の機能を作る。

 
copyright 2010 waco, released under the MIT license 
