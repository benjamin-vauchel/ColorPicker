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
    ,items: [
    {
        xtype: 'combo'
        ,fieldLabel: 'Color format'
        ,description: 'The CSS color format'
        ,name: 'prop_color_format'
        ,hiddenName: 'prop_color_format'
        ,id: 'prop_color_format{/literal}{$tv}{literal}'
        ,store: new Ext.data.SimpleStore({
            fields: ['v','d']
            ,data: [['hex','Hexadecimal'],['rgb','RGB'],['hsl','HSL']]
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
        ,fieldLabel: 'Output'
        ,description: 'Output CSS => rgb(255,255,255) or  output JSON => {255,255,255}'
        ,name: 'prop_color_output'
        ,hiddenName: 'prop_color_output'
        ,id: 'prop_color_output{/literal}{$tv}{literal}'
        ,store: new Ext.data.SimpleStore({
            fields: ['v','d']
            ,data: [['css','CSS'],['json','JSON']]
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
