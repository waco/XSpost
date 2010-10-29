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
    private var _successFunction:String;
    private var _failureFunction:String;
    private var _responseFunction:String;

    function Xspost() {
      var flashvars:Object = LoaderInfo(this.root.loaderInfo).parameters;

      //postするメソッドを外部jsから呼び出せる用にする
      ExternalInterface.addCallback("xspost", xspost);

      //flashが使用可能になったことを知らせるためのコールバック
      var ready:String = flashvars["ready"];
      if(ready) ExternalInterface.call(ready);

      _successFunction = flashvars["success"];
      _failureFunction= flashvars["failure"];
      _responseFunction = flashvars["response"];
    }

    public function xspost(url:String, data:String):void{
      var request:URLRequest = new URLRequest();
      request.url = url;
      request.data = data;
      request.method = URLRequestMethod.POST;

      var loader:URLLoader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, completeHandler);
      loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
      loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
      loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, HTTPStatusHandler);

      try{
        loader.load(request);
      }
      catch(e:Error){
        failure();
      }
    }

    // event handlaers
    private function completeHandler(event:Event):void{
      success();
    }
    private function ioErrorHandler(event:IOErrorEvent):void{
      failure();
    }
    private function securityErrorHandler(event:SecurityErrorEvent):void{
      failure();
    }
    private function HTTPStatusHandler(event:HTTPStatusEvent):void{
      response(String(event.status));
    }

    // callback functions
    private function success():void{
      if(_successFunction) ExternalInterface.call(_successFunction);
    }
    private function failure():void{
      if(_failureFunction) ExternalInterface.call(_failureFunction);
    }
    private function response(status:String):void{
      if(_responseFunction) ExternalInterface.call(_responseFunction, status);
    }
  }
}
