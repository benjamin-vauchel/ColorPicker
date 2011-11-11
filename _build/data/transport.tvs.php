<?php
/**
* Template variable objects for the ColorPickers package
* @author Benjamin Vauchel <contact@omycode.fr>
* 11/11/11
*
* @package colorpickers
* @subpackage build
*/

$templateVariables = array();

$templateVariables[1]= $modx->newObject('modTemplateVar');
$templateVariables[1]->fromArray(array(
    'id' => 1,
    'type' => 'colorpicker',
    'name' => 'colorpicker',
    'caption' => 'ColorPicker',
    'description' => 'Color Picker for MODx Revolution',
    'display' => 'default',
    'elements' => '',  /* input option values */
    'locked' => 0,
    'rank' => 0,
    'display_params' => '',
    'default_text' => '',
    'properties' => array(),
),'',true,true);

return $templateVariables;
