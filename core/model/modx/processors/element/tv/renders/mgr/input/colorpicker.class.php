<?php
/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
class modTemplateVarInputRenderColorPicker extends modTemplateVarInputRender {
    public function process($value,array $params = array()) {
        $this->tv->set('value',$value);
        $this->setPlaceholder('assets_url',$this->modx->getOption('assets_url',null,'/assets/'));
    }
    public function getTemplate() {
        return 'element/tv/renders/input/colorpicker.tpl';
    }
}
return 'modTemplateVarInputRenderColorPicker';
