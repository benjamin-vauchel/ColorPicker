<?php
/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
$this->xpdo->lexicon->load('tv_widget');

$this->set('value',$value);

$this->xpdo->smarty->assign('assets_url',$modx->getOption('assets_url',null,'/assets/'));
return $this->xpdo->smarty->fetch('element/tv/renders/input/colorpicker.tpl');