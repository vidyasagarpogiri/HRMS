!function(t,e){"use strict";function i(t,e){var i=e||{};for(var s in t)s in i||(i[s]=t[s]);return i}function s(t,i){if(r)r(t).trigger(i);else{var s=e.createEvent("CustomEvent");s.initCustomEvent(i,!0,!0,{}),t.dispatchEvent(s)}}function a(t,e){return r?r(t).hasClass(e):t.classList.contains(e)}function n(t,e){if(this.dateDelta=null,this.timeDelta=null,this._defaults={startClass:"start",endClass:"end",timeClass:"time",dateClass:"date",defaultDateDelta:0,defaultTimeDelta:36e5,parseTime:function(t){return r(t).timepicker("getTime")},updateTime:function(t,e){r(t).timepicker("setTime",e)},setMinTime:function(t,e){r(t).timepicker("option","minTime",e)},parseDate:function(t){return r(t).datepicker("getDate")},updateDate:function(t,e){r(t).datepicker("update",e)}},this.container=t,this.settings=i(this._defaults,e),this.startDateInput=this.container.querySelector("."+this.settings.startClass+"."+this.settings.dateClass),this.endDateInput=this.container.querySelector("."+this.settings.endClass+"."+this.settings.dateClass),this.startTimeInput=this.container.querySelector("."+this.settings.startClass+"."+this.settings.timeClass),this.endTimeInput=this.container.querySelector("."+this.settings.endClass+"."+this.settings.timeClass),this.startDateInput&&this.startDateInput.value&&this.startDateInput&&this.endDateInput.value){var s=this.settings.parseDate(this.startDateInput),a=this.settings.parseDate(this.endDateInput);this.dateDelta=a.getTime()-s.getTime()}if(this.startTimeInput&&this.startTimeInput.value&&this.endTimeInput&&this.endTimeInput.value){var n=this.settings.parseTime(this.startTimeInput),h=this.settings.parseTime(this.endTimeInput);this.timeDelta=h.getTime()-n.getTime()}this._bindChangeHandler()}var h=864e5,r=t.Zepto||t.jQuery;n.prototype={constructor:n,_bindChangeHandler:function(){r?r(this.container).on("change.datepair",r.proxy(this.handleEvent,this)):this.container.addEventListener("change",this,!1)},_unbindChangeHandler:function(){r?r(this.container).off("change.datepair"):this.container.removeEventListener("change",this,!1)},handleEvent:function(t){this._unbindChangeHandler(),a(t.target,this.settings.dateClass)?""!=t.target.value?this._dateChanged(t.target):this.dateDelta=null:a(t.target,this.settings.timeClass)&&(""!=t.target.value?this._timeChanged(t.target):this.timeDelta=null),this._validateRanges(),this._updateEndMintime(),this._bindChangeHandler()},_dateChanged:function(t){if(this.startDateInput&&this.endDateInput)if(this.startDateInput.value&&this.endDateInput.value){var e=this.settings.parseDate(this.startDateInput),i=this.settings.parseDate(this.endDateInput);if(a(t,this.settings.startClass)){var s=new Date(e.getTime()+this.dateDelta);this.settings.updateDate(this.endDateInput,s)}else a(t,this.settings.endClass)&&(e>i?(this.dateDelta=0,this.settings.updateDate(this.startDateInput,i)):this.dateDelta=i.getTime()-e.getTime())}else if(null!==this.settings.defaultDateDelta){if(this.startDateInput.value){var e=this.settings.parseDate(this.startDateInput),n=new Date(e.getTime()+this.settings.defaultDateDelta*h);this.settings.updateDate(this.endDateInput,n)}else if(this.endDateInput.value){var i=this.settings.parseDate($endDateInput),r=new Date(i.getTime()-this.settings.defaultDateDelta*h);this.settings.updateDate(this.startDateInput,r)}this.dateDelta=this.settings.defaultDateDelta*h}else this.dateDelta=null},_timeChanged:function(t){if(this.startTimeInput&&this.endTimeInput)if(this.startTimeInput.value&&this.endTimeInput.value){var e=this.settings.parseTime(this.startTimeInput),i=this.settings.parseTime(this.endTimeInput);if(a(t,this.settings.startClass)){var s=new Date(e.getTime()+this.timeDelta);this.settings.updateTime(this.endTimeInput,s),i=this.settings.parseTime(this.endTimeInput)}if(this.endDateInput&&this.endDateInput.value&&this.dateDelta+this.timeDelta<h&&(i.getTime()-e.getTime())*this.timeDelta<0){var n=e>i?h:-1*h,r=this.settings.parseDate(this.endDateInput);this.settings.updateDate(this.endDateInput,new Date(r.getTime()+n)),this._dateChanged(this.endDateInput)}this.timeDelta=i.getTime()-e.getTime()}else if(null!==this.settings.defaultTimeDelta){if(this.startTimeInput.value){var e=this.settings.parseTime(this.startTimeInput),u=new Date(e.getTime()+this.settings.defaultTimeDelta);this.settings.updateTime(this.endTimeInput,u)}else if(this.endTimeInput.value){var i=this.settings.parseTime(this.endTimeInput),l=new Date(i.getTime()-this.settings.defaultTimeDelta);this.settings.updateTime(this.startTimeInput,l)}this.timeDelta=this.settings.defaultTimeDelta}else this.timeDelta=null},_updateEndMintime:function(){if("function"==typeof this.settings.setMinTime){var t=null;(!this.dateDelta||this.dateDelta<h||this.timeDelta&&this.dateDelta+this.timeDelta<h)&&(t=this.settings.parseTime(this.startTimeInput)),this.settings.setMinTime(this.endTimeInput,t)}},_validateRanges:function(){return this.startTimeInput&&this.endTimeInput&&null===this.timeDelta?void s(this.container,"rangeIncomplete"):this.startDateInput&&this.endDateInput&&null===this.dateDelta?void s(this.container,"rangeIncomplete"):void(this.dateDelta+this.timeDelta>=0?s(this.container,"rangeSelected"):s(this.container,"rangeError"))}},t.Datepair=n}(window,document),function(t){t&&(t.fn.datepair=function(e){var i;return this.each(function(){var s=t(this),a=s.data("datepair"),n="object"==typeof e&&e;a||(a=new Datepair(this,n),s.data("datepair",a)),"string"==typeof e&&(i=a[e]())}),i},t("[data-datepair]").each(function(){var e=t(this);e.datepair(e.data())}))}(window.Zepto||window.jQuery);