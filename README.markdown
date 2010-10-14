XPost
=====


クロスサイトPOSTをFlashを通じて実現する

Usage 
-----

crossdomain.xmlをPOSTするサーバのルートに設置します
    <cross-domain-policy>
    <allow-access-from domain="*" />
    </cross-domain-policy>

Xspost.swfをHTMLに埋め込みます
flashvarsにはコールバック関数を指定することができます
  ready: Xspostが使用可能時
  success: POST成功時
  failure: POST失敗時

    <object id="externalXp" width="0" height="0" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">
    <param name="allowScriptAccess" value="always" />
    <param name="src" value="Xspost.swf" />
    <param name="flashvars" value="ready=xspost.ready&success=xspost.success&failure=xspost.failure" />
    <embed src='Xp.swf' name="externalXp" allowScriptAccess="always" width="0" height="0"
      flashvars="ready=xspost.ready&success=xspost.success&failure=xspost.failure"></embed>
    </object>

JavascriptからXpostを実行します
    var id = "externalXp";
    var player = navigator.appName.indexOf("Microsoft") != -1 ? window[id] : document[id];
    player.xspost('http://example.com/', $("form").serialize());
 
copyright 2010 waco, released under the MIT license 



