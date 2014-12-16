!function(i){"use strict";"function"==typeof define&&define.amd?define(["jquery"],i):"undefined"!=typeof exports?module.exports=i(require("jquery")):i(jQuery)}(function(i){"use strict";var e=window.Slick||{};e=function(){function e(e,o){var s,n,l=this;if(l.defaults={accessibility:!0,adaptiveHeight:!1,appendArrows:i(e),appendDots:i(e),arrows:!0,asNavFor:null,prevArrow:'<button type="button" data-role="none" class="slick-prev">Previous</button>',nextArrow:'<button type="button" data-role="none" class="slick-next">Next</button>',autoplay:!1,autoplaySpeed:3e3,centerMode:!1,centerPadding:"50px",cssEase:"ease",customPaging:function(i,e){return'<button type="button" data-role="none">'+(e+1)+"</button>"},dots:!1,dotsClass:"slick-dots",draggable:!0,easing:"linear",fade:!1,focusOnSelect:!1,infinite:!0,initialSlide:0,lazyLoad:"ondemand",onBeforeChange:null,onAfterChange:null,onInit:null,onReInit:null,onSetPosition:null,pauseOnHover:!0,pauseOnDotsHover:!1,respondTo:"window",responsive:null,rtl:!1,slide:"div",slidesToShow:1,slidesToScroll:1,speed:500,swipe:!0,swipeToSlide:!1,touchMove:!0,touchThreshold:5,useCSS:!0,variableWidth:!1,vertical:!1,waitForAnimate:!0},l.initials={animating:!1,dragging:!1,autoPlayTimer:null,currentDirection:0,currentLeft:null,currentSlide:0,direction:1,$dots:null,listWidth:null,listHeight:null,loadIndex:0,$nextArrow:null,$prevArrow:null,slideCount:null,slideWidth:null,$slideTrack:null,$slides:null,sliding:!1,slideOffset:0,swipeLeft:null,$list:null,touchObject:{},transformsEnabled:!1},i.extend(l,l.initials),l.activeBreakpoint=null,l.animType=null,l.animProp=null,l.breakpoints=[],l.breakpointSettings=[],l.cssTransitions=!1,l.paused=!1,l.positionProp=null,l.respondTo=null,l.shouldClick=!0,l.$slider=i(e),l.$slidesCache=null,l.transformType=null,l.transitionType=null,l.windowWidth=0,l.windowTimer=null,l.options=i.extend({},l.defaults,o),l.currentSlide=l.options.initialSlide,l.originalSettings=l.options,s=l.options.responsive||null,s&&s.length>-1){l.respondTo=l.options.respondTo||"window";for(n in s)s.hasOwnProperty(n)&&(l.breakpoints.push(s[n].breakpoint),l.breakpointSettings[s[n].breakpoint]=s[n].settings);l.breakpoints.sort(function(i,e){return e-i})}l.autoPlay=i.proxy(l.autoPlay,l),l.autoPlayClear=i.proxy(l.autoPlayClear,l),l.changeSlide=i.proxy(l.changeSlide,l),l.clickHandler=i.proxy(l.clickHandler,l),l.selectHandler=i.proxy(l.selectHandler,l),l.setPosition=i.proxy(l.setPosition,l),l.swipeHandler=i.proxy(l.swipeHandler,l),l.dragHandler=i.proxy(l.dragHandler,l),l.keyHandler=i.proxy(l.keyHandler,l),l.autoPlayIterator=i.proxy(l.autoPlayIterator,l),l.instanceUid=t++,l.htmlExpr=/^(?:\s*(<[\w\W]+>)[^>]*)$/,l.init(),l.checkResponsive()}var t=0;return e}(),e.prototype.addSlide=function(e,t,o){var s=this;if("boolean"==typeof t)o=t,t=null;else if(0>t||t>=s.slideCount)return!1;s.unload(),"number"==typeof t?0===t&&0===s.$slides.length?i(e).appendTo(s.$slideTrack):o?i(e).insertBefore(s.$slides.eq(t)):i(e).insertAfter(s.$slides.eq(t)):o===!0?i(e).prependTo(s.$slideTrack):i(e).appendTo(s.$slideTrack),s.$slides=s.$slideTrack.children(this.options.slide),s.$slideTrack.children(this.options.slide).detach(),s.$slideTrack.append(s.$slides),s.$slides.each(function(e,t){i(t).attr("index",e)}),s.$slidesCache=s.$slides,s.reinit()},e.prototype.animateSlide=function(e,t){var o={},s=this;if(1===s.options.slidesToShow&&s.options.adaptiveHeight===!0&&s.options.vertical===!1){var n=s.$slides.eq(s.currentSlide).outerHeight(!0);s.$list.animate({height:n},s.options.speed)}s.options.rtl===!0&&s.options.vertical===!1&&(e=-e),s.transformsEnabled===!1?s.options.vertical===!1?s.$slideTrack.animate({left:e},s.options.speed,s.options.easing,t):s.$slideTrack.animate({top:e},s.options.speed,s.options.easing,t):s.cssTransitions===!1?i({animStart:s.currentLeft}).animate({animStart:e},{duration:s.options.speed,easing:s.options.easing,step:function(i){s.options.vertical===!1?(o[s.animType]="translate("+i+"px, 0px)",s.$slideTrack.css(o)):(o[s.animType]="translate(0px,"+i+"px)",s.$slideTrack.css(o))},complete:function(){t&&t.call()}}):(s.applyTransition(),o[s.animType]=s.options.vertical===!1?"translate3d("+e+"px, 0px, 0px)":"translate3d(0px,"+e+"px, 0px)",s.$slideTrack.css(o),t&&setTimeout(function(){s.disableTransition(),t.call()},s.options.speed))},e.prototype.asNavFor=function(e){var t=this,o=null!=t.options.asNavFor?i(t.options.asNavFor).getSlick():null;null!=o&&o.slideHandler(e,!0)},e.prototype.applyTransition=function(i){var e=this,t={};t[e.transitionType]=e.options.fade===!1?e.transformType+" "+e.options.speed+"ms "+e.options.cssEase:"opacity "+e.options.speed+"ms "+e.options.cssEase,e.options.fade===!1?e.$slideTrack.css(t):e.$slides.eq(i).css(t)},e.prototype.autoPlay=function(){var i=this;i.autoPlayTimer&&clearInterval(i.autoPlayTimer),i.slideCount>i.options.slidesToShow&&i.paused!==!0&&(i.autoPlayTimer=setInterval(i.autoPlayIterator,i.options.autoplaySpeed))},e.prototype.autoPlayClear=function(){var i=this;i.autoPlayTimer&&clearInterval(i.autoPlayTimer)},e.prototype.autoPlayIterator=function(){var i=this;i.options.infinite===!1?1===i.direction?(i.currentSlide+1===i.slideCount-1&&(i.direction=0),i.slideHandler(i.currentSlide+i.options.slidesToScroll)):(i.currentSlide-1===0&&(i.direction=1),i.slideHandler(i.currentSlide-i.options.slidesToScroll)):i.slideHandler(i.currentSlide+i.options.slidesToScroll)},e.prototype.buildArrows=function(){var e=this;e.options.arrows===!0&&e.slideCount>e.options.slidesToShow&&(e.$prevArrow=i(e.options.prevArrow),e.$nextArrow=i(e.options.nextArrow),e.htmlExpr.test(e.options.prevArrow)&&e.$prevArrow.appendTo(e.options.appendArrows),e.htmlExpr.test(e.options.nextArrow)&&e.$nextArrow.appendTo(e.options.appendArrows),e.options.infinite!==!0&&e.$prevArrow.addClass("slick-disabled"))},e.prototype.buildDots=function(){var e,t,o=this;if(o.options.dots===!0&&o.slideCount>o.options.slidesToShow){for(t='<ul class="'+o.options.dotsClass+'">',e=0;e<=o.getDotCount();e+=1)t+="<li>"+o.options.customPaging.call(this,o,e)+"</li>";t+="</ul>",o.$dots=i(t).appendTo(o.options.appendDots),o.$dots.find("li").first().addClass("slick-active")}},e.prototype.buildOut=function(){var e=this;e.$slides=e.$slider.children(e.options.slide+":not(.slick-cloned)").addClass("slick-slide"),e.slideCount=e.$slides.length,e.$slides.each(function(e,t){i(t).attr("index",e)}),e.$slidesCache=e.$slides,e.$slider.addClass("slick-slider"),e.$slideTrack=0===e.slideCount?i('<div class="slick-track"/>').appendTo(e.$slider):e.$slides.wrapAll('<div class="slick-track"/>').parent(),e.$list=e.$slideTrack.wrap('<div class="slick-list"/>').parent(),e.$slideTrack.css("opacity",0),e.options.centerMode===!0&&(e.options.slidesToScroll=1),i("img[data-lazy]",e.$slider).not("[src]").addClass("slick-loading"),e.setupInfinite(),e.buildArrows(),e.buildDots(),e.updateDots(),e.options.accessibility===!0&&e.$list.prop("tabIndex",0),e.setSlideClasses("number"==typeof this.currentSlide?this.currentSlide:0),e.options.draggable===!0&&e.$list.addClass("draggable")},e.prototype.checkResponsive=function(){var e,t,o,s=this,n=s.$slider.width(),l=window.innerWidth||i(window).width();if("window"===s.respondTo?o=l:"slider"===s.respondTo?o=n:"min"===s.respondTo&&(o=Math.min(l,n)),s.originalSettings.responsive&&s.originalSettings.responsive.length>-1&&null!==s.originalSettings.responsive){t=null;for(e in s.breakpoints)s.breakpoints.hasOwnProperty(e)&&o<s.breakpoints[e]&&(t=s.breakpoints[e]);null!==t?null!==s.activeBreakpoint?t!==s.activeBreakpoint&&(s.activeBreakpoint=t,s.options=i.extend({},s.originalSettings,s.breakpointSettings[t]),s.refresh()):(s.activeBreakpoint=t,s.options=i.extend({},s.originalSettings,s.breakpointSettings[t]),s.refresh()):null!==s.activeBreakpoint&&(s.activeBreakpoint=null,s.options=s.originalSettings,s.refresh())}},e.prototype.changeSlide=function(e,t){var o,s,n,l,r,d=this,a=i(e.target);switch(a.is("a")&&e.preventDefault(),n=d.slideCount%d.options.slidesToScroll!==0,o=n?0:(d.slideCount-d.currentSlide)%d.options.slidesToScroll,e.data.message){case"previous":s=0===o?d.options.slidesToScroll:d.options.slidesToShow-o,d.slideCount>d.options.slidesToShow&&d.slideHandler(d.currentSlide-s,!1,t);break;case"next":s=0===o?d.options.slidesToScroll:o,d.slideCount>d.options.slidesToShow&&d.slideHandler(d.currentSlide+s,!1,t);break;case"index":var c=0===e.data.index?0:e.data.index||i(e.target).parent().index()*d.options.slidesToScroll;if(l=d.getNavigableIndexes(),r=0,l[c]&&l[c]===c)if(c>l[l.length-1])c=l[l.length-1];else for(var p in l){if(c<l[p]){c=r;break}r=l[p]}d.slideHandler(c,!1,t);default:return}},e.prototype.clickHandler=function(i){var e=this;e.shouldClick===!1&&(i.stopImmediatePropagation(),i.stopPropagation(),i.preventDefault())},e.prototype.destroy=function(){var e=this;e.autoPlayClear(),e.touchObject={},i(".slick-cloned",e.$slider).remove(),e.$dots&&e.$dots.remove(),e.$prevArrow&&"object"!=typeof e.options.prevArrow&&e.$prevArrow.remove(),e.$nextArrow&&"object"!=typeof e.options.nextArrow&&e.$nextArrow.remove(),e.$slides.parent().hasClass("slick-track")&&e.$slides.unwrap().unwrap(),e.$slides.removeClass("slick-slide slick-active slick-center slick-visible").removeAttr("index").css({position:"",left:"",top:"",zIndex:"",opacity:"",width:""}),e.$slider.removeClass("slick-slider"),e.$slider.removeClass("slick-initialized"),e.$list.off(".slick"),i(window).off(".slick-"+e.instanceUid),i(document).off(".slick-"+e.instanceUid)},e.prototype.disableTransition=function(i){var e=this,t={};t[e.transitionType]="",e.options.fade===!1?e.$slideTrack.css(t):e.$slides.eq(i).css(t)},e.prototype.fadeSlide=function(i,e,t){var o=this;o.cssTransitions===!1?(o.$slides.eq(e).css({zIndex:1e3}),o.$slides.eq(e).animate({opacity:1},o.options.speed,o.options.easing,t),o.$slides.eq(i).animate({opacity:0},o.options.speed,o.options.easing)):(o.applyTransition(e),o.applyTransition(i),o.$slides.eq(e).css({opacity:1,zIndex:1e3}),o.$slides.eq(i).css({opacity:0}),t&&setTimeout(function(){o.disableTransition(e),o.disableTransition(i),t.call()},o.options.speed))},e.prototype.filterSlides=function(i){var e=this;null!==i&&(e.unload(),e.$slideTrack.children(this.options.slide).detach(),e.$slidesCache.filter(i).appendTo(e.$slideTrack),e.reinit())},e.prototype.getCurrent=function(){var i=this;return i.currentSlide},e.prototype.getDotCount=function(){var i=this,e=0,t=0,o=0;if(i.options.infinite===!0)o=Math.ceil(i.slideCount/i.options.slidesToScroll);else for(;e<i.slideCount;)++o,e=t+i.options.slidesToShow,t+=i.options.slidesToScroll<=i.options.slidesToShow?i.options.slidesToScroll:i.options.slidesToShow;return o-1},e.prototype.getLeft=function(i){var e,t,o,s=this,n=0;return s.slideOffset=0,t=s.$slides.first().outerHeight(),s.options.infinite===!0?(s.slideCount>s.options.slidesToShow&&(s.slideOffset=s.slideWidth*s.options.slidesToShow*-1,n=t*s.options.slidesToShow*-1),s.slideCount%s.options.slidesToScroll!==0&&i+s.options.slidesToScroll>s.slideCount&&s.slideCount>s.options.slidesToShow&&(i>s.slideCount?(s.slideOffset=(s.options.slidesToShow-(i-s.slideCount))*s.slideWidth*-1,n=(s.options.slidesToShow-(i-s.slideCount))*t*-1):(s.slideOffset=s.slideCount%s.options.slidesToScroll*s.slideWidth*-1,n=s.slideCount%s.options.slidesToScroll*t*-1))):i+s.options.slidesToShow>s.slideCount&&(s.slideOffset=(i+s.options.slidesToShow-s.slideCount)*s.slideWidth,n=(i+s.options.slidesToShow-s.slideCount)*t),s.slideCount<=s.options.slidesToShow&&(s.slideOffset=0,n=0),s.options.centerMode===!0&&s.options.infinite===!0?s.slideOffset+=s.slideWidth*Math.floor(s.options.slidesToShow/2)-s.slideWidth:s.options.centerMode===!0&&(s.slideOffset=0,s.slideOffset+=s.slideWidth*Math.floor(s.options.slidesToShow/2)),e=s.options.vertical===!1?i*s.slideWidth*-1+s.slideOffset:i*t*-1+n,s.options.variableWidth===!0&&(o=s.$slideTrack.children(".slick-slide").eq(s.slideCount<=s.options.slidesToShow||s.options.infinite===!1?i:i+s.options.slidesToShow),e=o[0]?-1*o[0].offsetLeft:0,s.options.centerMode===!0&&(o=s.$slideTrack.children(".slick-slide").eq(s.options.infinite===!1?i:i+s.options.slidesToShow+1),e=o[0]?-1*o[0].offsetLeft:0,e+=(s.$list.width()-o.outerWidth())/2)),e},e.prototype.getNavigableIndexes=function(){for(var i=this,e=0,t=0,o=[];e<i.slideCount;)o.push(e),e=t+i.options.slidesToScroll,t+=i.options.slidesToScroll<=i.options.slidesToShow?i.options.slidesToScroll:i.options.slidesToShow;return o},e.prototype.getSlideCount=function(){var e,t=this;if(t.options.swipeToSlide===!0){var o=null;return t.$slideTrack.find(".slick-slide").each(function(e,s){return s.offsetLeft+i(s).outerWidth()/2>-1*t.swipeLeft?(o=s,!1):void 0}),e=Math.abs(i(o).attr("index")-t.currentSlide)}return t.options.slidesToScroll},e.prototype.init=function(){var e=this;i(e.$slider).hasClass("slick-initialized")||(i(e.$slider).addClass("slick-initialized"),e.buildOut(),e.setProps(),e.startLoad(),e.loadSlider(),e.initializeEvents(),e.updateArrows(),e.updateDots()),null!==e.options.onInit&&e.options.onInit.call(this,e)},e.prototype.initArrowEvents=function(){var i=this;i.options.arrows===!0&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.on("click.slick",{message:"previous"},i.changeSlide),i.$nextArrow.on("click.slick",{message:"next"},i.changeSlide))},e.prototype.initDotEvents=function(){var e=this;e.options.dots===!0&&e.slideCount>e.options.slidesToShow&&i("li",e.$dots).on("click.slick",{message:"index"},e.changeSlide),e.options.dots===!0&&e.options.pauseOnDotsHover===!0&&e.options.autoplay===!0&&i("li",e.$dots).on("mouseenter.slick",function(){e.paused=!0,e.autoPlayClear()}).on("mouseleave.slick",function(){e.paused=!1,e.autoPlay()})},e.prototype.initializeEvents=function(){var e=this;e.initArrowEvents(),e.initDotEvents(),e.$list.on("touchstart.slick mousedown.slick",{action:"start"},e.swipeHandler),e.$list.on("touchmove.slick mousemove.slick",{action:"move"},e.swipeHandler),e.$list.on("touchend.slick mouseup.slick",{action:"end"},e.swipeHandler),e.$list.on("touchcancel.slick mouseleave.slick",{action:"end"},e.swipeHandler),e.$list.on("click.slick",e.clickHandler),e.options.pauseOnHover===!0&&e.options.autoplay===!0&&(e.$list.on("mouseenter.slick",function(){e.paused=!0,e.autoPlayClear()}),e.$list.on("mouseleave.slick",function(){e.paused=!1,e.autoPlay()})),e.options.accessibility===!0&&e.$list.on("keydown.slick",e.keyHandler),e.options.focusOnSelect===!0&&i(e.options.slide,e.$slideTrack).on("click.slick",e.selectHandler),i(window).on("orientationchange.slick.slick-"+e.instanceUid,function(){e.checkResponsive(),e.setPosition()}),i(window).on("resize.slick.slick-"+e.instanceUid,function(){i(window).width()!==e.windowWidth&&(clearTimeout(e.windowDelay),e.windowDelay=window.setTimeout(function(){e.windowWidth=i(window).width(),e.checkResponsive(),e.setPosition()},50))}),i("*[draggable!=true]",e.$slideTrack).on("dragstart",function(i){i.preventDefault()}),i(window).on("load.slick.slick-"+e.instanceUid,e.setPosition),i(document).on("ready.slick.slick-"+e.instanceUid,e.setPosition)},e.prototype.initUI=function(){var i=this;i.options.arrows===!0&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.show(),i.$nextArrow.show()),i.options.dots===!0&&i.slideCount>i.options.slidesToShow&&i.$dots.show(),i.options.autoplay===!0&&i.autoPlay()},e.prototype.keyHandler=function(i){var e=this;37===i.keyCode&&e.options.accessibility===!0?e.changeSlide({data:{message:"previous"}}):39===i.keyCode&&e.options.accessibility===!0&&e.changeSlide({data:{message:"next"}})},e.prototype.lazyLoad=function(){function e(e){i("img[data-lazy]",e).each(function(){var e=i(this),t=i(this).attr("data-lazy");e.load(function(){e.animate({opacity:1},200)}).css({opacity:0}).attr("src",t).removeAttr("data-lazy").removeClass("slick-loading")})}var t,o,s,n,l=this;l.options.centerMode===!0?l.options.infinite===!0?(s=l.currentSlide+(l.options.slidesToShow/2+1),n=s+l.options.slidesToShow+2):(s=Math.max(0,l.currentSlide-(l.options.slidesToShow/2+1)),n=2+(l.options.slidesToShow/2+1)+l.currentSlide):(s=l.options.infinite?l.options.slidesToShow+l.currentSlide:l.currentSlide,n=s+l.options.slidesToShow,l.options.fade===!0&&(s>0&&s--,n<=l.slideCount&&n++)),t=l.$slider.find(".slick-slide").slice(s,n),e(t),l.slideCount<=l.options.slidesToShow?(o=l.$slider.find(".slick-slide"),e(o)):l.currentSlide>=l.slideCount-l.options.slidesToShow?(o=l.$slider.find(".slick-cloned").slice(0,l.options.slidesToShow),e(o)):0===l.currentSlide&&(o=l.$slider.find(".slick-cloned").slice(-1*l.options.slidesToShow),e(o))},e.prototype.loadSlider=function(){var i=this;i.setPosition(),i.$slideTrack.css({opacity:1}),i.$slider.removeClass("slick-loading"),i.initUI(),"progressive"===i.options.lazyLoad&&i.progressiveLazyLoad()},e.prototype.postSlide=function(i){var e=this;null!==e.options.onAfterChange&&e.options.onAfterChange.call(this,e,i),e.animating=!1,e.setPosition(),e.swipeLeft=null,e.options.autoplay===!0&&e.paused===!1&&e.autoPlay()},e.prototype.progressiveLazyLoad=function(){var e,t,o=this;e=i("img[data-lazy]",o.$slider).length,e>0&&(t=i("img[data-lazy]",o.$slider).first(),t.attr("src",t.attr("data-lazy")).removeClass("slick-loading").load(function(){t.removeAttr("data-lazy"),o.progressiveLazyLoad()}).error(function(){t.removeAttr("data-lazy"),o.progressiveLazyLoad()}))},e.prototype.refresh=function(){var e=this,t=e.currentSlide;e.destroy(),i.extend(e,e.initials),e.init(),e.changeSlide({data:{message:"index",index:t}},!0)},e.prototype.reinit=function(){var e=this;e.$slides=e.$slideTrack.children(e.options.slide).addClass("slick-slide"),e.slideCount=e.$slides.length,e.currentSlide>=e.slideCount&&0!==e.currentSlide&&(e.currentSlide=e.currentSlide-e.options.slidesToScroll),e.slideCount<=e.options.slidesToShow&&(e.currentSlide=0),e.setProps(),e.setupInfinite(),e.buildArrows(),e.updateArrows(),e.initArrowEvents(),e.buildDots(),e.updateDots(),e.initDotEvents(),e.options.focusOnSelect===!0&&i(e.options.slide,e.$slideTrack).on("click.slick",e.selectHandler),e.setSlideClasses(0),e.setPosition(),null!==e.options.onReInit&&e.options.onReInit.call(this,e)},e.prototype.removeSlide=function(i,e,t){var o=this;return"boolean"==typeof i?(e=i,i=e===!0?0:o.slideCount-1):i=e===!0?--i:i,o.slideCount<1||0>i||i>o.slideCount-1?!1:(o.unload(),t===!0?o.$slideTrack.children().remove():o.$slideTrack.children(this.options.slide).eq(i).remove(),o.$slides=o.$slideTrack.children(this.options.slide),o.$slideTrack.children(this.options.slide).detach(),o.$slideTrack.append(o.$slides),o.$slidesCache=o.$slides,void o.reinit())},e.prototype.setCSS=function(i){var e,t,o=this,s={};o.options.rtl===!0&&(i=-i),e="left"==o.positionProp?i+"px":"0px",t="top"==o.positionProp?i+"px":"0px",s[o.positionProp]=i,o.transformsEnabled===!1?o.$slideTrack.css(s):(s={},o.cssTransitions===!1?(s[o.animType]="translate("+e+", "+t+")",o.$slideTrack.css(s)):(s[o.animType]="translate3d("+e+", "+t+", 0px)",o.$slideTrack.css(s)))},e.prototype.setDimensions=function(){var e=this;if(e.options.vertical===!1?e.options.centerMode===!0&&e.$list.css({padding:"0px "+e.options.centerPadding}):(e.$list.height(e.$slides.first().outerHeight(!0)*e.options.slidesToShow),e.options.centerMode===!0&&e.$list.css({padding:e.options.centerPadding+" 0px"})),e.listWidth=e.$list.width(),e.listHeight=e.$list.height(),e.options.vertical===!1&&e.options.variableWidth===!1)e.slideWidth=Math.ceil(e.listWidth/e.options.slidesToShow),e.$slideTrack.width(Math.ceil(e.slideWidth*e.$slideTrack.children(".slick-slide").length));else if(e.options.variableWidth===!0){var t=0;e.slideWidth=Math.ceil(e.listWidth/e.options.slidesToShow),e.$slideTrack.children(".slick-slide").each(function(){t+=Math.ceil(i(this).outerWidth(!0))}),e.$slideTrack.width(Math.ceil(t)+1)}else e.slideWidth=Math.ceil(e.listWidth),e.$slideTrack.height(Math.ceil(e.$slides.first().outerHeight(!0)*e.$slideTrack.children(".slick-slide").length));var o=e.$slides.first().outerWidth(!0)-e.$slides.first().width();e.options.variableWidth===!1&&e.$slideTrack.children(".slick-slide").width(e.slideWidth-o)},e.prototype.setFade=function(){var e,t=this;t.$slides.each(function(o,s){e=t.slideWidth*o*-1,i(s).css(t.options.rtl===!0?{position:"relative",right:e,top:0,zIndex:800,opacity:0}:{position:"relative",left:e,top:0,zIndex:800,opacity:0})}),t.$slides.eq(t.currentSlide).css({zIndex:900,opacity:1})},e.prototype.setHeight=function(){var i=this;if(1===i.options.slidesToShow&&i.options.adaptiveHeight===!0&&i.options.vertical===!1){var e=i.$slides.eq(i.currentSlide).outerHeight(!0);i.$list.css("height",e)}},e.prototype.setPosition=function(){var i=this;i.setDimensions(),i.setHeight(),i.options.fade===!1?i.setCSS(i.getLeft(i.currentSlide)):i.setFade(),null!==i.options.onSetPosition&&i.options.onSetPosition.call(this,i)},e.prototype.setProps=function(){var i=this,e=document.body.style;i.positionProp=i.options.vertical===!0?"top":"left","top"===i.positionProp?i.$slider.addClass("slick-vertical"):i.$slider.removeClass("slick-vertical"),(void 0!==e.WebkitTransition||void 0!==e.MozTransition||void 0!==e.msTransition)&&i.options.useCSS===!0&&(i.cssTransitions=!0),void 0!==e.OTransform&&(i.animType="OTransform",i.transformType="-o-transform",i.transitionType="OTransition",void 0===e.perspectiveProperty&&void 0===e.webkitPerspective&&(i.animType=!1)),void 0!==e.MozTransform&&(i.animType="MozTransform",i.transformType="-moz-transform",i.transitionType="MozTransition",void 0===e.perspectiveProperty&&void 0===e.MozPerspective&&(i.animType=!1)),void 0!==e.webkitTransform&&(i.animType="webkitTransform",i.transformType="-webkit-transform",i.transitionType="webkitTransition",void 0===e.perspectiveProperty&&void 0===e.webkitPerspective&&(i.animType=!1)),void 0!==e.msTransform&&(i.animType="msTransform",i.transformType="-ms-transform",i.transitionType="msTransition",void 0===e.msTransform&&(i.animType=!1)),void 0!==e.transform&&i.animType!==!1&&(i.animType="transform",i.transformType="transform",i.transitionType="transition"),i.transformsEnabled=null!==i.animType&&i.animType!==!1},e.prototype.setSlideClasses=function(i){var e,t,o,s,n=this;n.$slider.find(".slick-slide").removeClass("slick-active").removeClass("slick-center"),t=n.$slider.find(".slick-slide"),n.options.centerMode===!0?(e=Math.floor(n.options.slidesToShow/2),n.options.infinite===!0&&(i>=e&&i<=n.slideCount-1-e?n.$slides.slice(i-e,i+e+1).addClass("slick-active"):(o=n.options.slidesToShow+i,t.slice(o-e+1,o+e+2).addClass("slick-active")),0===i?t.eq(t.length-1-n.options.slidesToShow).addClass("slick-center"):i===n.slideCount-1&&t.eq(n.options.slidesToShow).addClass("slick-center")),n.$slides.eq(i).addClass("slick-center")):i>=0&&i<=n.slideCount-n.options.slidesToShow?n.$slides.slice(i,i+n.options.slidesToShow).addClass("slick-active"):t.length<=n.options.slidesToShow?t.addClass("slick-active"):(s=n.slideCount%n.options.slidesToShow,o=n.options.infinite===!0?n.options.slidesToShow+i:i,n.options.slidesToShow==n.options.slidesToScroll&&n.slideCount-i<n.options.slidesToShow?t.slice(o-(n.options.slidesToShow-s),o+s).addClass("slick-active"):t.slice(o,o+n.options.slidesToShow).addClass("slick-active")),"ondemand"===n.options.lazyLoad&&n.lazyLoad()},e.prototype.setupInfinite=function(){var e,t,o,s=this;if(s.options.fade===!0&&(s.options.centerMode=!1),s.options.infinite===!0&&s.options.fade===!1&&(t=null,s.slideCount>s.options.slidesToShow)){for(o=s.options.centerMode===!0?s.options.slidesToShow+1:s.options.slidesToShow,e=s.slideCount;e>s.slideCount-o;e-=1)t=e-1,i(s.$slides[t]).clone(!0).attr("id","").attr("index",t-s.slideCount).prependTo(s.$slideTrack).addClass("slick-cloned");for(e=0;o>e;e+=1)t=e,i(s.$slides[t]).clone(!0).attr("id","").attr("index",t+s.slideCount).appendTo(s.$slideTrack).addClass("slick-cloned");s.$slideTrack.find(".slick-cloned").find("[id]").each(function(){i(this).attr("id","")})}},e.prototype.selectHandler=function(e){var t=this,o=parseInt(i(e.target).parents(".slick-slide").attr("index"));return o||(o=0),t.slideCount<=t.options.slidesToShow?(t.$slider.find(".slick-slide").removeClass("slick-active"),t.$slides.eq(o).addClass("slick-active"),t.options.centerMode===!0&&(t.$slider.find(".slick-slide").removeClass("slick-center"),t.$slides.eq(o).addClass("slick-center")),void t.asNavFor(o)):void t.slideHandler(o)},e.prototype.slideHandler=function(i,e,t){var o,s,n,l,r=null,d=this;return e=e||!1,d.animating===!0&&d.options.waitForAnimate===!0||d.options.fade===!0&&d.currentSlide===i||d.slideCount<=d.options.slidesToShow?void 0:(e===!1&&d.asNavFor(i),o=i,r=d.getLeft(o),l=d.getLeft(d.currentSlide),d.currentLeft=null===d.swipeLeft?l:d.swipeLeft,d.options.infinite===!1&&d.options.centerMode===!1&&(0>i||i>d.getDotCount()*d.options.slidesToScroll)?void(d.options.fade===!1&&(o=d.currentSlide,t!==!0?d.animateSlide(l,function(){d.postSlide(o)}):d.postSlide(o))):d.options.infinite===!1&&d.options.centerMode===!0&&(0>i||i>d.slideCount-d.options.slidesToScroll)?void(d.options.fade===!1&&(o=d.currentSlide,t!==!0?d.animateSlide(l,function(){d.postSlide(o)}):d.postSlide(o))):(d.options.autoplay===!0&&clearInterval(d.autoPlayTimer),s=0>o?d.slideCount%d.options.slidesToScroll!==0?d.slideCount-d.slideCount%d.options.slidesToScroll:d.slideCount+o:o>=d.slideCount?d.slideCount%d.options.slidesToScroll!==0?0:o-d.slideCount:o,d.animating=!0,null!==d.options.onBeforeChange&&i!==d.currentSlide&&d.options.onBeforeChange.call(this,d,d.currentSlide,s),n=d.currentSlide,d.currentSlide=s,d.setSlideClasses(d.currentSlide),d.updateDots(),d.updateArrows(),d.options.fade===!0?void(t!==!0?d.fadeSlide(n,s,function(){d.postSlide(s)}):d.postSlide(s)):void(t!==!0?d.animateSlide(r,function(){d.postSlide(s)}):d.postSlide(s))))},e.prototype.startLoad=function(){var i=this;i.options.arrows===!0&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.hide(),i.$nextArrow.hide()),i.options.dots===!0&&i.slideCount>i.options.slidesToShow&&i.$dots.hide(),i.$slider.addClass("slick-loading")},e.prototype.swipeDirection=function(){var i,e,t,o,s=this;return i=s.touchObject.startX-s.touchObject.curX,e=s.touchObject.startY-s.touchObject.curY,t=Math.atan2(e,i),o=Math.round(180*t/Math.PI),0>o&&(o=360-Math.abs(o)),45>=o&&o>=0?s.options.rtl===!1?"left":"right":360>=o&&o>=315?s.options.rtl===!1?"left":"right":o>=135&&225>=o?s.options.rtl===!1?"right":"left":"vertical"},e.prototype.swipeEnd=function(){var i=this;if(i.dragging=!1,i.shouldClick=i.touchObject.swipeLength>10?!1:!0,void 0===i.touchObject.curX)return!1;if(i.touchObject.swipeLength>=i.touchObject.minSwipe)switch(i.swipeDirection()){case"left":i.slideHandler(i.currentSlide+i.getSlideCount()),i.currentDirection=0,i.touchObject={};break;case"right":i.slideHandler(i.currentSlide-i.getSlideCount()),i.currentDirection=1,i.touchObject={}}else i.touchObject.startX!==i.touchObject.curX&&(i.slideHandler(i.currentSlide),i.touchObject={})},e.prototype.swipeHandler=function(i){var e=this;if(!(e.options.swipe===!1||"ontouchend"in document&&e.options.swipe===!1||e.options.draggable===!1&&-1!==i.type.indexOf("mouse")))switch(e.touchObject.fingerCount=i.originalEvent&&void 0!==i.originalEvent.touches?i.originalEvent.touches.length:1,e.touchObject.minSwipe=e.listWidth/e.options.touchThreshold,i.data.action){case"start":e.swipeStart(i);break;case"move":e.swipeMove(i);break;case"end":e.swipeEnd(i)}},e.prototype.swipeMove=function(i){var e,t,o,s,n=this;return s=void 0!==i.originalEvent?i.originalEvent.touches:null,!n.dragging||s&&1!==s.length?!1:(e=n.getLeft(n.currentSlide),n.touchObject.curX=void 0!==s?s[0].pageX:i.clientX,n.touchObject.curY=void 0!==s?s[0].pageY:i.clientY,n.touchObject.swipeLength=Math.round(Math.sqrt(Math.pow(n.touchObject.curX-n.touchObject.startX,2))),t=n.swipeDirection(),"vertical"!==t?(void 0!==i.originalEvent&&n.touchObject.swipeLength>4&&i.preventDefault(),o=(n.options.rtl===!1?1:-1)*(n.touchObject.curX>n.touchObject.startX?1:-1),n.swipeLeft=n.options.vertical===!1?e+n.touchObject.swipeLength*o:e+n.touchObject.swipeLength*(n.$list.height()/n.listWidth)*o,n.options.fade===!0||n.options.touchMove===!1?!1:n.animating===!0?(n.swipeLeft=null,!1):void n.setCSS(n.swipeLeft)):void 0)},e.prototype.swipeStart=function(i){var e,t=this;return 1!==t.touchObject.fingerCount||t.slideCount<=t.options.slidesToShow?(t.touchObject={},!1):(void 0!==i.originalEvent&&void 0!==i.originalEvent.touches&&(e=i.originalEvent.touches[0]),t.touchObject.startX=t.touchObject.curX=void 0!==e?e.pageX:i.clientX,t.touchObject.startY=t.touchObject.curY=void 0!==e?e.pageY:i.clientY,void(t.dragging=!0))},e.prototype.unfilterSlides=function(){var i=this;null!==i.$slidesCache&&(i.unload(),i.$slideTrack.children(this.options.slide).detach(),i.$slidesCache.appendTo(i.$slideTrack),i.reinit())},e.prototype.unload=function(){var e=this;i(".slick-cloned",e.$slider).remove(),e.$dots&&e.$dots.remove(),e.$prevArrow&&"object"!=typeof e.options.prevArrow&&e.$prevArrow.remove(),e.$nextArrow&&"object"!=typeof e.options.nextArrow&&e.$nextArrow.remove(),e.$slides.removeClass("slick-slide slick-active slick-visible").css("width","")},e.prototype.updateArrows=function(){var i,e=this;i=Math.floor(e.options.slidesToShow/2),e.options.arrows===!0&&e.options.infinite!==!0&&e.slideCount>e.options.slidesToShow&&(e.$prevArrow.removeClass("slick-disabled"),e.$nextArrow.removeClass("slick-disabled"),0===e.currentSlide?(e.$prevArrow.addClass("slick-disabled"),e.$nextArrow.removeClass("slick-disabled")):e.currentSlide>=e.slideCount-e.options.slidesToShow&&e.options.centerMode===!1?(e.$nextArrow.addClass("slick-disabled"),e.$prevArrow.removeClass("slick-disabled")):e.currentSlide>e.slideCount-e.options.slidesToShow+i&&e.options.centerMode===!0&&(e.$nextArrow.addClass("slick-disabled"),e.$prevArrow.removeClass("slick-disabled")))},e.prototype.updateDots=function(){var i=this;null!==i.$dots&&(i.$dots.find("li").removeClass("slick-active"),i.$dots.find("li").eq(Math.floor(i.currentSlide/i.options.slidesToScroll)).addClass("slick-active"))},i.fn.slick=function(i){var t=this;return t.each(function(t,o){o.slick=new e(o,i)})},i.fn.slickAdd=function(i,e,t){var o=this;return o.each(function(o,s){s.slick.addSlide(i,e,t)})},i.fn.slickCurrentSlide=function(){var i=this;return i.get(0).slick.getCurrent()},i.fn.slickFilter=function(i){var e=this;return e.each(function(e,t){t.slick.filterSlides(i)})},i.fn.slickGoTo=function(i,e){var t=this;return t.each(function(t,o){o.slick.changeSlide({data:{message:"index",index:parseInt(i)}},e)})},i.fn.slickNext=function(){var i=this;return i.each(function(i,e){e.slick.changeSlide({data:{message:"next"}})})},i.fn.slickPause=function(){var i=this;return i.each(function(i,e){e.slick.autoPlayClear(),e.slick.paused=!0})},i.fn.slickPlay=function(){var i=this;return i.each(function(i,e){e.slick.paused=!1,e.slick.autoPlay()})},i.fn.slickPrev=function(){var i=this;return i.each(function(i,e){e.slick.changeSlide({data:{message:"previous"}})})},i.fn.slickRemove=function(i,e){var t=this;return t.each(function(t,o){o.slick.removeSlide(i,e)})},i.fn.slickRemoveAll=function(){var i=this;return i.each(function(i,e){e.slick.removeSlide(null,null,!0)})},i.fn.slickGetOption=function(i){var e=this;return e.get(0).slick.options[i]},i.fn.slickSetOption=function(i,e,t){var o=this;return o.each(function(o,s){s.slick.options[i]=e,t===!0&&(s.slick.unload(),s.slick.reinit())})},i.fn.slickUnfilter=function(){var i=this;return i.each(function(i,e){e.slick.unfilterSlides()})},i.fn.unslick=function(){var i=this;return i.each(function(i,e){e.slick&&e.slick.destroy()})},i.fn.getSlick=function(){var i=null,e=this;return e.each(function(e,t){i=t.slick}),i}});