<?php
/**
 * @var modX $modx
 * @var array $params
 * @var string $value
 *
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.output
 */
class modTemplateVarOutputRenderColorPicker extends modTemplateVarOutputRender {
    public function process($value,array $params = array()) {
        
        $output = '';
		$hex = $this->tv->parseInput($value);
		
		// We check the hexadecimal value
		if (strpos($hex, '#') === 0) {
		    $hex = substr($hex, 1);
		}
		
		if (strlen($hex) == 3) {
		    $hex = $hex[0].$hex[0].$hex[1].$hex[1].$hex[2].$hex[2];
		}
		
		if (strlen($hex) == 6) 
		{
			// Convert each tuple to decimal.
			$r = hexdec(substr($hex, 0, 2));
			$g = hexdec(substr($hex, 2, 2));
			$b = hexdec(substr($hex, 4, 2));
			
			switch($params['color_format'])
			{
				case 'hex':
					if($params['color_output'] == 'json')
			        {
					    $output = json_encode(array(substr($hex, 0, 2), substr($hex, 2, 2), substr($hex, 4, 2)));
					}
					else
					{
					    $output = '#'.$hex;
					}
				break;
				case 'rgb':
			        if($params['color_output'] == 'json')
			        {
					    $output = json_encode(array($r, $g, $b));
					}
					else
					{
					    $output = 'rgb('.$r.','.$g.','.$b.')';
					}
				break;
				case 'hsl':
					// Where RGB values = 0 Ã· 255.
		        	$var_R = $r / 255;
		        	$var_G = $g / 255;
		        	$var_B = $b / 255;
					
		        	// Min. value of RGB
		        	$var_Min = min($var_R, $var_G, $var_B);
		        	// Max. value of RGB
		        	$var_Max = max($var_R, $var_G, $var_B);
		        	// Delta RGB value
		        	$del_Max = $var_Max - $var_Min;
					
		        	$L = ($var_Max + $var_Min) / 2;
					
		        	if ( $del_Max == 0 ) {
		        	    // This is a gray, no chroma...
		        	    // HSL results = 0 Ã· 1
		        	    $H = 0;
		        	    $S = 0;
		        	} else {
		        	    // Chromatic data...
		        	    if ($L < 0.5) {
		        	        $S = $del_Max / ($var_Max + $var_Min);
		        	    } else {
		        	        $S = $del_Max / ( 2 - $var_Max - $var_Min );
		        	    }
					
		        	    $del_R = ((($var_Max - $var_R) / 6) + ($del_Max / 2)) / $del_Max;
		        	    $del_G = ((($var_Max - $var_G) / 6) + ($del_Max / 2)) / $del_Max;
		        	    $del_B = ((($var_Max - $var_B) / 6) + ($del_Max / 2)) / $del_Max;
					
		        	    if ($var_R == $var_Max) {
		        	        $H = $del_B - $del_G;
		        	    } else if ($var_G == $var_Max) {
		        	        $H = ( 1 / 3 ) + $del_R - $del_B;
		        	    } else if ($var_B == $var_Max) {
		        	        $H = ( 2 / 3 ) + $del_G - $del_R;
		        	    }
					
		        	    if ($H < 0) {
		        	        $H += 1;
		        	    }
		        	    if ($H > 1) {
		        	        $H -= 1;
		        	    }
		        	}
			        
			        if($params['color_output'] == 'json')
			        {
					    $output = json_encode(array($H, $S, $L));
					}
					else
					{
					    $output = 'hsl('.$H.','.$S.','.$L.')';
					}
				break;
				
			}
		}
		
		 
		if(empty($output) && $params['color_output'] == 'json')
		{
			$output = '{}';
		}
		
		return $output;
    }
}
return 'modTemplateVarOutputRenderColorPicker';