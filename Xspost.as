/*
 * XSPost: クロスサイトPOSTをFlashを通じて実現する
 * copyright 2010 waco, released under the MIT license 
 */

package {
  import flash.display.Sprite;
  import flash.external.ExternalInterface;
  import flash.net.*;
  import flash.events.*;
 
  public class Xspost extends Sprite {
    private var _readyFunction:String = "xspost.ready";
    private var _successFunction:String = "xspost.success";
    private var _failureFunction:String = "xspost.failure";

    function Xspost() {
      //postするメソッドを外部jsから呼び出せる用にする
      ExternalInterface.addCallback("xspost", xspost);

      //flashが使用可能になったことを知らせるためのコールバック
      ExternalInterface.call(_readyFunction);
    }

    public function xspost(url:String, data:String, id:int):void{
      var request:URLRequest = new URLRequest();
      request.url = url;
      request.data = data;
      request.method = URLRequestMethod.POST;

      var loader:URLLoader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, successHandler(id));
      loader.addEventListener(IOErrorEvent.IO_ERROR, failureHandler(id));
      loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, failureHandler(id));

      try{
        loader.load(request);
      }
      catch(e:Error){
        failure(id);
      }
    }

    // event handlaers
    private function successHandler(id:int):Function{
      return function(event:Event):void{ success(id) }
    }
    private function failureHandler(id:int):Function{
      return function(event:Event):void{ failure(id) }
    }

    // callback functions
    private function success(id:int):void{
      ExternalInterface.call(_successFunction, id);
    }
    private function failure(id:int):void{
      ExternalInterface.call(_failureFunction, id);
    }
  }
}
