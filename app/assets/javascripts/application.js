// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jwplayer
//= require cookie
//= require form
//= require ICanHaz.min.js
//= require jquery_ujs
//= require swfobject
//= require TweenMax.min
//= require track_links


// Avoid `console` errors in browsers that lack a console.
if (!(window.console && console.log)) {
    (function() {
        var noop = function() {};
        var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
        var length = methods.length;
        var console = window.console = {};
        while (length--) {
            console[methods[length]] = noop;
        }
    }());
}

/*
 * SimpleModal 1.4.3 - jQuery Plugin
 * http://simplemodal.com/
 * Copyright (c) 2012 Eric Martin
 * Licensed under MIT and GPL
 * Date: Sat, Sep 8 2012 07:52:31 -0700
 */
(function(b){"function"===typeof define&&define.amd?define(["jquery"],b):b(jQuery)})(function(b){var j=[],l=b(document),m=b.browser.msie&&6===parseInt(b.browser.version)&&"object"!==typeof window.XMLHttpRequest,o=b.browser.msie&&7===parseInt(b.browser.version),n=null,k=b(window),h=[];b.modal=function(a,d){return b.modal.impl.init(a,d)};b.modal.close=function(){b.modal.impl.close()};b.modal.focus=function(a){b.modal.impl.focus(a)};b.modal.setContainerDimensions=function(){b.modal.impl.setContainerDimensions()};
b.modal.setPosition=function(){b.modal.impl.setPosition()};b.modal.update=function(a,d){b.modal.impl.update(a,d)};b.fn.modal=function(a){return b.modal.impl.init(this,a)};b.modal.defaults={appendTo:"body",focus:!0,opacity:50,overlayId:"simplemodal-overlay",overlayCss:{},containerId:"simplemodal-container",containerCss:{},dataId:"simplemodal-data",dataCss:{},minHeight:null,minWidth:null,maxHeight:null,maxWidth:null,autoResize:!1,autoPosition:!0,zIndex:1E3,close:!0,closeHTML:'<a class="modalCloseImg" title="Close"></a>',
closeClass:"simplemodal-close",escClose:!0,overlayClose:!1,fixed:!0,position:null,persist:!1,modal:!0,onOpen:null,onShow:null,onClose:null};b.modal.impl={d:{},init:function(a,d){if(this.d.data)return!1;n=b.browser.msie&&!b.support.boxModel;this.o=b.extend({},b.modal.defaults,d);this.zIndex=this.o.zIndex;this.occb=!1;if("object"===typeof a){if(a=a instanceof b?a:b(a),this.d.placeholder=!1,0<a.parent().parent().size()&&(a.before(b("<span></span>").attr("id","simplemodal-placeholder").css({display:"none"})),
this.d.placeholder=!0,this.display=a.css("display"),!this.o.persist))this.d.orig=a.clone(!0)}else if("string"===typeof a||"number"===typeof a)a=b("<div></div>").html(a);else return alert("SimpleModal Error: Unsupported data type: "+typeof a),this;this.create(a);this.open();b.isFunction(this.o.onShow)&&this.o.onShow.apply(this,[this.d]);return this},create:function(a){this.getDimensions();if(this.o.modal&&m)this.d.iframe=b('<iframe src="javascript:false;"></iframe>').css(b.extend(this.o.iframeCss,
{display:"none",opacity:0,position:"fixed",height:h[0],width:h[1],zIndex:this.o.zIndex,top:0,left:0})).appendTo(this.o.appendTo);this.d.overlay=b("<div></div>").attr("id",this.o.overlayId).addClass("simplemodal-overlay").css(b.extend(this.o.overlayCss,{display:"none",opacity:this.o.opacity/100,height:this.o.modal?j[0]:0,width:this.o.modal?j[1]:0,position:"fixed",left:0,top:0,zIndex:this.o.zIndex+1})).appendTo(this.o.appendTo);this.d.container=b("<div></div>").attr("id",this.o.containerId).addClass("simplemodal-container").css(b.extend({position:this.o.fixed?
"fixed":"absolute"},this.o.containerCss,{display:"none",zIndex:this.o.zIndex+2})).append(this.o.close&&this.o.closeHTML?b(this.o.closeHTML).addClass(this.o.closeClass):"").appendTo(this.o.appendTo);this.d.wrap=b("<div></div>").attr("tabIndex",-1).addClass("simplemodal-wrap").css({height:"100%",outline:0,width:"100%"}).appendTo(this.d.container);this.d.data=a.attr("id",a.attr("id")||this.o.dataId).addClass("simplemodal-data").css(b.extend(this.o.dataCss,{display:"none"})).appendTo("body");this.setContainerDimensions();
this.d.data.appendTo(this.d.wrap);(m||n)&&this.fixIE()},bindEvents:function(){var a=this;b("."+a.o.closeClass).bind("click.simplemodal",function(b){b.preventDefault();a.close()});a.o.modal&&a.o.close&&a.o.overlayClose&&a.d.overlay.bind("click.simplemodal",function(b){b.preventDefault();a.close()});l.bind("keydown.simplemodal",function(b){a.o.modal&&9===b.keyCode?a.watchTab(b):a.o.close&&a.o.escClose&&27===b.keyCode&&(b.preventDefault(),a.close())});k.bind("resize.simplemodal orientationchange.simplemodal",
function(){a.getDimensions();a.o.autoResize?a.setContainerDimensions():a.o.autoPosition&&a.setPosition();m||n?a.fixIE():a.o.modal&&(a.d.iframe&&a.d.iframe.css({height:h[0],width:h[1]}),a.d.overlay.css({height:j[0],width:j[1]}))})},unbindEvents:function(){b("."+this.o.closeClass).unbind("click.simplemodal");l.unbind("keydown.simplemodal");k.unbind(".simplemodal");this.d.overlay.unbind("click.simplemodal")},fixIE:function(){var a=this.o.position;b.each([this.d.iframe||null,!this.o.modal?null:this.d.overlay,
"fixed"===this.d.container.css("position")?this.d.container:null],function(b,f){if(f){var g=f[0].style;g.position="absolute";if(2>b)g.removeExpression("height"),g.removeExpression("width"),g.setExpression("height",'document.body.scrollHeight > document.body.clientHeight ? document.body.scrollHeight : document.body.clientHeight + "px"'),g.setExpression("width",'document.body.scrollWidth > document.body.clientWidth ? document.body.scrollWidth : document.body.clientWidth + "px"');else{var c,e;a&&a.constructor===
Array?(c=a[0]?"number"===typeof a[0]?a[0].toString():a[0].replace(/px/,""):f.css("top").replace(/px/,""),c=-1===c.indexOf("%")?c+' + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"':parseInt(c.replace(/%/,""))+' * ((document.documentElement.clientHeight || document.body.clientHeight) / 100) + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"',a[1]&&(e="number"===typeof a[1]?
a[1].toString():a[1].replace(/px/,""),e=-1===e.indexOf("%")?e+' + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"':parseInt(e.replace(/%/,""))+' * ((document.documentElement.clientWidth || document.body.clientWidth) / 100) + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"')):(c='(document.documentElement.clientHeight || document.body.clientHeight) / 2 - (this.offsetHeight / 2) + (t = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"',
e='(document.documentElement.clientWidth || document.body.clientWidth) / 2 - (this.offsetWidth / 2) + (t = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft) + "px"');g.removeExpression("top");g.removeExpression("left");g.setExpression("top",c);g.setExpression("left",e)}}})},focus:function(a){var d=this,a=a&&-1!==b.inArray(a,["first","last"])?a:"first",f=b(":input:enabled:visible:"+a,d.d.wrap);setTimeout(function(){0<f.length?f.focus():d.d.wrap.focus()},
10)},getDimensions:function(){var a="undefined"===typeof window.innerHeight?k.height():window.innerHeight;j=[l.height(),l.width()];h=[a,k.width()]},getVal:function(a,b){return a?"number"===typeof a?a:"auto"===a?0:0<a.indexOf("%")?parseInt(a.replace(/%/,""))/100*("h"===b?h[0]:h[1]):parseInt(a.replace(/px/,"")):null},update:function(a,b){if(!this.d.data)return!1;this.d.origHeight=this.getVal(a,"h");this.d.origWidth=this.getVal(b,"w");this.d.data.hide();a&&this.d.container.css("height",a);b&&this.d.container.css("width",
b);this.setContainerDimensions();this.d.data.show();this.o.focus&&this.focus();this.unbindEvents();this.bindEvents()},setContainerDimensions:function(){var a=m||o,d=this.d.origHeight?this.d.origHeight:b.browser.opera?this.d.container.height():this.getVal(a?this.d.container[0].currentStyle.height:this.d.container.css("height"),"h"),a=this.d.origWidth?this.d.origWidth:b.browser.opera?this.d.container.width():this.getVal(a?this.d.container[0].currentStyle.width:this.d.container.css("width"),"w"),f=this.d.data.outerHeight(!0),
g=this.d.data.outerWidth(!0);this.d.origHeight=this.d.origHeight||d;this.d.origWidth=this.d.origWidth||a;var c=this.o.maxHeight?this.getVal(this.o.maxHeight,"h"):null,e=this.o.maxWidth?this.getVal(this.o.maxWidth,"w"):null,c=c&&c<h[0]?c:h[0],e=e&&e<h[1]?e:h[1],i=this.o.minHeight?this.getVal(this.o.minHeight,"h"):"auto",d=d?this.o.autoResize&&d>c?c:d<i?i:d:f?f>c?c:this.o.minHeight&&"auto"!==i&&f<i?i:f:i,c=this.o.minWidth?this.getVal(this.o.minWidth,"w"):"auto",a=a?this.o.autoResize&&a>e?e:a<c?c:a:
g?g>e?e:this.o.minWidth&&"auto"!==c&&g<c?c:g:c;this.d.container.css({height:d,width:a});this.d.wrap.css({overflow:f>d||g>a?"auto":"visible"});this.o.autoPosition&&this.setPosition()},setPosition:function(){var a,b;a=h[0]/2-this.d.container.outerHeight(!0)/2;b=h[1]/2-this.d.container.outerWidth(!0)/2;var f="fixed"!==this.d.container.css("position")?k.scrollTop():0;this.o.position&&"[object Array]"===Object.prototype.toString.call(this.o.position)?(a=f+(this.o.position[0]||a),b=this.o.position[1]||
b):a=f+a;this.d.container.css({left:b,top:a})},watchTab:function(a){if(0<b(a.target).parents(".simplemodal-container").length){if(this.inputs=b(":input:enabled:visible:first, :input:enabled:visible:last",this.d.data[0]),!a.shiftKey&&a.target===this.inputs[this.inputs.length-1]||a.shiftKey&&a.target===this.inputs[0]||0===this.inputs.length)a.preventDefault(),this.focus(a.shiftKey?"last":"first")}else a.preventDefault(),this.focus()},open:function(){this.d.iframe&&this.d.iframe.show();b.isFunction(this.o.onOpen)?
this.o.onOpen.apply(this,[this.d]):(this.d.overlay.show(),this.d.container.show(),this.d.data.show());this.o.focus&&this.focus();this.bindEvents()},close:function(){if(!this.d.data)return!1;this.unbindEvents();if(b.isFunction(this.o.onClose)&&!this.occb)this.occb=!0,this.o.onClose.apply(this,[this.d]);else{if(this.d.placeholder){var a=b("#simplemodal-placeholder");this.o.persist?a.replaceWith(this.d.data.removeClass("simplemodal-data").css("display",this.display)):(this.d.data.hide().remove(),a.replaceWith(this.d.orig))}else this.d.data.hide().remove();
this.d.container.hide().remove();this.d.overlay.hide();this.d.iframe&&this.d.iframe.hide().remove();this.d.overlay.remove();this.d={}}}}});


