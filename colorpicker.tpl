<link rel="stylesheet" href="{$assets_url}/components/colorpicker/colorpicker.css" />

<input id="tv{$tv->id}" type="text"
	value="{$tv->value}" name="tv{$tv->id}"
	onblur="MODx.fireResourceFormChange();" style="text-shadow:none"/>
	
<script type="text/javascript">
// <![CDATA[
{literal}

    Ext.onReady(function() {
		/**
		 * @class Ext.ux.ColorPicker
		 * @extends Ext.BoxComponent
		 * This is a color picker.
		 * @license: LGPLv3
		 * @author: Amon
		 * @constructor
		 * Creates a new ColorPicker
		 * @param {Object} config Configuration options
		 * @version 1.1.2
		 */
		Ext.namespace( 'Ext.ux' );
		Ext.ux.ColorPicker=Ext.extend(Ext.BoxComponent,{initComponent:function(){this.applyDefaultsCP();Ext.ux.ColorPicker.superclass.initComponent.apply(this,arguments);this.addEvents('select')},onRender:function(){Ext.ux.ColorPicker.superclass.onRender.apply(this,arguments);this.body=this.body||(this.container||(this.renderTo||Ext.DomHelper.append(Ext.getBody(),{},true)));if(!this.el){this.el=this.body;if(this.cls){Ext.get(this.el).addClass(this.cls)}}this.renderComponent()},applyDefaultsCP:function(){Ext.apply(this,{'cls':'x-cp-mainpanel','resizable':this.resizable||false,'HSV':{h:0,s:0,v:0},updateMode:null})},renderComponent:function(){Ext.DomHelper.append(this.body,{'id':this.cpGetId('rgb'),'cls':'x-cp-rgbpicker'});Ext.DomHelper.append(this.body,{'id':this.cpGetId('hue'),'cls':'x-cp-huepicker'});this.huePicker=Ext.DomHelper.append(this.body,{'cls':'x-cp-hueslider'});this.hueDD=new Ext.dd.DD(this.huePicker,'huePicker');this.hueDD.constrainTo(this.cpGetId('hue'),{'top':-7,'right':-3,'bottom':-7,'left':-3});this.hueDD.onDrag=this.moveHuePicker.createDelegate(this);Ext.get(this.cpGetId('hue')).on('mousedown',this.clickHUEPicker.createDelegate(this));Ext.get(this.huePicker).moveTo(Ext.get(this.cpGetId('hue')).getLeft()-3,Ext.get(this.cpGetId('hue')).getTop()-7);this.rgbPicker=Ext.DomHelper.append(this.body,{'cls':'x-cp-rgbslider'});this.rgbDD=new Ext.dd.DD(this.rgbPicker,'rgbPicker');this.rgbDD.constrainTo(this.cpGetId('rgb'),-7);this.rgbDD.onDrag=this.moveRGBPicker.createDelegate(this);Ext.get(this.cpGetId('rgb')).on('mousedown',this.clickRGBPicker.createDelegate(this));Ext.get(this.rgbPicker).moveTo(Ext.get(this.cpGetId('rgb')).getLeft()-7,Ext.get(this.cpGetId('rgb')).getTop()-7);this.formPanel=new Ext.form.FormPanel({'renderTo':Ext.DomHelper.append(this.body,{'id':this.cpGetId('fCont'),'cls':'x-cp-formcontainer'},true),'frame':true,'labelAlign':'left','labelWidth':10,'forceLayout':true,'items':[{'layout':'column','items':[{'columnWidth':.5,'layout':'form','defaultType':'numberfield','defaults':{'width':30,'value':0,'minValue':0,'maxValue':255,'allowBlank':false,'labelSeparator':''},'items':[{'fieldLabel':'R','id':this.cpGetId('iRed')},{'fieldLabel':'G','id':this.cpGetId('iGreen')},{'fieldLabel':'B','id':this.cpGetId('iBlue')}]},{'columnWidth':.5,'layout':'form','defaultType':'numberfield','defaults':{'width':30,'value':0,'minValue':0,'maxValue':255,'allowBlank':false,'labelSeparator':''},'items':[{'fieldLabel':'H','maxValue':360,'id':this.cpGetId('iHue')},{'fieldLabel':'S','id':this.cpGetId('iSat')},{'fieldLabel':'V','id':this.cpGetId('iVal')}]}]},{'layout':'form','defaultType':'textfield','labelAlign':'left','defaults':{'width':82,'value':'000000','labelSeparator':'','allowBlank':false},'id':this.cpGetId('cCont'),'items':[{'fieldLabel':'#','id':this.cpGetId('iHexa'),'value':'000000'}]}]});Ext.getCmp(this.cpGetId('iRed')).on('change',this.updateFromIRGB.createDelegate(this));Ext.getCmp(this.cpGetId('iGreen')).on('change',this.updateFromIRGB.createDelegate(this));Ext.getCmp(this.cpGetId('iBlue')).on('change',this.updateFromIRGB.createDelegate(this));Ext.getCmp(this.cpGetId('iHue')).on('change',this.updateFromIHSV.createDelegate(this));Ext.getCmp(this.cpGetId('iSat')).on('change',this.updateFromIHSV.createDelegate(this));Ext.getCmp(this.cpGetId('iVal')).on('change',this.updateFromIHSV.createDelegate(this));Ext.getCmp(this.cpGetId('iHexa')).on('change',this.updateFromIHexa.createDelegate(this));Ext.DomHelper.append(this.cpGetId('cCont'),{'cls':'x-cp-colorbox','id':this.cpGetId('cWebSafe')},true).update('Websafe');Ext.DomHelper.append(this.cpGetId('cCont'),{'cls':'x-cp-colorbox','id':this.cpGetId('cInverse')},true).update('Inverse');Ext.DomHelper.append(this.cpGetId('cCont'),{'cls':'x-cp-colorbox','id':this.cpGetId('cColor')},true).update('OK');Ext.get(this.cpGetId('cWebSafe')).on('click',this.updateFromBox.createDelegate(this));Ext.get(this.cpGetId('cInverse')).on('click',this.updateFromBox.createDelegate(this));Ext.get(this.cpGetId('cColor')).on('click',this.selectColor.createDelegate(this));Ext.DomHelper.append(this.body,{'tag':'br','cls':'x-cp-clearfloat'})},cpGetId:function(postfix){return this.getId()+'__'+(postfix||'cp')},updateRGBPosition:function(x,y){this.updateMode='click';x=x<0?0:x;x=x>181?181:x;y=y<0?0:y;y=y>181?181:y;this.HSV.s=this.getSaturation(x);this.HSV.v=this.getValue(y);Ext.get(this.rgbPicker).moveTo(Ext.get(this.cpGetId('rgb')).getLeft()+x-7,Ext.get(this.cpGetId('rgb')).getTop()+y-7,(this.animateMove||true));this.updateColor()},updateHUEPosition:function(y){this.updateMode='click';y=y<1?1:y;y=y>181?181:y;this.HSV.h=Math.round(360/181*(181-y));Ext.get(this.huePicker).moveTo(Ext.get(this.huePicker).getLeft(),Ext.get(this.cpGetId('hue')).getTop()+y-7,(this.animateMove||true));this.updateRGBPicker(this.HSV.h);this.updateColor()},clickRGBPicker:function(event,element){this.updateRGBPosition(event.xy[0]-Ext.get(this.cpGetId('rgb')).getLeft(),event.xy[1]-Ext.get(this.cpGetId('rgb')).getTop())},clickHUEPicker:function(event,element){this.updateHUEPosition(event.xy[1]-Ext.get(this.cpGetId('hue')).getTop())},moveRGBPicker:function(event){this.rgbDD.constrainTo(this.cpGetId('rgb'),-7);this.updateRGBPosition(Ext.get(this.rgbPicker).getLeft()-Ext.get(this.cpGetId('rgb')).getLeft()+7,Ext.get(this.rgbPicker).getTop()-Ext.get(this.cpGetId('rgb')).getTop()+7)},moveHuePicker:function(event){this.hueDD.constrainTo(this.cpGetId('hue'),{'top':-7,'right':-3,'bottom':-7,'left':-3});this.updateHUEPosition(Ext.get(this.huePicker).getTop()-Ext.get(this.cpGetId('hue')).getTop()+7)},updateRGBPicker:function(newValue){this.updateMode='click';Ext.get(this.cpGetId('rgb')).setStyle({'background-color':'#'+this.rgbToHex(this.hsvToRgb(newValue,1,1))});this.updateColor()},updateColor:function(){var rgb=this.hsvToRgb(this.HSV.h,this.HSV.s,this.HSV.v);var websafe=this.websafe(rgb);var invert=this.invert(rgb);var wsInvert=this.invert(websafe);if(this.updateMode!=='hexa'){Ext.getCmp(this.cpGetId('iHexa')).setValue(this.rgbToHex(rgb))}if(this.updateMode!=='rgb'){Ext.getCmp(this.cpGetId('iRed')).setValue(rgb[0]);Ext.getCmp(this.cpGetId('iGreen')).setValue(rgb[1]);Ext.getCmp(this.cpGetId('iBlue')).setValue(rgb[2])}if(this.updateMode!=='hsv'){Ext.getCmp(this.cpGetId('iHue')).setValue(Math.round(this.HSV.h));Ext.getCmp(this.cpGetId('iSat')).setValue(Math.round(this.HSV.s*100));Ext.getCmp(this.cpGetId('iVal')).setValue(Math.round(this.HSV.v*100))}Ext.get(this.cpGetId('cColor')).setStyle({'background':'#'+this.rgbToHex(rgb),'color':'#'+this.rgbToHex(invert)});Ext.getDom(this.cpGetId('cColor')).title='#'+this.rgbToHex(rgb);Ext.get(this.cpGetId('cInverse')).setStyle({'background':'#'+this.rgbToHex(invert),'color':'#'+this.rgbToHex(rgb)});Ext.getDom(this.cpGetId('cInverse')).title='#'+this.rgbToHex(invert);Ext.get(this.cpGetId('cWebSafe')).setStyle({'background':'#'+this.rgbToHex(websafe),'color':'#'+this.rgbToHex(wsInvert)});Ext.getDom(this.cpGetId('cWebSafe')).title='#'+this.rgbToHex(websafe);Ext.get(this.huePicker).moveTo(Ext.get(this.huePicker).getLeft(),Ext.get(this.cpGetId('hue')).getTop()+this.getHPos(Ext.getCmp(this.cpGetId('iHue')).getValue())-7,(this.animateMove||true));Ext.get(this.rgbPicker).moveTo(Ext.get(this.cpGetId('rgb')).getLeft()+this.getSPos(Ext.getCmp(this.cpGetId('iSat')).getValue()/100)-7,Ext.get(this.cpGetId('hue')).getTop()+this.getVPos(Ext.getCmp(this.cpGetId('iVal')).getValue()/100)-7,(this.animateMove||true));Ext.get(this.cpGetId('rgb')).setStyle({'background-color':'#'+this.rgbToHex(this.hsvToRgb(Ext.getCmp(this.cpGetId('iHue')).getValue(),1,1))})},setColor:function(c){if(!/^[0-9a-fA-F]{6}$/.test(c))return;Ext.getCmp(this.cpGetId('iHexa')).setValue(c);this.updateFromIHexa()},updateFromIRGB:function(input,newValue,oldValue){this.updateMode='rgb';var temp=this.rgbToHsv(Ext.getCmp(this.cpGetId('iRed')).getValue(),Ext.getCmp(this.cpGetId('iGreen')).getValue(),Ext.getCmp(this.cpGetId('iBlue')).getValue());this.HSV={h:temp[0],s:temp[1],v:temp[2]};this.updateColor()},updateFromIHSV:function(input,newValue,oldValue){this.updateMode='hsv';this.HSV={h:Ext.getCmp(this.cpGetId('iHue')).getValue(),s:Ext.getCmp(this.cpGetId('iSat')).getValue()/100,v:Ext.getCmp(this.cpGetId('iVal')).getValue()/100};this.updateColor()},updateFromIHexa:function(input,newValue,oldValue){this.updateMode='hexa';var temp=this.rgbToHsv(this.hexToRgb(Ext.getCmp(this.cpGetId('iHexa')).getValue()));this.HSV={h:temp[0],s:temp[1],v:temp[2]};this.updateColor()},updateFromBox:function(event,element){this.updateMode='click';var temp=this.rgbToHsv(this.hexToRgb(Ext.get(element).getColor('backgroundColor','','')));this.HSV={h:temp[0],s:temp[1],v:temp[2]};this.updateColor()},selectColor:function(event,element){this.fireEvent('select',this,Ext.get(element).getColor('backgroundColor','',''))},hsvToRgb:function(h,s,v){if(h instanceof Array){return this.hsvToRgb.call(this,h[0],h[1],h[2])}var r,g,b,i,f,p,q,t;i=Math.floor((h/60)%6);f=(h/60)-i;p=v*(1-s);q=v*(1-f*s);t=v*(1-(1-f)*s);switch(i){case 0:r=v;g=t;b=p;break;case 1:r=q;g=v;b=p;break;case 2:r=p;g=v;b=t;break;case 3:r=p;g=q;b=v;break;case 4:r=t;g=p;b=v;break;case 5:r=v;g=p;b=q;break}return[this.realToDec(r),this.realToDec(g),this.realToDec(b)]},rgbToHsv:function(r,g,b){if(r instanceof Array){return this.rgbToHsv.call(this,r[0],r[1],r[2])}r=r/255;g=g/255;b=b/255;var min,max,delta,h,s,v;min=Math.min(Math.min(r,g),b);max=Math.max(Math.max(r,g),b);delta=max-min;switch(max){case min:h=0;break;case r:h=60*(g-b)/delta;if(g<b){h+=360}break;case g:h=(60*(b-r)/delta)+120;break;case b:h=(60*(r-g)/delta)+240;break}s=(max===0)?0:1-(min/max);return[Math.round(h),s,max]},realToDec:function(n){return Math.min(255,Math.round(n*256))},rgbToHex:function(r,g,b){if(r instanceof Array){return this.rgbToHex.call(this,r[0],r[1],r[2])}return this.decToHex(r)+this.decToHex(g)+this.decToHex(b)},decToHex:function(n){var HCHARS='0123456789ABCDEF';n=parseInt(n,10);n=(!isNaN(n))?n:0;n=(n>255||n<0)?0:n;return HCHARS.charAt((n-n%16)/16)+HCHARS.charAt(n%16)},getHCharPos:function(c){var HCHARS='0123456789ABCDEF';return HCHARS.indexOf(c.toUpperCase())},hexToDec:function(hex){var s=hex.split('');return((this.getHCharPos(s[0])*16)+this.getHCharPos(s[1]))},hexToRgb:function(hex){return[this.hexToDec(hex.substr(0,2)),this.hexToDec(hex.substr(2,2)),this.hexToDec(hex.substr(4,2))]},getHue:function(y){var hue=360-Math.round(((181-y)/181)*360);return hue===360?0:hue},getHPos:function(hue){return 181-hue*(181/360)},getSaturation:function(x){return x/181},getSPos:function(saturation){return saturation*181},getValue:function(y){return(181-y)/181},getVPos:function(value){return 181-(value*181)},checkSafeNumber:function(v){if(!isNaN(v)){v=Math.min(Math.max(0,v),255);var i,next;for(i=0;i<256;i=i+51){next=i+51;if(v>=i&&v<=next){return(v-i>25)?next:i}}}return v},websafe:function(r,g,b){if(r instanceof Array){return this.websafe.call(this,r[0],r[1],r[2])}return[this.checkSafeNumber(r),this.checkSafeNumber(g),this.checkSafeNumber(b)]},invert:function(r,g,b){if(r instanceof Array){return this.invert.call(this,r[0],r[1],r[2])}return[255-r,255-g,255-b]}});
		Ext.ux.ColorDialog=Ext.extend(Ext.Window,{initComponent:function(){this.width=(!this.width||this.width<353)?353:this.width;this.applyDefaultsCP();Ext.ux.ColorDialog.superclass.initComponent.apply(this,arguments)},onRender:function(){Ext.ux.ColorDialog.superclass.onRender.apply(this,arguments);this.renderComponent()}});Ext.applyIf(Ext.ux.ColorDialog.prototype,Ext.ux.ColorPicker.prototype);Ext.ux.ColorPanel=Ext.extend(Ext.Panel,{initComponent:function(){this.width=(!this.width||this.width<300)?300:this.width;this.applyDefaultsCP();Ext.ux.ColorPanel.superclass.initComponent.apply(this,arguments)},onRender:function(){Ext.ux.ColorPanel.superclass.onRender.apply(this,arguments);this.renderComponent()}});Ext.applyIf(Ext.ux.ColorPanel.prototype,Ext.ux.ColorPicker.prototype);
		Ext.reg( 'colorpicker', Ext.ux.ColorPicker );
		Ext.reg( 'colordialog', Ext.ux.ColorDialog );
		Ext.reg( 'colorpanel', Ext.ux.ColorPanel );
		Ext.namespace("Ext.ux", "Ext.ux.menu", "Ext.ux.form");
		if(Ext.version.substr(0,1)=="2"){Ext.ux.menu.ColorItem=function(config){if(!config)config={};config.style="width:350px;";Ext.ux.menu.ColorItem.superclass.constructor.call(this,new Ext.ux.ColorPicker(config),config);this.picker=this.component;this.addEvents('select');this.picker.on("render",function(picker){picker.getEl().swallowEvent("click")});this.picker.on("select",this.onSelect,this)};Ext.extend(Ext.ux.menu.ColorItem,Ext.menu.Adapter,{onSelect:function(picker,color){this.fireEvent("select",this,color,picker);Ext.ux.menu.ColorItem.superclass.handleClick.call(this)}});Ext.ux.menu.ColorMenu=function(config){Ext.ux.menu.ColorMenu.superclass.constructor.call(this,config);this.plain=true;var ci=new Ext.ux.menu.ColorItem(config);this.add(ci);this.picker=ci.picker;this.relayEvents(ci,["select"])};Ext.extend(Ext.ux.menu.ColorMenu,Ext.menu.Menu,{beforeDestroy:function(){this.picker.destroy()}})}else{Ext.ux.menu.ColorMenu=Ext.extend(Ext.menu.Menu,{enableScrolling:false,hideOnClick:true,initComponent:function(){Ext.apply(this,{plain:true,showSeparator:false,items:this.picker=new Ext.ux.ColorPicker(Ext.apply({style:'width:350px;'},this.initialConfig))});this.picker.purgeListeners();Ext.ux.menu.ColorMenu.superclass.initComponent.call(this);this.relayEvents(this.picker,['select']);this.on('select',this.menuHide,this);if(this.handler){this.on('select',this.handler,this.scope||this)}},menuHide:function(){if(this.hideOnClick){this.hide(true)}}})}
		Ext.ux.form.ColorPickerField=Ext.extend(Ext.form.TriggerField,{initComponent:function(){Ext.ux.form.ColorPickerField.superclass.initComponent.call(this);this.menu=new Ext.ux.menu.ColorMenu()},setValue:function(v){if(/^[0-9a-fA-F]{6}$/.test(v)){Ext.ux.form.ColorPickerField.superclass.setValue.apply(this,arguments);var i=this.menu.picker.rgbToHex(this.menu.picker.invert(this.menu.picker.hexToRgb(v)));this.el.applyStyles('background: #'+v+'; color: #'+i+';')}},onDestroy:function(){if(this.menu){this.menu.destroy()}if(this.wrap){this.wrap.remove()}Ext.ux.form.ColorPickerField.superclass.onDestroy.call(this)},onBlur:function(){Ext.ux.form.ColorPickerField.superclass.onBlur.call(this);var v=this.getValue();if(/^[0-9a-fA-F]{6}$/.test(v)){var i=this.menu.picker.rgbToHex(this.menu.picker.invert(this.menu.picker.hexToRgb(v)));this.el.applyStyles('background: #'+v+'; color: #'+i+';')}else this.el.applyStyles('background: #ffffff; color: #000000;')},menuListeners:{select:function(m,c){this.setValue(c);this.fireEvent("select",this,c);this.focus.defer(10,this)},show:function(m){this.onFocus()},hide:function(){this.focus.defer(10,this);var ml=this.menuListeners;this.menu.un("select",ml.select,this);this.menu.un("show",ml.show,this);this.menu.un("hide",ml.hide,this)}},onTriggerClick:function(){if(this.disabled){return}this.menu.on(Ext.apply({},this.menuListeners,{scope:this}));this.menu.show(this.el,"tl-bl?");this.menu.picker.setColor(this.getValue())}});
		Ext.reg("colorpickerfield", Ext.ux.form.ColorPickerField);

		new Ext.ux.form.ColorPickerField({
			{/literal}
			applyTo: 'tv{$tv->id}'
		    ,name: 'tv{$tv->id}'
		    ,value: '{$tv->value}'
		    {literal}
		    ,width: '100'
		    ,allowBlank: true
		    ,listeners: { 'change': { fn:MODx.fireResourceFormChange, scope:this}}
		});
    });
{/literal}
// ]]>
</script>
	