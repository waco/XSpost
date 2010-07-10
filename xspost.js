//
// XSPost: クロスサイトPOSTをFlashを通じて実現する
// copyright 2010 waco, released under the MIT license 
//
var xspost = function(){
  var _player = null;
  var _name = null;
  var _successFunctions = {};
  var _failureFunctions = {};
  var _idCounter = 0;

  this.post = function(url, params){
    id = _idCounter++;
    if(!params) params = {};
    if(!params.data) params.data = {};
    if(params.success) _successFunctions[id]= params.success;
    if(params.failure) _failureFunctions[id]= params.failure;

    if(!_player){
      this.failure(id);
      return;
    }
    try{
      _player.xspost(url, params.data, id);
    }
    catch(e){
      console.log(e);
    }
  }
  this.ready = function(){
    _player = navigator.appName.indexOf("Microsoft") != -1 ? window[_name] : document[_name];
  }
  this.embed = function(path, name){
    _name = name ? name : 'externalXspost'

    var fnOld = window.onload;
    window.onload = function(){
      if(typeof fnOld == "function") fnOld();
      var div = document.createElement("div");
      document.body.appendChild(div);
      div.setAttribute("id", "xspost");
      div.innerHTML =
        '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+
        '  width="0" height="0" id="'+_name+'">'+
        '  <param name="movie" value="'+path+'" />'+
        '  <param name="allowScriptAccess" value="always" />'+
        '  <embed src="'+path+'" name="'+_name+'" allowScriptAccess="always" '+
        '    width="0" height="0" />'+
        '</object>';
    }
  }

  this.success = function(id){
    _successFunctions[id]();
    delete _successFunctions[id];
  }
  this.failure = function(id){
    _failureFunctions[id]();
    delete _failureFunctions[id];
  }

  return this;
}();