// IE8 Hack for :before and :after Pseudo elements
(function($){

  var patterns = {
    text: /^['"]?(.+?)["']?$/,
    url: /^url\(["']?(.+?)['"]?\)$/
  };

  function clean(content) {
    if(content && content.length) {
      var text = content.match(patterns.text)[1],
        url = text.match(patterns.url);
      return url ? '<img src="' + url[1] + '" />': text;
    }
  }

  function inject(prop, elem, content) {
    if(prop != 'after') prop = 'before';
    if(content = clean(elem.currentStyle[prop])) {
      $(elem)[prop == 'before' ? 'prepend' : 'append'](
        $(document.createElement('span')).addClass(prop).html(content)
      );
    }
  }

  $.pseudo = function(elem) {
    inject('before', elem);
    inject('after', elem);
    elem.runtimeStyle.behavior = null;
  };
  
  if(document.createStyleSheet) {
    var o = document.createStyleSheet(null, 0);
    o.addRule('.dummy','display: static;');
    o.cssText = 'html, head, head *, body, *.before, *.after, *.before *, *.after * { behavior: none; } * { behavior: expression($.pseudo(this)); }';
  }

})(jQuery);

/*!
 * NWMatcher 1.2.5 - Fast CSS3 Selector Engine
 * Copyright (C) 2007-2012 Diego Perini
 * See http://nwbox.com/license
 */

