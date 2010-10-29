//
// XPost: クロスサイトPOSTをFlashを通じて実現する
// copyright 2010 waco, released under the MIT license 
//
var xspost = function(){
  var _loadflag = false;
  var _player = null;
  var _name = null;
  var _flashObject = null;
  this.post = function(url, params){
    if(!params) params = {};
    if(!params.data) params.data = {};
    if(params.success) this.success = params.success;
    if(params.failure) this.failure = params.failure;

    if(!_loadflag){
      this.failure();
      return;
    }
    try{
    _player.xspost(url, params.data);
    }
    catch(e){
      alert(e);
    }
  }
  this.ready = function(){
    _loadflag = true;
    _player = navigator.appName.indexOf("Microsoft") != -1 ? window[_name] : document[_name];
  }
  this.embed = function(path, name){
    _name = name ? name : 'externalXspost'
    var flashvars = "ready=xspost.ready&success=xspost.success&failure=xspost.failure&response=xspost.response"

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
        '  <param name="flashvars" value="'+flashvars+'" />'+
        '  <param name="allowScriptAccess" value="always" />'+
        '  <embed src="'+path+'" name="'+_name+'" allowScriptAccess="always" '+
        '    width="0" height="0" flashvars="'+flashvars+'"/>'+
        '</object>';
    }
  }

  this.success = function(){
  }
  this.failure = function(){
  }
  this.response = function(status){
  }

  return this;
}();

