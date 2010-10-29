//
// XPost: クロスサイトPOSTをFlashを通じて実現する
// copyright 2010 waco, released under the MIT license 
//
var xspost = function(){
  var _loadflag = false;
  var _player = null;
  var _name = null;
  this.post = function(url, params){
    if(!params) params = {};
    if(!params.data) params.data = {};
    if(params.success) this.success = params.success;
    if(params.failure) this.failure = params.failure;

    if(!_loadflag){
      this.failure();
      return;
    }
    _player.xspost(url, params.data);
  }
  this.ready = function(){
    _loadflag = true;
    _player = navigator.appName.indexOf("Microsoft") != -1 ? window[_name] : document[_name];
  }
  this.embed = function(path, name){
    _name = name ? name : 'externalXspost'

    var code = '<object id="'+_name+'" width="0" height="0" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">'+
    '<param name="allowScriptAccess" value="always" />'+
    '<param name="src" value="'+path+'" />'+
    '<param name="flashvars" value="ready=xspost.ready&success=xspost.success&failure=xspost.failure&response=xspost.response" />'+
    '<embed src='+path+' name="'+_name+'" allowScriptAccess="always" width="0" height="0"'+
    '  flashvars="ready=xspost.ready&success=xspost.success&failure=xspost.failure&response=xspost.response"></embed>'+
    '</object>'
    document.write(code);
  }

  this.success = function(){
  }
  this.failure = function(){
  }
  this.response = function(status){
  }

  return this;
}();