(function(t){var ct='nwmatcher-1.2.5',l=typeof exports=='object'?exports:((t.NW||(t.NW={}))&&(t.NW.Dom||(t.NW.Dom={}))),i=t.document,m=i.documentElement,K=[].slice,bJ={}.toString,bk,W,G,X,p,bl,bm,bn,bo,L='[#.:]?',bp='([~*^$|!]?={1})',x='[\\x20\\t\\n\\r\\f]*',bq='[\\x20]|[>+~][^>+~]',br='[-+]?\\d*n?[-+]?\\d*',Y='"[^"]*"'+"|'[^']*'",bK='\\([^()]+\\)|\\(.*\\)',bL='\\{[^{}]+\\}|\\{.*\\}',bM='\\[[^[\\]]*\\]|\\[.*\\]',Z='\\[.*\\]|\\(.*\\)|\\{.*\\}',q='(?:[-\\w]|[^\\x00-\\xa0]|\\\\.)',B='(?:-?[_a-zA-Z]{1}[-\\w]*|[^\\x00-\\xa0]+|\\\\.+)+',bs='('+Y+'|'+B+')',C=x+'('+q+'+:?'+q+'+)'+x+'(?:'+bp+x+bs+')?'+x,bN=C.replace(bs,'([\\x22\\x27]*)((?:\\\\?.)*?)\\3'),M='((?:'+br+'|'+Y+'|'+L+'|'+q+'+|\\['+C+'\\]|\\(.+\\)|'+x+'|,)+)',bO='.+',ba='(?=[\\x20\\t\\n\\r\\f]*[^>+~(){}<>])(\\*|(?:'+L+B+')|'+bq+'|\\['+C+'\\]|\\('+M+'\\)|\\{'+bO+'\\}|,)+',bP=ba.replace(M,'.*'),N=new RegExp(ba,'g'),O=new RegExp('^'+x+'|'+x+'$','g'),bQ=new RegExp('^((?!:not)('+L+'|'+B+'|\\([^()]*\\))+|\\['+C+'\\])$'),bb=new RegExp('([^,\\\\\\[\\]]+|'+bM+'|'+bK+'|'+bL+'|\\\\.)+','g'),bR=new RegExp('(\\['+C+'\\]|\\('+M+'\\)|[^\\x20>+~]|\\\\.)+','g'),bt=/[\x20\t\n\r\f]+/g,bu=new RegExp(B+'|^$'),z=(function(){var g=(i.appendChild+'').replace(/appendChild/g,'');return function(a,b){var d=a&&a[b]||false;return d&&typeof d!='string'&&g==(d+'').replace(new RegExp(b,'g'),'')}})(),bS=z(i,'hasFocus'),P=z(i,'querySelector'),bT=z(i,'getElementById'),bU=z(m,'getElementsByTagName'),Q=z(m,'getElementsByClassName'),bV=z(m,'getAttribute'),bW=z(m,'hasAttribute'),bv=(function(){var a=false,b=m.id;m.id='length';try{a=!!K.call(i.childNodes,0)[0]}catch(e){}m.id=b;return a})(),bw='nextElementSibling'in m&&'previousElementSibling'in m,bX=bT?(function(){var a=true,b='x'+String(+new Date),d=i.createElementNS?'a':'<a name="'+b+'">';(d=i.createElement(d)).name=b;m.insertBefore(d,m.firstChild);a=!!i.getElementById(b);m.removeChild(d);return a})():true,bx=bU?(function(){var a=i.createElement('div');a.appendChild(i.createComment(''));return!!a.getElementsByTagName('*')[0]})():true,by=Q?(function(){var a,b=i.createElement('div'),d='\u53f0\u5317';b.appendChild(i.createElement('span')).setAttribute('class',d+'abc '+d);b.appendChild(i.createElement('span')).setAttribute('class','x');a=!b.getElementsByClassName(d)[0];b.lastChild.className=d;return a||b.getElementsByClassName(d).length!=2})():true,bY=bV?(function(){var a=i.createElement('input');a.setAttribute('value',5);return a.defaultValue!=5})():true,bz=bW?(function(){var a=i.createElement('option');a.setAttribute('selected','selected');return!a.hasAttribute('selected')})():true,bZ=(function(){var a=i.createElement('select');a.appendChild(i.createElement('option'));return!a.firstChild.selected})(),bA,bB,y,n,bC=/opera/i.test(bJ.call(t.opera)),ca=bC&&parseFloat(opera.version())>=11,cb=P?(function(){var h=[],f=i.createElement('div'),c,k=function(a,b,d,g){var j=false;b.appendChild(d);try{j=b.querySelectorAll(a).length==g}catch(e){}while(b.firstChild){b.removeChild(b.firstChild)}return j};c=i.createElement('p');c.setAttribute('class','');k('[class^=""]',f,c,1)&&h.push('[*^$]=[\\x20\\t\\n\\r\\f]*(?:""|'+"'')");c=i.createElement('option');c.setAttribute('selected','selected');k(':checked',f,c,0)&&h.push(':checked');c=i.createElement('input');c.setAttribute('type','hidden');k(':enabled',f,c,1)&&h.push(':enabled',':disabled');c=i.createElement('link');c.setAttribute('href','x');k(':link',f,c,1)||h.push(':link');if(bz){h.push('\\[[\\x20\\t\\n\\r\\f]*(?:checked|disabled|ismap|multiple|readonly|selected|value)')}return h.length?new RegExp(h.join('|')):{'test':function(){return false}}})():true,cc=new RegExp('(?:\\[[\\x20\\t\\n\\r\\f]*class\\b|\\.'+B+')'),cd=new RegExp(!(bx&&by)?!bC?'^(?:\\*|[.#]?-?[_a-zA-Z]{1}'+q+'*)$':'^(?:\\*|#-?[_a-zA-Z]{1}'+q+'*)$':'^#?-?[_a-zA-Z]{1}'+q+'*$'),ce={'a':1,'A':1,'area':1,'AREA':1,'link':1,'LINK':1},cf={'checked':1,'disabled':1,'ismap':1,'multiple':1,'readonly':1,'selected':1},R={value:'defaultValue',checked:'defaultChecked',selected:'defaultSelected'},cg={'action':2,'cite':2,'codebase':2,'data':2,'href':2,'longdesc':2,'lowsrc':2,'src':2,'usemap':2},bD={'class':0,'accept':1,'accept-charset':1,'align':1,'alink':1,'axis':1,'bgcolor':1,'charset':1,'checked':1,'clear':1,'codetype':1,'color':1,'compact':1,'declare':1,'defer':1,'dir':1,'direction':1,'disabled':1,'enctype':1,'face':1,'frame':1,'hreflang':1,'http-equiv':1,'lang':1,'language':1,'link':1,'media':1,'method':1,'multiple':1,'nohref':1,'noresize':1,'noshade':1,'nowrap':1,'readonly':1,'rel':1,'rev':1,'rules':1,'scope':1,'scrolling':1,'selected':1,'shape':1,'target':1,'text':1,'type':1,'valign':1,'valuetype':1,'vlink':1},ch={'accept':1,'accept-charset':1,'alink':1,'axis':1,'bgcolor':1,'charset':1,'codetype':1,'color':1,'enctype':1,'face':1,'hreflang':1,'http-equiv':1,'lang':1,'language':1,'link':1,'media':1,'rel':1,'rev':1,'target':1,'text':1,'type':1,'vlink':1},D={},H={'=':"n=='%m'",'^=':"n.indexOf('%m')==0",'*=':"n.indexOf('%m')>-1",'|=':"(n+'-').indexOf('%m-')==0",'~=':"(' '+n+' ').indexOf(' %m ')>-1",'$=':"n.substr(n.length-'%m'.length)=='%m'"},E={ID:new RegExp('^\\*?#('+q+'+)|'+Z),TAG:new RegExp('^('+q+'+)|'+Z),CLASS:new RegExp('^\\*?\\.('+q+'+$)|'+Z)},u={spseudos:/^\:((root|empty|nth-)?(?:(first|last|only)-)?(child)?-?(of-type)?)(?:\(([^\x29]*)\))?(.*)/,dpseudos:/^\:(link|visited|target|lang|not|active|focus|hover|checked|disabled|enabled|selected)(?:\((["']*)(.*?(\(.*\))?[^'"()]*?)\2\))?(.*)/,attribute:new RegExp('^\\['+bN+'\\](.*)'),children:/^[\x20\t\n\r\f]*\>[\x20\t\n\r\f]*(.*)/,adjacent:/^[\x20\t\n\r\f]*\+[\x20\t\n\r\f]*(.*)/,relative:/^[\x20\t\n\r\f]*\~[\x20\t\n\r\f]*(.*)/,ancestor:/^[\x20\t\n\r\f]+(.*)/,universal:/^\*(.*)/,id:new RegExp('^#('+q+'+)(.*)'),tagName:new RegExp('^('+q+'+)(.*)'),className:new RegExp('^\\.('+q+'+)(.*)')},bE=function(a,b){var d=-1,g;if(!a.length&&Array.slice)return Array.slice(b);while((g=b[++d]))a[a.length]=g;return a},bF=function(a,b,d){var g=-1,j;while((j=b[++g])){if(false===d(a[a.length]=j)){break}}return a},F=function(b,d){var g,j=i;X=b;i=b.ownerDocument||b;if(d||j!==i){m=i.documentElement;n=i.createElement('DiV').nodeName=='DiV';y=!n&&typeof i.compatMode=='string'?i.compatMode.indexOf('CSS')<0:(function(){var a=i.createElement('div').style;return a&&(a.width=1)&&a.width=='1px'})();g=i.createElement('div');g.appendChild(i.createElement('p')).setAttribute('class','xXx');g.appendChild(i.createElement('p')).setAttribute('class','xxx');bA=!n&&Q&&y&&(g.getElementsByClassName('xxx').length!=2||g.getElementsByClassName('xXx').length!=2);bB=!n&&P&&y&&(g.querySelectorAll('[class~=xxx]').length!=2||g.querySelectorAll('.xXx').length!=2);o.CACHING&&l.setCache(true,i)}},bc=function(a,b){var d=-1,g=null;while((g=b[++d])){if(g.getAttribute('id')==a){break}}return g},I=!bX?function(a,b){a=a.replace(/\\/g,'');return b.getElementById&&b.getElementById(a)||bc(a,b.getElementsByTagName('*'))}:function(a,b){var d=null;a=a.replace(/\\/g,'');if(n||b.nodeType!=9){return bc(a,b.getElementsByTagName('*'))}if((d=b.getElementById(a))&&d.name==a&&b.getElementsByName){return bc(a,b.getElementsByName(a))}return d},ci=function(a,b){F(b||(b=i));return I(a,b)},cj=function(a,b){var d=a=='*',g=b,j=[],h=g.firstChild;d||(a=a.toUpperCase());while((g=h)){if(g.tagName>'@'&&(d||g.tagName.toUpperCase()==a)){j[j.length]=g}if((h=g.firstChild||g.nextSibling))continue;while(!h&&(g=g.parentNode)&&g!==b){h=g.nextSibling}}return j},A=!bx&&bv?function(a,b){return n||b.nodeType==11?cj(a,b):K.call(b.getElementsByTagName(a),0)}:function(a,b){var d=-1,g=d,j=[],h,f=b.getElementsByTagName(a);if(a=='*'){while((h=f[++d])){if(h.nodeName>'@')j[++g]=h}}else{while((h=f[++d])){j[d]=h}}return j},ck=function(a,b){F(b||(b=i));return A(a,b)},bG=function(a,b){return S('[name="'+a.replace(/\\/g,'')+'"]',b)},cl=function(a,b){var d=-1,g=d,j=[],h,f=A('*',b),c;a=' '+(y?a.toLowerCase():a).replace(/\\/g,'')+' ';while((h=f[++d])){c=n?h.getAttribute('class'):h.className;if(c&&c.length&&(' '+(y?c.toLowerCase():c).replace(bt,' ')+' ').indexOf(a)>-1){j[++g]=h}}return j},J=function(a,b){return(by||bA||n||!b.getElementsByClassName)?cl(a,b):K.call(b.getElementsByClassName(a.replace(/\\/g,'')),0)},cm=function(a,b){F(b||(b=i));return J(a,b)},bd='compareDocumentPosition'in m?function(a,b){return(a.compareDocumentPosition(b)&16)==16}:'contains'in m?function(a,b){return a!==b&&a.contains(b)}:function(a,b){while((b=b.parentNode)){if(b===a)return true}return false},bH=!bY?function(a,b){return a.getAttribute(b)||''}:function(a,b){b=b.toLowerCase();if(R[b]){return a[R[b]]||''}return(cg[b]?a.getAttribute(b,2)||'':cf[b]?a.getAttribute(b)?b:'':((a=a.getAttributeNode(b))&&a.value)||'')},be=!bz?function(a,b){return n?!!a.getAttribute(b):a.hasAttribute(b)}:function(a,b){b=b.toLowerCase();if(R[b]){return!!a[R[b]]}a=a.getAttributeNode(b);return!!(a&&(a.specified||a.nodeValue))},cn=function(a){a=a.firstChild;while(a){if(a.nodeType==3||a.nodeName>'@')return false;a=a.nextSibling}return true},co=function(a){return be(a,'href')&&ce[a.nodeName]},cp=function(a,b){var d=1,g=b?'nextSibling':'previousSibling';while((a=a[g])){if(a.nodeName>'@')++d}return d},cq=function(a,b){var d=1,g=b?'nextSibling':'previousSibling',j=a.nodeName;while((a=a[g])){if(a.nodeName==j)++d}return d},cr=function(a){for(var b in a){o[b]=!!a[b];if(b=='SIMPLENOT'){bf={};T={};bg={};U={};o['USE_QSAPI']=false;N=new RegExp(bP,'g')}else if(b=='USE_QSAPI'){o[b]=!!a[b]&&P;N=new RegExp(ba,'g')}}},r=function(a){a='SYNTAX_ERR: '+a+' ';if(o.VERBOSITY){if(typeof t.DOMException!='undefined'){throw{code:12,message:a}}else{throw new Error(12,a);}}else{if(t.console&&t.console.log){t.console.log(a)}else{t.status+=a}}},o={CACHING:false,SHORTCUTS:false,SIMPLENOT:true,USE_HTML5:false,USE_QSAPI:P,VERBOSITY:true},bh='r[r.length]=c[k];if(f&&false===f(c[k]))break;else continue main;',V=function(a,b,d){var g=typeof a=='string'?a.match(bb):a;typeof b=='string'||(b='');if(g.length==1){b+=bI(g[0],d?bh:'f&&f(k);return true;')}else{var j=-1,h={},f;while((f=g[++j])){f=f.replace(O,'');if(!h[f]&&(h[f]=true)){b+=bI(f,d?bh:'f&&f(k);return true;')}}}if(d){return new Function('c,s,r,d,h,g,f','var N,n,x=0,k=-1,e;main:while((e=c[++k])){'+b+'}return r;')}else{return new Function('e,s,r,d,h,g,f','var N,n,x=0,k=e;'+b+'return false;')}},bI=function(a,b){var d,g,j,h=0,f,c,k,v,s,w;while(a){h++;if((c=a.match(u.universal))){f=''}else if((c=a.match(u.id))){b='if('+(n?'s.getAttribute(e,"id")':'(e.submit?s.getAttribute(e,"id"):e.id)')+'=="'+c[1]+'"){'+b+'}'}else if((c=a.match(u.tagName))){b='if(e.nodeName'+(n?'=="'+c[1]+'"':'.toUpperCase()=="'+c[1].toUpperCase()+'"')+'){'+b+'}'}else if((c=a.match(u.className))){b='if((n='+(n?'s.getAttribute(e,"class")':'e.className')+')&&n.length&&(" "+'+(y?'n.toLowerCase()':'n')+'.replace('+bt+'," ")+" ").indexOf(" '+(y?c[1].toLowerCase():c[1])+' ")>-1){'+b+'}'}else if((c=a.match(u.attribute))){f=c[1].split(':');f=f.length==2?f[1]:f[0]+'';if(c[2]&&!H[c[2]]){r('Unsupported operator in attribute selectors "'+a+'"');return''}s=false;w='false';if(c[2]&&c[4]&&(w=H[c[2]])){bD['class']=y?1:0;c[4]=c[4].replace(/\\([0-9a-f]{2,2})/,'\\x$1');s=(n?ch:bD)[f.toLowerCase()];w=w.replace(/\%m/g,s?c[4].toLowerCase():c[4])}else if(c[2]=='!='||c[2]=='='){w='n'+c[2]+'="'+c[4]+'"'}f='n=s.'+(c[2]?'get':'has')+'Attribute(e,"'+c[1]+'")'+(s?'.toLowerCase();':';');b=f+'if('+(c[2]?w:'n')+'){'+b+'}'}else if((c=a.match(u.adjacent))){b=bw?'var N'+h+'=e;if(e&&(e=e.previousElementSibling)){'+b+'}e=N'+h+';':'var N'+h+'=e;while(e&&(e=e.previousSibling)){if(e.nodeName>"@"){'+b+'break;}}e=N'+h+';'}else if((c=a.match(u.relative))){b=bw?('var N'+h+'=e;e=e.parentNode.firstElementChild;while(e&&e!==N'+h+'){'+b+'e=e.nextElementSibling}e=N'+h+';'):('var N'+h+'=e;e=e.parentNode.firstChild;while(e&&e!==N'+h+'){if(e.nodeName>"@"){'+b+'}e=e.nextSibling}e=N'+h+';');}else if((c=a.match(u.children))){b='var N'+h+'=e;if(e&&e!==h&&e!==g&&(e=e.parentNode)){'+b+'}e=N'+h+';';}else if((c=a.match(u.ancestor))){b='var N'+h+'=e;while(e&&e!==h&&e!==g&&(e=e.parentNode)){'+b+'}e=N'+h+';';}else if((c=a.match(u.spseudos))&&c[1]){switch(c[2]){case'root':if(c[7]){b='if(e===h||s.contains(h,e)){'+b+'}';}else{b='if(e===h){'+b+'}';}break;case'empty':b='if(s.isEmpty(e)){'+b+'}';break;default:if(c[2]&&c[6]){if(c[6]=='n'){b='if(e!==h){'+b+'}';break;}else if(c[6]=='even'){d=2;g=0;}else if(c[6]=='odd'){d=2;g=1;}else{g=((j=c[6].match(/(-?\d+)$/))?parseInt(j[1],10):0);d=((j=c[6].match(/(-?\d*)n/))?parseInt(j[1],10):0);if(j&&j[1]=='-')d=-1;}s=g<1&&d>1?'(n-('+g+'))%'+d+'==0':d>+1?(c[3]=='last')?'(n-('+g+'))%'+d+'==0':'n>='+g+'&&(n-('+g+'))%'+d+'==0':d<-1?(c[3]=='last')?'(n-('+g+'))%'+d+'==0':'n<='+g+'&&(n-('+g+'))%'+d+'==0':d===0?'n=='+g:(c[3]=='last')?d==-1?'n>='+g:'n<='+g:d==-1?'n<='+g:'n>='+g;b='if(e!==h){n=s['+(c[5]?'"nthOfType"':'"nthElement"')+'](e,'+(c[3]=='last'?'true':'false')+');if('+s+'){'+b+'}}';}else{d=c[3]=='first'?'previous':'next';j=c[3]=='only'?'previous':'next';g=c[3]=='first'||c[3]=='last';w=c[5]?'&&n.nodeName!=e.nodeName':'&&n.nodeName<"@"';b='if(e!==h){'+('n=e;while((n=n.'+d+'Sibling)'+w+');if(!n){'+(g?b:'n=e;while((n=n.'+j+'Sibling)'+w+');if(!n){'+b+'}')+'}')+'}';}break;}}else if((c=a.match(u.dpseudos))&&c[1]){switch(c[1]){case'not':f=c[3].replace(O,'');if(o.SIMPLENOT&&!bQ.test(f)){r('Negation pseudo-class only accepts simple selectors "'+a+'"');return'';}else{if('compatMode'in i){b='if(!'+V([f],'',false)+'(e,s,r,d,h,g)){'+b+'}';}else{b='if(!s.match(e, "'+f.replace(/\x22/g,'\\"')+'",g)){'+b+'}';}}break;case'checked':s='if((typeof e.form!="undefined"&&(/^(?:radio|checkbox)$/i).test(e.type)&&e.checked)';b=(o.USE_HTML5?s+'||(/^option$/i.test(e.nodeName)&&e.selected)':s)+'){'+b+'}';break;case'disabled':b='if(((typeof e.form!="undefined"&&!(/^hidden$/i).test(e.type))||s.isLink(e))&&e.disabled){'+b+'}';break;case'enabled':b='if(((typeof e.form!="undefined"&&!(/^hidden$/i).test(e.type))||s.isLink(e))&&!e.disabled){'+b+'}';break;case'lang':s='';if(c[3])s=c[3].substr(0,2)+'-';b='do{(n=e.lang||"").toLowerCase();if((n==""&&h.lang=="'+c[3].toLowerCase()+'")||(n&&(n=="'+c[3].toLowerCase()+'"||n.substr(0,3)=="'+s.toLowerCase()+'"))){'+b+'break;}}while((e=e.parentNode)&&e!==g);';break;case'target':j=i.location?i.location.hash:'';if(j){b='if(e.id=="'+j.slice(1)+'"){'+b+'}';}break;case'link':b='if(s.isLink(e)&&!e.visited){'+b+'}';break;case'visited':b='if(s.isLink(e)&&e.visited){'+b+'}';break;case'active':if(n)break;b='if(e===d.activeElement){'+b+'}';break;case'hover':if(n)break;b='if(e===d.hoverElement){'+b+'}';break;case'focus':if(n)break;b=bS?'if(e===d.activeElement&&d.hasFocus()&&(e.type||e.href)){'+b+'}':'if(e===d.activeElement&&(e.type||e.href)){'+b+'}';break;case'selected':f=bZ?'||(n=e.parentNode)&&n.options[n.selectedIndex]===e':'';b='if(/^option$/i.test(e.nodeName)&&(e.selected'+f+')){'+b+'}';break;default:break;}}else{f=false;v=true;for(f in D){if((c=a.match(D[f].Expression))&&c[1]){k=D[f].Callback(c,b);b=k.source;v=k.status;if(v)break;}}if(!v){r('Unknown pseudo-class selector "'+a+'"');return'';}if(!f){r('Unknown token in selector "'+a+'"');return'';}}if(!c){r('Invalid syntax in selector "'+a+'"');return'';}a=c&&c[c.length-1];}return b;},bi=function(a,b,d,g){var j;if(!(a&&a.nodeName>'@')){r('Invalid element argument');return false;}else if(!b||typeof b!='string'){r('Invalid selector argument');return false;}else if(d&&d.nodeType==1&&!bd(d,a)){return false;}else if(X!==d){F(d||(d=a.ownerDocument));}b=b.replace(O,'');o.SHORTCUTS&&(b=NW.Dom.shortcuts(b,a,d));if(bl!=b){if((j=b.match(N))&&j[0]==b){bk=(j=b.match(bb)).length<2;bl=b;bn=j;}else{r('The string "'+b+'", is not a valid CSS selector');return false;}}else j=bn;if(!T[b]||bf[b]!==d){T[b]=V(bk?[b]:j,'',false);bf[b]=d;}return T[b](a,bj,[],i,m,d,g);},cs=function(a,b){return S(a,b,function(){return false;})[0]||null;},S=function(a,b,d){var g,j,h,f,c,k,v=a;if(arguments.length===0){r('Missing required selector parameters');return[];}else if(a===''){r('Empty selector string');return[];}else if(typeof a!='string'){return[];}else if(b&&!(/1|9|11/).test(b.nodeType)){r('Invalid context element');return[];}else if(X!==b){F(b||(b=i));}if(o.CACHING&&(f=l.loadResults(v,b,i,m))){return d?bF([],f,d):f;}if(!ca&&cd.test(a)){switch(a.charAt(0)){case'#':if((h=I(a.slice(1),b))){f=[h];}else f=[];break;case'.':f=J(a.slice(1),b);break;default:f=A(a,b);break;}}else if(!n&&o.USE_QSAPI&&!(bB&&cc.test(a))&&!cb.test(a)){try{f=b.querySelectorAll(a);}catch(e){}}if(f){f=d?bF([],f,d):bv?K.call(f):bE([],f);o.CACHING&&l.saveResults(v,b,i,f);return f;}a=a.replace(O,'');o.SHORTCUTS&&(a=NW.Dom.shortcuts(a,b));if((j=bm!=a)){if((c=a.match(N))&&c[0]==a){W=(c=a.match(bb)).length<2;bm=a;bo=c;}else{r('The string "'+a+'", is not a valid CSS selector');return[];}}else c=bo;if(b.nodeType==11){f=b.childNodes;}else if(!n&&W){if(j){c=a.match(bR);k=c[c.length-1];G=k.split(':not')[0];p=a.length-k.length;}if((c=G.match(E.ID))&&(k=c[1])){if((h=I(k,b))){if(bi(h,a)){d&&d(h);f=[h];}else f=[];}}else if((c=a.match(E.ID))&&(k=c[1])){if((h=I(k,i))){if('#'+k==a){d&&d(h);f=[h];}if(/[>+~]/.test(a)){b=h.parentNode;}else{a=a.replace('#'+k,'*');p-=k.length+1;b=h;}}else f=[];}if(f){o.CACHING&&l.saveResults(v,b,i,f);return f;}if(!Q&&(c=G.match(E.TAG))&&(k=c[1])){if((f=A(k,b)).length===0){return[];}a=a.slice(0,p)+a.slice(p).replace(k,'*');}else if((c=G.match(E.CLASS))&&(k=c[1])){if((f=J(k,b)).length===0){return[];}if(bu.test(a.charAt(a.indexOf(k)-1))){a=a.slice(0,p)+a.slice(p).replace('.'+k,'');}else{a=a.slice(0,p)+a.slice(p).replace('.'+k,'*');}}else if((c=a.match(E.CLASS))&&(k=c[1])){if((f=J(k,b)).length===0){return[];}for(g=0,els=[];f.length>g;++g){els=bE(els,f[g].getElementsByTagName('*'));}f=els;if(bu.test(a.charAt(a.indexOf(k)-1))){a=a.slice(0,p)+a.slice(p).replace('.'+k,'');}else{a=a.slice(0,p)+a.slice(p).replace('.'+k,'*');}}else if(Q&&(c=G.match(E.TAG))&&(k=c[1])){if((f=A(k,b)).length===0){return[];}a=a.slice(0,p)+a.slice(p).replace(k,'*');}}if(!f){f=/^(?:applet|object)$/i.test(b.nodeName)?b.childNodes:A('*',b);}if(!U[a]||bg[a]!==b){U[a]=V(W?[a]:c,'',true);bg[a]=b}f=U[a](f,bj,[],i,m,b,d);o.CACHING&&l.saveResults(v,b,i,f);return f},bf={},T={},bg={},U={},bj={nthElement:cp,nthOfType:cq,getAttribute:bH,hasAttribute:be,byClass:J,byName:bG,byTag:A,byId:I,contains:bd,isEmpty:cn,isLink:co,select:S,match:bi};Tokens={prefixes:L,encoding:q,operators:bp,whitespace:x,identifier:B,attributes:C,combinators:bq,pseudoclass:M,pseudoparms:br,quotedvalue:Y};l.ACCEPT_NODE=bh;l.emit=r;l.byId=ci;l.byTag=ck;l.byName=bG;l.byClass=cm;l.getAttribute=bH;l.hasAttribute=be;l.match=bi;l.first=cs;l.select=S;l.compile=V;l.contains=bd;l.configure=cr;l.setCache=function(){return};l.loadResults=function(){return};l.saveResults=function(){return};l.shortcuts=function(a){return a};l.Config=o;l.Snapshot=bj;l.Operators=H;l.Selectors=D;l.Tokens=Tokens;l.registerOperator=function(a,b){H[a]||(H[a]=b)};l.registerSelector=function(a,b,d){D[a]||(D[a]={Expression:b,Callback:d})};F(i,true)})(this);

