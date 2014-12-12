!function(e){"function"==typeof define&&define.amd?define(["jquery","moment"],e):e(jQuery,moment)}(function(e,a){var t={words:{m:["jedan minut","jedne minute"],mm:["minut","minute","minuta"],h:["jedan sat","jednog sata"],hh:["sat","sata","sati"],dd:["dan","dana","dana"],MM:["mesec","meseca","meseci"],yy:["godina","godine","godina"]},correctGrammaticalCase:function(e,a){return 1===e?a[0]:e>=2&&4>=e?a[1]:a[2]},translate:function(e,a,n){var r=t.words[n];return 1===n.length?a?r[0]:r[1]:e+" "+t.correctGrammaticalCase(e,r)}};(a.defineLocale||a.lang).call(a,"sr",{months:["januar","februar","mart","april","maj","jun","jul","avgust","septembar","oktobar","novembar","decembar"],monthsShort:["jan.","feb.","mar.","apr.","maj","jun","jul","avg.","sep.","okt.","nov.","dec."],weekdays:["nedelja","ponedeljak","utorak","sreda","\u010detvrtak","petak","subota"],weekdaysShort:["ned.","pon.","uto.","sre.","\u010det.","pet.","sub."],weekdaysMin:["ne","po","ut","sr","\u010de","pe","su"],longDateFormat:{LT:"H:mm",LTS:"LT:ss",L:"DD. MM. YYYY",LL:"D. MMMM YYYY",LLL:"D. MMMM YYYY LT",LLLL:"dddd, D. MMMM YYYY LT"},calendar:{sameDay:"[danas u] LT",nextDay:"[sutra u] LT",nextWeek:function(){switch(this.day()){case 0:return"[u] [nedelju] [u] LT";case 3:return"[u] [sredu] [u] LT";case 6:return"[u] [subotu] [u] LT";case 1:case 2:case 4:case 5:return"[u] dddd [u] LT"}},lastDay:"[ju\u010de u] LT",lastWeek:function(){var e=["[pro\u0161le] [nedelje] [u] LT","[pro\u0161log] [ponedeljka] [u] LT","[pro\u0161log] [utorka] [u] LT","[pro\u0161le] [srede] [u] LT","[pro\u0161log] [\u010detvrtka] [u] LT","[pro\u0161log] [petka] [u] LT","[pro\u0161le] [subote] [u] LT"];return e[this.day()]},sameElse:"L"},relativeTime:{future:"za %s",past:"pre %s",s:"nekoliko sekundi",m:t.translate,mm:t.translate,h:t.translate,hh:t.translate,d:"dan",dd:t.translate,M:"mesec",MM:t.translate,y:"godinu",yy:t.translate},ordinalParse:/\d{1,2}\./,ordinal:"%d.",week:{dow:1,doy:7}}),e.fullCalendar.datepickerLang("sr","sr",{closeText:"\u0417\u0430\u0442\u0432\u043e\u0440\u0438",prevText:"&#x3C;",nextText:"&#x3E;",currentText:"\u0414\u0430\u043d\u0430\u0441",monthNames:["\u0408\u0430\u043d\u0443\u0430\u0440","\u0424\u0435\u0431\u0440\u0443\u0430\u0440","\u041c\u0430\u0440\u0442","\u0410\u043f\u0440\u0438\u043b","\u041c\u0430\u0458","\u0408\u0443\u043d","\u0408\u0443\u043b","\u0410\u0432\u0433\u0443\u0441\u0442","\u0421\u0435\u043f\u0442\u0435\u043c\u0431\u0430\u0440","\u041e\u043a\u0442\u043e\u0431\u0430\u0440","\u041d\u043e\u0432\u0435\u043c\u0431\u0430\u0440","\u0414\u0435\u0446\u0435\u043c\u0431\u0430\u0440"],monthNamesShort:["\u0408\u0430\u043d","\u0424\u0435\u0431","\u041c\u0430\u0440","\u0410\u043f\u0440","\u041c\u0430\u0458","\u0408\u0443\u043d","\u0408\u0443\u043b","\u0410\u0432\u0433","\u0421\u0435\u043f","\u041e\u043a\u0442","\u041d\u043e\u0432","\u0414\u0435\u0446"],dayNames:["\u041d\u0435\u0434\u0435\u0459\u0430","\u041f\u043e\u043d\u0435\u0434\u0435\u0459\u0430\u043a","\u0423\u0442\u043e\u0440\u0430\u043a","\u0421\u0440\u0435\u0434\u0430","\u0427\u0435\u0442\u0432\u0440\u0442\u0430\u043a","\u041f\u0435\u0442\u0430\u043a","\u0421\u0443\u0431\u043e\u0442\u0430"],dayNamesShort:["\u041d\u0435\u0434","\u041f\u043e\u043d","\u0423\u0442\u043e","\u0421\u0440\u0435","\u0427\u0435\u0442","\u041f\u0435\u0442","\u0421\u0443\u0431"],dayNamesMin:["\u041d\u0435","\u041f\u043e","\u0423\u0442","\u0421\u0440","\u0427\u0435","\u041f\u0435","\u0421\u0443"],weekHeader:"\u0421\u0435\u0434",dateFormat:"dd.mm.yy",firstDay:1,isRTL:!1,showMonthAfterYear:!1,yearSuffix:""}),e.fullCalendar.lang("sr",{defaultButtonText:{month:"\u041c\u0435\u0441\u0435\u0446",week:"\u041d\u0435\u0434\u0435\u0459\u0430",day:"\u0414\u0430\u043d",list:"\u041f\u043b\u0430\u043d\u0435\u0440"},allDayText:"\u0426\u0435\u043e \u0434\u0430\u043d",eventLimitText:function(e){return"+ \u0458\u043e\u0448 "+e}})});