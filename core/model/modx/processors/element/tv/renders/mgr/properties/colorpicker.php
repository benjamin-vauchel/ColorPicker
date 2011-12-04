<?php
/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.properties
 */

function cleanKeyForSmarty($key)
{
	return str_replace('.','_',$key);
} 
$modx->getService('lexicon','lexicon.modLexicon');
$modx->lexicon->load('colorpicker:default');
$_lang = $modx->lexicon->fetch('colorpicker');
$_lang = array_combine(array_map('cleanKeyForSmarty', array_keys($_lang)), array_values($_lang));
$modx->smarty->assign('_lang', $_lang);

$modx->smarty->assign('base_url',$modx->getOption('base_url'));
return $modx->smarty->fetch('element/tv/renders/properties/colorpicker.tpl');