/*
 * jQuery Easing v1.3 - http://gsgd.co.uk/sandbox/jquery/easing/
 *
*/

// t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing['jswing'] = jQuery.easing['swing'];

jQuery.extend( jQuery.easing,
{
  def: 'easeOutQuad',
  swing: function (x, t, b, c, d) {
    //alert(jQuery.easing.default);
    return jQuery.easing[jQuery.easing.def](x, t, b, c, d);
  },
  easeInQuad: function (x, t, b, c, d) {
    return c*(t/=d)*t + b;
  },
  easeOutQuad: function (x, t, b, c, d) {
    return -c *(t/=d)*(t-2) + b;
  },
  easeInOutQuad: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t + b;
    return -c/2 * ((--t)*(t-2) - 1) + b;
  },
  easeInCubic: function (x, t, b, c, d) {
    return c*(t/=d)*t*t + b;
  },
  easeOutCubic: function (x, t, b, c, d) {
    return c*((t=t/d-1)*t*t + 1) + b;
  },
  easeInOutCubic: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b;
    return c/2*((t-=2)*t*t + 2) + b;
  },
  easeInQuart: function (x, t, b, c, d) {
    return c*(t/=d)*t*t*t + b;
  },
  easeOutQuart: function (x, t, b, c, d) {
    return -c * ((t=t/d-1)*t*t*t - 1) + b;
  },
  easeInOutQuart: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
    return -c/2 * ((t-=2)*t*t*t - 2) + b;
  },
  easeInQuint: function (x, t, b, c, d) {
    return c*(t/=d)*t*t*t*t + b;
  },
  easeOutQuint: function (x, t, b, c, d) {
    return c*((t=t/d-1)*t*t*t*t + 1) + b;
  },
  easeInOutQuint: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
    return c/2*((t-=2)*t*t*t*t + 2) + b;
  },
  easeInSine: function (x, t, b, c, d) {
    return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
  },
  easeOutSine: function (x, t, b, c, d) {
    return c * Math.sin(t/d * (Math.PI/2)) + b;
  },
  easeInOutSine: function (x, t, b, c, d) {
    return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
  },
  easeInExpo: function (x, t, b, c, d) {
    return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
  },
  easeOutExpo: function (x, t, b, c, d) {
    return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
  },
  easeInOutExpo: function (x, t, b, c, d) {
    if (t==0) return b;
    if (t==d) return b+c;
    if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
    return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
  },
  easeInCirc: function (x, t, b, c, d) {
    return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
  },
  easeOutCirc: function (x, t, b, c, d) {
    return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
  },
  easeInOutCirc: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
    return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
  },
  easeInElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
  },
  easeOutElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
  },
  easeInOutElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
    return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
  },
  easeInBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158;
    return c*(t/=d)*t*((s+1)*t - s) + b;
  },
  easeOutBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158;
    return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
  },
  easeInOutBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158; 
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
  },
  easeInBounce: function (x, t, b, c, d) {
    return c - jQuery.easing.easeOutBounce (x, d-t, 0, c, d) + b;
  },
  easeOutBounce: function (x, t, b, c, d) {
    if ((t/=d) < (1/2.75)) {
      return c*(7.5625*t*t) + b;
    } else if (t < (2/2.75)) {
      return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
    } else if (t < (2.5/2.75)) {
      return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
    } else {
      return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
    }
  },
  easeInOutBounce: function (x, t, b, c, d) {
    if (t < d/2) return jQuery.easing.easeInBounce (x, t*2, 0, c, d) * .5 + b;
    return jQuery.easing.easeOutBounce (x, t*2-d, 0, c, d) * .5 + c*.5 + b;
  }
});




