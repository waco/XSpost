/*
 * XPost: クロスサイトPOSTをFlashを通じて実現する
 * copyright 2010 waco, released under the MIT license 
 */

package {
  import flash.display.Sprite;
  import flash.display.LoaderInfo;
  import flash.external.ExternalInterface;
  import flash.net.*;
  import flash.events.*;
 
  public class Xspost extends Sprite {
    private var successFunction:String;
    private var failureFunction:String;

    function Xspost() {
      //postするメソッドを外部jsから呼び出せる用にする
      ExternalInterface.addCallback("xspost", xspost);
      var flashvars:Object = LoaderInfo(this.root.loaderInfo).parameters;

      //flashが使用可能になったことを知らせるためのコールバック
      var ready:String = flashvars["ready"];
      if(ready) ExternalInterface.call(ready);

      successFunction = flashvars["success"];
      failureFunction = flashvars["failure"];
    }
 
    public function xspost(url:String, data:String):void{
      var request:URLRequest = new URLRequest();
      request.url = url;
      request.data = data;
      request.method = URLRequestMethod.POST;

      var loader:URLLoader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, success);
      loader.addEventListener(IOErrorEvent.IO_ERROR, failure);
      loader.load(request);
    }

    private function success(event:Event):void{
      if(successFunction) ExternalInterface.call(successFunction);
    }

    private function failure(error:IOErrorEvent):void{
      if(failureFunction) ExternalInterface.call(failureFunction);
    }
  }
}
