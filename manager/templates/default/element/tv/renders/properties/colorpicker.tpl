<div id="modx-tv-wprops-form{$tv}"></div>
{literal}

<script type="text/javascript">
// <![CDATA[
var params = {
{/literal}{foreach from=$params key=k item=v name='p'}
 '{$k}': '{$v|escape:"javascript"}'{if NOT $smarty.foreach.p.last},{/if}
{/foreach}{literal}
};
var oc = {'change':{fn:function(){Ext.getCmp('modx-panel-tv').markDirty();},scope:this}};
MODx.load({
    xtype: 'panel'
    ,layout: 'form'
    ,autoHeight: true
    ,labelWidth: 150
    ,border: false
    ,labelAlign: 'top'
    ,cls: 'form-with-labels'
    ,items: [
    {
        xtype: 'combo'
        ,fieldLabel: '{/literal}{$_lang.colorpicker_format|escape:"javascript"}{literal}'
        ,description: '{/literal}{$_lang.colorpicker_format_description|escape:"javascript"}{literal}'
        ,name: 'prop_color_format'
        ,hiddenName: 'prop_color_format'
        ,id: 'prop_color_format{/literal}{$tv}{literal}'
        ,store: new Ext.data.SimpleStore({
            fields: ['v','d']
            ,data: [['hex','{/literal}{$_lang.colorpicker_format_hex|escape:"javascript"}{literal}'],['rgb','{/literal}{$_lang.colorpicker_format_rgb|escape:"javascript"}{literal}'],['hsl','{/literal}{$_lang.colorpicker_format_hsl|escape:"javascript"}{literal}']]
        })
        ,displayField: 'd'
        ,valueField: 'v'
        ,mode: 'local'
        ,editable: false
        ,forceSelection: true
        ,typeAhead: false
        ,triggerAction: 'all'
        ,value: params['color_format'] || 'hex'
        ,listeners: oc
        ,width: 200
    },{
        xtype: 'combo'
        ,fieldLabel: '{/literal}{$_lang.colorpicker_output|escape:"javascript"}{literal}'
        ,description: '{/literal}{$_lang.colorpicker_output_description|escape:"javascript"}{literal}'
        ,name: 'prop_color_output'
        ,hiddenName: 'prop_color_output'
        ,id: 'prop_color_output{/literal}{$tv}{literal}'
        ,store: new Ext.data.SimpleStore({
            fields: ['v','d']
            ,data: [['css','{/literal}{$_lang.colorpicker_output_css|escape:"javascript"}{literal}'],['json','{/literal}{$_lang.colorpicker_output_json|escape:"javascript"}{literal}']]
        })
        ,displayField: 'd'
        ,valueField: 'v'
        ,mode: 'local'
        ,editable: false
        ,forceSelection: true
        ,typeAhead: false
        ,triggerAction: 'all'
        ,value: params['color_output'] || 'css'
        ,listeners: oc
        ,width: 200
    }]
    ,renderTo: 'modx-tv-wprops-form{/literal}{$tv}{literal}'
});
// ]]>
</script>
{/literal}