/*!
 * jQuery Tools v1.2.7 - The missing UI library for the Web
 * 
 * tabs
 * scrollable
 * 
 * NO COPYRIGHTS OR LICENSES. DO WHAT YOU LIKE.
 * 
 * http://flowplayer.org/tools/
 * 
 */
(function(a){a.tools=a.tools||{version:"v1.2.7"},a.tools.tabs={conf:{tabs:"a",current:"current",onBeforeClick:null,onClick:null,effect:"default",initialEffect:!1,initialIndex:0,event:"click",rotate:!1,slideUpSpeed:400,slideDownSpeed:400,history:!1},addEffect:function(a,c){b[a]=c}};var b={"default":function(a,b){this.getPanes().hide().eq(a).show(),b.call()},fade:function(a,b){var c=this.getConf(),d=c.fadeOutSpeed,e=this.getPanes();d?e.fadeOut(d):e.hide(),e.eq(a).fadeIn(c.fadeInSpeed,b)},slide:function(a,b){var c=this.getConf();this.getPanes().slideUp(c.slideUpSpeed),this.getPanes().eq(a).slideDown(c.slideDownSpeed,b)},ajax:function(a,b){this.getPanes().eq(0).load(this.getTabs().eq(a).attr("href"),b)}},c,d;a.tools.tabs.addEffect("horizontal",function(b,e){if(!c){var f=this.getPanes().eq(b),g=this.getCurrentPane();d||(d=this.getPanes().eq(0).width()),c=!0,f.show(),g.animate({width:0},{step:function(a){f.css("width",d-a)},complete:function(){a(this).hide(),e.call(),c=!1}}),g.length||(e.call(),c=!1)}});function e(c,d,e){var f=this,g=c.add(this),h=c.find(e.tabs),i=d.jquery?d:c.children(d),j;h.length||(h=c.children()),i.length||(i=c.parent().find(d)),i.length||(i=a(d)),a.extend(this,{click:function(d,i){var k=h.eq(d),l=!c.data("tabs");typeof d=="string"&&d.replace("#","")&&(k=h.filter("[href*=\""+d.replace("#","")+"\"]"),d=Math.max(h.index(k),0));if(e.rotate){var m=h.length-1;if(d<0)return f.click(m,i);if(d>m)return f.click(0,i)}if(!k.length){if(j>=0)return f;d=e.initialIndex,k=h.eq(d)}if(d===j)return f;i=i||a.Event(),i.type="onBeforeClick",g.trigger(i,[d]);if(!i.isDefaultPrevented()){var n=l?e.initialEffect&&e.effect||"default":e.effect;b[n].call(f,d,function(){j=d,i.type="onClick",g.trigger(i,[d])}),h.removeClass(e.current),k.addClass(e.current);return f}},getConf:function(){return e},getTabs:function(){return h},getPanes:function(){return i},getCurrentPane:function(){return i.eq(j)},getCurrentTab:function(){return h.eq(j)},getIndex:function(){return j},next:function(){return f.click(j+1)},prev:function(){return f.click(j-1)},destroy:function(){h.off(e.event).removeClass(e.current),i.find("a[href^=\"#\"]").off("click.T");return f}}),a.each("onBeforeClick,onClick".split(","),function(b,c){a.isFunction(e[c])&&a(f).on(c,e[c]),f[c]=function(b){b&&a(f).on(c,b);return f}}),e.history&&a.fn.history&&(a.tools.history.init(h),e.event="history"),h.each(function(b){a(this).on(e.event,function(a){f.click(b,a);return a.preventDefault()})}),i.find("a[href^=\"#\"]").on("click.T",function(b){f.click(a(this).attr("href"),b)}),location.hash&&e.tabs=="a"&&c.find("[href=\""+location.hash+"\"]").length?f.click(location.hash):(e.initialIndex===0||e.initialIndex>0)&&f.click(e.initialIndex)}a.fn.tabs=function(b,c){var d=this.data("tabs");d&&(d.destroy(),this.removeData("tabs")),a.isFunction(c)&&(c={onBeforeClick:c}),c=a.extend({},a.tools.tabs.conf,c),this.each(function(){d=new e(a(this),b,c),a(this).data("tabs",d)});return c.api?d:this}})(jQuery);
(function(a){a.tools=a.tools||{version:"v1.2.7"},a.tools.scrollable={conf:{activeClass:"active",circular:!1,clonedClass:"cloned",disabledClass:"disabled",easing:"swing",initialIndex:0,item:"> *",items:".items",keyboard:!0,mousewheel:!1,next:".next",prev:".prev",size:1,speed:400,vertical:!1,touch:!0,wheelSpeed:0}};function b(a,b){var c=parseInt(a.css(b),10);if(c)return c;var d=a[0].currentStyle;return d&&d.width&&parseInt(d.width,10)}function c(b,c){var d=a(c);return d.length<2?d:b.parent().find(c)}var d;function e(b,e){var f=this,g=b.add(f),h=b.children(),i=0,j=e.vertical;d||(d=f),h.length>1&&(h=a(e.items,b)),e.size>1&&(e.circular=!1),a.extend(f,{getConf:function(){return e},getIndex:function(){return i},getSize:function(){return f.getItems().size()},getNaviButtons:function(){return n.add(o)},getRoot:function(){return b},getItemWrap:function(){return h},getItems:function(){return h.find(e.item).not("."+e.clonedClass)},move:function(a,b){return f.seekTo(i+a,b)},next:function(a){return f.move(e.size,a)},prev:function(a){return f.move(-e.size,a)},begin:function(a){return f.seekTo(0,a)},end:function(a){return f.seekTo(f.getSize()-1,a)},focus:function(){d=f;return f},addItem:function(b){b=a(b),e.circular?(h.children().last().before(b),h.children().first().replaceWith(b.clone().addClass(e.clonedClass))):(h.append(b),o.removeClass("disabled")),g.trigger("onAddItem",[b]);return f},seekTo:function(b,c,k){b.jquery||(b*=1);if(e.circular&&b===0&&i==-1&&c!==0)return f;if(!e.circular&&b<0||b>f.getSize()||b<-1)return f;var l=b;b.jquery?b=f.getItems().index(b):l=f.getItems().eq(b);var m=a.Event("onBeforeSeek");if(!k){g.trigger(m,[b,c]);if(m.isDefaultPrevented()||!l.length)return f}var n=j?{top:-l.position().top}:{left:-l.position().left};i=b,d=f,c===undefined&&(c=e.speed),h.animate(n,c,e.easing,k||function(){g.trigger("onSeek",[b])});return f}}),a.each(["onBeforeSeek","onSeek","onAddItem"],function(b,c){a.isFunction(e[c])&&a(f).on(c,e[c]),f[c]=function(b){b&&a(f).on(c,b);return f}});if(e.circular){var k=f.getItems().slice(-1).clone().prependTo(h),l=f.getItems().eq(1).clone().appendTo(h);k.add(l).addClass(e.clonedClass),f.onBeforeSeek(function(a,b,c){if(!a.isDefaultPrevented()){if(b==-1){f.seekTo(k,c,function(){f.end(0)});return a.preventDefault()}b==f.getSize()&&f.seekTo(l,c,function(){f.begin(0)})}});var m=b.parents().add(b).filter(function(){if(a(this).css("display")==="none")return!0});m.length?(m.show(),f.seekTo(0,0,function(){}),m.hide()):f.seekTo(0,0,function(){})}var n=c(b,e.prev).click(function(a){a.stopPropagation(),f.prev()}),o=c(b,e.next).click(function(a){a.stopPropagation(),f.next()});e.circular||(f.onBeforeSeek(function(a,b){setTimeout(function(){a.isDefaultPrevented()||(n.toggleClass(e.disabledClass,b<=0),o.toggleClass(e.disabledClass,b>=f.getSize()-1))},1)}),e.initialIndex||n.addClass(e.disabledClass)),f.getSize()<2&&n.add(o).addClass(e.disabledClass),e.mousewheel&&a.fn.mousewheel&&b.mousewheel(function(a,b){if(e.mousewheel){f.move(b<0?1:-1,e.wheelSpeed||50);return!1}});if(e.touch){var p={};h[0].ontouchstart=function(a){var b=a.touches[0];p.x=b.clientX,p.y=b.clientY},h[0].ontouchmove=function(a){if(a.touches.length==1&&!h.is(":animated")){var b=a.touches[0],c=p.x-b.clientX,d=p.y-b.clientY;f[j&&d>0||!j&&c>0?"next":"prev"](),a.preventDefault()}}}e.keyboard&&a(document).on("keydown.scrollable",function(b){if(!(!e.keyboard||b.altKey||b.ctrlKey||b.metaKey||a(b.target).is(":input"))){if(e.keyboard!="static"&&d!=f)return;var c=b.keyCode;if(j&&(c==38||c==40)){f.move(c==38?-1:1);return b.preventDefault()}if(!j&&(c==37||c==39)){f.move(c==37?-1:1);return b.preventDefault()}}}),e.initialIndex&&f.seekTo(e.initialIndex,0,function(){})}a.fn.scrollable=function(b){var c=this.data("scrollable");if(c)return c;b=a.extend({},a.tools.scrollable.conf,b),this.each(function(){c=new e(a(this),b),a(this).data("scrollable",c)});return b.api?c:this}})(jQuery);


// DD Slick Drop Down
// (function (a) { function g(a, b) { var c = a.data("ddslick"); var d = a.find(".dd-selected"), e = d.siblings(".dd-selected-value"), f = a.find(".dd-options"), g = d.siblings(".dd-pointer"), h = a.find(".dd-option").eq(b), k = h.closest("li"), l = c.settings, m = c.settings.data[b]; a.find(".dd-option").removeClass("dd-option-selected"); h.addClass("dd-option-selected"); c.selectedIndex = b; c.selectedItem = k; c.selectedData = m; if (l.showSelectedHTML) { d.html((m.imageSrc ? '<img class="dd-selected-image' + (l.imagePosition == "right" ? " dd-image-right" : "") + '" src="' + m.imageSrc + '" />' : "") + (m.text ? '<label class="dd-selected-text">' + m.text + "</label>" : "") + (m.description ? '<small class="dd-selected-description dd-desc' + (l.truncateDescription ? " dd-selected-description-truncated" : "") + '" >' + m.description + "</small>" : "")) } else d.html(m.text); e.val(m.value); c.original.val(m.value); a.data("ddslick", c); i(a); j(a); if (typeof l.onSelected == "function") { l.onSelected.call(this, c) } } function h(b) { var c = b.find(".dd-select"), d = c.siblings(".dd-options"), e = c.find(".dd-pointer"), f = d.is(":visible"); a(".dd-click-off-close").not(d).slideUp(50); a(".dd-pointer").removeClass("dd-pointer-up"); if (f) { d.slideUp("fast"); e.removeClass("dd-pointer-up") } else { d.slideDown("fast"); e.addClass("dd-pointer-up") } k(b) } function i(a) { a.find(".dd-options").slideUp(50); a.find(".dd-pointer").removeClass("dd-pointer-up").removeClass("dd-pointer-up") } function j(a) { var b = a.find(".dd-select").css("height"); var c = a.find(".dd-selected-description"); var d = a.find(".dd-selected-image"); if (c.length <= 0 && d.length > 0) { a.find(".dd-selected-text").css("lineHeight", b) } } function k(b) { b.find(".dd-option").each(function () { var c = a(this); var d = c.css("height"); var e = c.find(".dd-option-description"); var f = b.find(".dd-option-image"); if (e.length <= 0 && f.length > 0) { c.find(".dd-option-text").css("lineHeight", d) } }) } a.fn.ddslick = function (c) { if (b[c]) { return b[c].apply(this, Array.prototype.slice.call(arguments, 1)) } else if (typeof c === "object" || !c) { return b.init.apply(this, arguments) } else { a.error("Method " + c + " does not exists.") } }; var b = {}, c = { data: [], keepJSONItemsOnTop: false, width: 260, height: null, background: "#eee", selectText: "", defaultSelectedIndex: null, truncateDescription: true, imagePosition: "left", showSelectedHTML: true, clickOffToClose: true, onSelected: function () { } }, d = '<div class="dd-select"><input class="dd-selected-value" type="hidden" /><a class="dd-selected"></a><span class="dd-pointer dd-pointer-down"></span></div>', e = '<ul class="dd-options"></ul>', f = '<style id="css-ddslick" type="text/css">' + ".dd-select{ border-radius:2px; border:solid 1px #ccc; position:relative; cursor:pointer;}" + ".dd-desc { color:#aaa; display:block; overflow: hidden; font-weight:normal; line-height: 1.4em; }" + ".dd-selected{ overflow:hidden; display:block; padding:10px; font-weight:bold;}" + ".dd-pointer{ width:0; height:0; position:absolute; right:10px; top:50%; margin-top:-3px;}" + ".dd-pointer-down{ border:solid 5px transparent; border-top:solid 5px #000; }" + ".dd-pointer-up{border:solid 5px transparent !important; border-bottom:solid 5px #000 !important; margin-top:-8px;}" + ".dd-options{ border:solid 1px #ccc; border-top:none; list-style:none; box-shadow:0px 1px 5px #ddd; display:none; position:absolute; z-index:2000; margin:0; padding:0;background:#fff; overflow:auto;}" + ".dd-option{ padding:10px; display:block; border-bottom:solid 1px #ddd; overflow:hidden; text-decoration:none; color:#333; cursor:pointer;-webkit-transition: all 0.25s ease-in-out; -moz-transition: all 0.25s ease-in-out;-o-transition: all 0.25s ease-in-out;-ms-transition: all 0.25s ease-in-out; }" + ".dd-options > li:last-child > .dd-option{ border-bottom:none;}" + ".dd-option:hover{ background:#f3f3f3; color:#000;}" + ".dd-selected-description-truncated { text-overflow: ellipsis; white-space:nowrap; }" + ".dd-option-selected { background:#f6f6f6; }" + ".dd-option-image, .dd-selected-image { vertical-align:middle; float:left; margin-right:5px; max-width:64px;}" + ".dd-image-right { float:right; margin-right:15px; margin-left:5px;}" + ".dd-container{ position:relative;}​ .dd-selected-text { font-weight:bold}​</style>"; if (a("#css-ddslick").length <= 0) { a(f).appendTo("head") } b.init = function (b) { var b = a.extend({}, c, b); return this.each(function () { var c = a(this), f = c.data("ddslick"); if (!f) { var i = [], j = b.data; c.find("option").each(function () { var b = a(this), c = b.data(); i.push({ text: a.trim(b.text()), value: b.val(), selected: b.is(":selected"), description: c.description, imageSrc: c.imagesrc }) }); if (b.keepJSONItemsOnTop) a.merge(b.data, i); else b.data = a.merge(i, b.data); var k = c, l = a('<div id="' + c.attr("id") + '"></div>'); c.replaceWith(l); c = l; c.addClass("dd-container").append(d).append(e); var i = c.find(".dd-select"), m = c.find(".dd-options"); m.css({ width: b.width }); i.css({ width: b.width, background: b.background }); c.css({ width: b.width }); if (b.height != null) m.css({ height: b.height, overflow: "auto" }); a.each(b.data, function (a, c) { if (c.selected) b.defaultSelectedIndex = a; m.append("<li>" + '<a class="dd-option">' + (c.value ? ' <input class="dd-option-value" type="hidden" value="' + c.value + '" />' : "") + (c.imageSrc ? ' <img class="dd-option-image' + (b.imagePosition == "right" ? " dd-image-right" : "") + '" src="' + c.imageSrc + '" />' : "") + (c.text ? ' <label class="dd-option-text">' + c.text + "</label>" : "") + (c.description ? ' <small class="dd-option-description dd-desc">' + c.description + "</small>" : "") + "</a>" + "</li>") }); var n = { settings: b, original: k, selectedIndex: -1, selectedItem: null, selectedData: null }; c.data("ddslick", n); if (b.selectText.length > 0 && b.defaultSelectedIndex == null) { c.find(".dd-selected").html(b.selectText) } else { var o = b.defaultSelectedIndex != null && b.defaultSelectedIndex >= 0 && b.defaultSelectedIndex < b.data.length ? b.defaultSelectedIndex : 0; g(c, o) } c.find(".dd-select").on("click.ddslick", function () { h(c) }); c.find(".dd-option").on("click.ddslick", function () { g(c, a(this).closest("li").index()) }); if (b.clickOffToClose) { m.addClass("dd-click-off-close"); c.on("click.ddslick", function (a) { a.stopPropagation() }); a("body").on("click", function () { a(".dd-click-off-close").slideUp(50).siblings(".dd-select").find(".dd-pointer").removeClass("dd-pointer-up") }) } } }) }; b.select = function (b) { return this.each(function () { if (b.index) g(a(this), b.index) }) }; b.open = function () { return this.each(function () { var b = a(this), c = b.data("ddslick"); if (c) h(b) }) }; b.close = function () { return this.each(function () { var b = a(this), c = b.data("ddslick"); if (c) i(b) }) }; b.destroy = function () { return this.each(function () { var b = a(this), c = b.data("ddslick"); if (c) { var d = c.original; b.removeData("ddslick").unbind(".ddslick").replaceWith(d) } }) } })(jQuery)

/**
 * DropKick
 *
 * Highly customizable <select> lists
 * https://github.com/JamieLottering/DropKick
 *
 * &copy; 2011 Jamie Lottering <http://github.com/JamieLottering>
 *                        <http://twitter.com/JamieLottering>
 * 
 */
(function($,window,document){var ie6=false;if($.browser.msie&&$.browser.version.substr(0,1)<7){ie6=true}else{document.documentElement.className=document.documentElement.className+' dk_fouc'}var methods={},lists=[],keyMap={'left':37,'up':38,'right':39,'down':40,'enter':13},dropdownTemplate=['<div class="dk_container" id="dk_container_{{ id }}" tabindex="{{ tabindex }}">','<a class="dk_toggle">','<span class="dk_label">{{ label }}</span>','</a>','<div class="dk_options">','<ul class="dk_options_inner">','</ul>','</div>','</div>'].join(''),optionTemplate='<li class="{{ current }}"><a data-dk-dropdown-value="{{ value }}">{{ text }}</a></li>',defaults={startSpeed:1000,theme:false,change:false},keysBound=false;methods.init=function(settings){settings=$.extend({},defaults,settings);return this.each(function(){var $select=$(this),$original=$select.find(':selected').first(),$options=$select.find('option'),data=$select.data('dropkick')||{},id=$select.attr('id')||$select.attr('name'),width=settings.width||$select.outerWidth(),tabindex=$select.attr('tabindex')?$select.attr('tabindex'):'',$dk=false,theme;if(data.id){return $select}else{data.settings=settings;data.tabindex=tabindex;data.id=id;data.$original=$original;data.$select=$select;data.value=_notBlank($select.val())||_notBlank($original.attr('value'));data.label=$original.text();data.options=$options}$dk=_build(dropdownTemplate,data);$dk.find('.dk_toggle').css({'width':width+'px'});$select.before($dk);$dk=$('#dk_container_'+id).fadeIn(settings.startSpeed);theme=settings.theme?settings.theme:'default';$dk.addClass('dk_theme_'+theme);data.theme=theme;data.$dk=$dk;$select.data('dropkick',data);$dk.data('dropkick',data);lists[lists.length]=$select;$dk.bind('focus.dropkick',function(e){$dk.addClass('dk_focus')}).bind('blur.dropkick',function(e){$dk.removeClass('dk_open dk_focus')});setTimeout(function(){$select.hide()},0)})};methods.theme=function(newTheme){var $select=$(this),list=$select.data('dropkick'),$dk=list.$dk,oldtheme='dk_theme_'+list.theme;$dk.removeClass(oldtheme).addClass('dk_theme_'+newTheme);list.theme=newTheme};methods.reset=function(){for(var i=0,l=lists.length;i<l;i++){var listData=lists[i].data('dropkick'),$dk=listData.$dk,$current=$dk.find('li').first();$dk.find('.dk_label').text(listData.label);$dk.find('.dk_options_inner').animate({scrollTop:0},0);_setCurrent($current,$dk);_updateFields($current,$dk,true)}};$.fn.dropkick=function(method){if(!ie6){if(methods[method]){return methods[method].apply(this,Array.prototype.slice.call(arguments,1))}else if(typeof method==='object'||!method){return methods.init.apply(this,arguments)}}};function _handleKeyBoardNav(e,$dk){var code=e.keyCode,data=$dk.data('dropkick'),options=$dk.find('.dk_options'),open=$dk.hasClass('dk_open'),current=$dk.find('.dk_option_current'),first=options.find('li').first(),last=options.find('li').last(),next,prev;switch(code){case keyMap.enter:if(open){_updateFields(current.find('a'),$dk);_closeDropdown($dk)}else{_openDropdown($dk)}e.preventDefault();break;case keyMap.up:prev=current.prev('li');if(open){if(prev.length){_setCurrent(prev,$dk)}else{_setCurrent(last,$dk)}}else{_openDropdown($dk)}e.preventDefault();break;case keyMap.down:if(open){next=current.next('li').first();if(next.length){_setCurrent(next,$dk)}else{_setCurrent(first,$dk)}}else{_openDropdown($dk)}e.preventDefault();break;default:break}}function _updateFields(option,$dk,reset){var value,label,data;value=option.attr('data-dk-dropdown-value');label=option.text();data=$dk.data('dropkick');$select=data.$select;$select.val(value);$dk.find('.dk_label').text(label);reset=reset||false;if(data.settings.change&&!reset){data.settings.change.call($select,value,label)}}function _setCurrent($current,$dk){$dk.find('.dk_option_current').removeClass('dk_option_current');$current.addClass('dk_option_current');_setScrollPos($dk,$current)}function _setScrollPos($dk,anchor){var height=anchor.prevAll('li').outerHeight()*anchor.prevAll('li').length;$dk.find('.dk_options_inner').animate({scrollTop:height+'px'},0)}function _closeDropdown($dk){$dk.removeClass('dk_open')}function _openDropdown($dk){var data=$dk.data('dropkick');$dk.find('.dk_options').css({top:$dk.find('.dk_toggle').outerHeight()-1});$dk.toggleClass('dk_open')}function _build(tpl,view){var template=tpl,options=[],$dk;template=template.replace('{{ id }}',view.id);template=template.replace('{{ label }}',view.label);template=template.replace('{{ tabindex }}',view.tabindex);if(view.options&&view.options.length){for(var i=0,l=view.options.length;i<l;i++){var $option=$(view.options[i]),current='dk_option_current',oTemplate=optionTemplate;oTemplate=oTemplate.replace('{{ value }}',$option.val());oTemplate=oTemplate.replace('{{ current }}',(_notBlank($option.val())===view.value)?current:'');oTemplate=oTemplate.replace('{{ text }}',$option.text());options[options.length]=oTemplate}}$dk=$(template);$dk.find('.dk_options_inner').html(options.join(''));return $dk}function _notBlank(text){return($.trim(text).length>0)?text:false}$(function(){$('.dk_toggle').live('click',function(e){var $dk=$(this).parents('.dk_container').first();_openDropdown($dk);if("ontouchstart"in window){$dk.addClass('dk_touch');$dk.find('.dk_options_inner').addClass('scrollable vertical')}e.preventDefault();return false});$('.dk_options a').live(($.browser.msie?'mousedown':'click'),function(e){var $option=$(this),$dk=$option.parents('.dk_container').first(),data=$dk.data('dropkick');_closeDropdown($dk);_updateFields($option,$dk);_setCurrent($option.parent(),$dk);e.preventDefault();return false});$(document).bind('keydown.dk_nav',function(e){var $open=$('.dk_container.dk_open'),$focused=$('.dk_container.dk_focus'),$dk=null;if($open.length){$dk=$open}else if($focused.length&&!$open.length){$dk=$focused}if($dk){_handleKeyBoardNav(e,$dk)}})})})(jQuery,window,document);


// get user data
function reqUserData(uid){
// -------------- get user data
    $.ajax({
      type: 'POST',
      beforeSend: function(xhr,settings){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        //console.log('---- presend ----')
      },
      url: "/users/getUserinfo/"+uid+".json",
      dataType: 'json',
      complete: function(data){
      }
    });
// -------------- get user data
}

// scroll winder to top when user clicks on thumb
function initThumbScroll(){
  //console.log("initThumbScroll");
  var trigger = $('.reload_action_left');
  trigger.each(function(i, el){
    $(el).bind('click',function(){
      $('body,html').animate({scrollTop : 0});
    });
  });
}

// hide login button, enable auth'd user actions
function enableUser(flag){
  //console.log('ENABLING USER', flag);
  var reg = $('.auth');
  var non_reg = $('.non-auth');

  $(reg).each(function(index, el){
    if(flag == true){
      //$(el).css({display:'block'})
      $(el).fadeIn('fast')
    }else{
      //$(el).css({display:'none'})
      $(el).fadeOut('fast')
    }
  })
  
  $(non_reg).each(function(index, el){
    if(flag == true){
      //$(el).css({display:'none'})
      $(el).fadeOut('fast')
    }else{
      //$(el).css({display:'block'})
      $(el).fadeIn('fast')
    }
  });
}

// after vote button is clicked, fadeout and remove both from DOM
/*
$(function(){
  btns = $('.remote_action')
  btns.each(function(group, index){
    $(index).click(function(e){
      e.preventDefault();
      btns.each(function(group, index){
        $(index).fadeOut(300)
      })
    });
  })
})
*/
$(function(){

  //track when tweets complete
  twttr.events.bind('tweet', function(event) {
    window.tweet_callback()
  });

  initThumbScroll();

  $('.remote_action').live('click', function(event){
    event.preventDefault();
    $.ajax({
      url: $(event.target).attr('href'),
      type: 'POST',
      beforeSend: function(xhr,settings){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      success: function(resp){
        // update winner with new vote count, fade out & disable vote buttons, fade in battle win blocks
        var target = $('#video_'+$(event.target).data('videoid')+' .vote-count span');
        target.html(resp.count);
        $('.remote_action').each(function(i, el){
          // $(el).fadeOut(300)
          //console.log('+',$(el))
          $(el).addClass('disabled');
          $(el).bind('click', false);
          $(el).fadeTo('slow', 0.4);
          $(el).removeAttr('href');
          $(el).addClass("lose");
          $(el).text(vote_lose);
        })
        $('.vote-count').each(function(i, el){
          // $(el).fadeIn(300)
        })
        win = $(event.target);
        win.addClass('win');
        win.text(vote_win);
      }
    });
  });
})


window.fbAsyncInit = function() {
  // console.log('fbAsyncInit');
  FB.init({
      appId      : CLIENT_ID,
      status     : true,
      cookie     : true,
      oauth      : true,
      xfbml      : true
    });

  // check login status
  $(function(){
    FB.getLoginStatus(function(response) {

      //console.log('getLoginStatus', response);
      if (response.status === 'connected') {
        
        var uid = response.authResponse.userID;
        var accessToken = response.authResponse.accessToken;
        var signedRequest = response.authResponse.signedRequest
        
        FB.api('/me/permissions', function (response) {
          console.log(response);
        });
        
        enableUser(true);

        // --------------------------------------------------------------------------
        // --------------------------------------------------------------------------
        $.ajax({
          type: 'POST',
          beforeSend: function(xhr,settings){
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          },
          url: "/oauth/callback",
          data: {'accessToken':accessToken,'userID':uid,'signedRequest':signedRequest},
          success: function(resp){
            if(resp.success == true){
              //console.log('success',resp)
              reqUserData(uid);
              enableUser(true);
            }
            
          },
          statusCode: {
            302: function() {
              //console.log("what the thunder fudge?");
            }
          },
          dataType: 'json'
        });
        /*
        */

        // --------------------------------------------------------------------------
        // --------------------------------------------------------------------------

      } else if (response.status === 'not_authorized') {
        // console.log('NOT auth\'d, show some buttons!');
        enableUser(false);
        // the user is logged in to Facebook, 
        // but has not authenticated your app
      } else {
        // console.log('NOT logged in to facebook damnit!, show some buttons!');
        enableUser(false);
        // the user isn't logged in to Facebook.
      }
    });  
  });  

  // listen for and handle auth.statusChange events
  FB.Event.subscribe('auth.statusChange', function(response) {
    if (response.authResponse) {
      // is auth'd and logged into facebook
      FB.api('/me', function(me){
        //console.log('ME: ',me)
        if (me.name) {
          
          // updatesession ///
          var url = '/home/updatesession/'+me.id;
          $.ajax({
            type: 'POST',
            beforeSend: function(xhr,settings){
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            url: url
          });  

          enableUser(true)             
        }
      })
    } else {
      // user has not auth'd your app, or is not logged into Facebook
    }
  });
  
  FB.Event.subscribe('auth.login', function(r){
    //console.log('auth.login" >> ', r);
    if ( r.status === 'connected' ){
      // a user has logged in
    }
  });

  var initLogin = function(e){

    var redirect_url = $(e.target).data('redirect');
    //console.log('redirect_url >> ',redirect_url);

    FB.login(function(response) {

      if (response.authResponse) {
      FB.api('/me/permissions', function (req) {
        var perms = req.data[0];
        //console.log('PERMS: ',perms);
        if (perms.publish_actions) {
          // console.log('response: ', response, response.authResponse.accessToken, response.authResponse.userID); 

          //console.log('RESPONSE: ',response);

          var uid = response.authResponse.userID;
          var accessToken = response.authResponse.accessToken;
          var signedRequest = response.authResponse.signedRequest

          //console.log('create user: ',uid, accessToken, signedRequest);

          /* create user */
          $.ajax({
            type: 'POST',
            beforeSend: function(xhr,settings){
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            url: "/oauth/callback",
            data: {'accessToken':accessToken,'userID':uid,'signedRequest':signedRequest},
            success: function(resp){
              if(resp.success == true){
                //console.log('success',resp)
                reqUserData(uid);
                enableUser(true);
                window.location.href = redirect_url;
              }
              
            },
            statusCode: {
              302: function() {
                //console.log("what the thunder fudge?");
              }
            },
            dataType: 'json'
          });
        } else {
          // fail, you did not accept permissions, you are super special
        }                                            
      });
      } else {
        //console.log('User cancelled login or did not fully authorize.');
      }
    }, {scope: 'email,publish_actions,user_location'});     
  }   

  // respond to clicks on the login and logout links
  $('.auth-loginlink').each(function(index, el){
    el.addEventListener('click', initLogin);
  })

}

/*
 * object.watch polyfill
 *
 * 2012-04-03
 *
 * By Eli Grey, http://eligrey.com
 * Public Domain.
 * NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
 */

// object.watch
if (!Object.prototype.watch) {
  Object.defineProperty(Object.prototype, "watch", {
      enumerable: false
    , configurable: true
    , writable: false
    , value: function (prop, handler) {
      var
        oldval = this[prop]
      , newval = oldval
      , getter = function () {
        return newval;
      }
      , setter = function (val) {
        oldval = newval;
        return newval = handler.call(this, prop, oldval, val);
      }
      ;
      
      if (delete this[prop]) { // can't watch constants
        Object.defineProperty(this, prop, {
            get: getter
          , set: setter
          , enumerable: true
          , configurable: true
        });
      }
    }
  });
}

// object.unwatch
if (!Object.prototype.unwatch) {
  Object.defineProperty(Object.prototype, "unwatch", {
      enumerable: false
    , configurable: true
    , writable: false
    , value: function (prop) {
      var val = this[prop];
      delete this[prop]; // remove accessors
      this[prop] = val;
    }
  });
}