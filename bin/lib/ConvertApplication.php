<?php
/**
 * Application to Convert CSS colors
 *
 * @license MIT
 */

namespace Cli;

/**
 * Class ConvertApplication
 *
 * @package Cli
 */
class ConvertApplication extends AbstractApplication
{
    protected $name = 'convert';

    protected $version = '0.2.0';

    protected $options = [];

    protected $arguments = [];

    /**
     * NativeApplication constructor.
     *
     * @param array $options
     * @param array $arguments
     */
    public function __construct(array $options, array $arguments)
    {
        $this->options = $options;
        $this->arguments = $arguments;
    }

    /**
     * Execute the command for this command class.
     *
     * Check for options tha preempt the main logic.
     *
     * @return void
     */
    public function run()
    {
        if (isset($this->options['h']) || isset($this->options['help'])) {
            $this->displayHelp();
            exit(0);
        }

        if (isset($this->options['v']) || isset($this->options['version'])) {
            echo $this->getNameAndVersion();
            exit(0);
        }

        $this->main();
    }

    /**
     * The main logic
     */
    protected function main()
    {
        $userColor = (isset($this->arguments[0])) ? $this->arguments[0] : '';

        echo $userColor . PHP_EOL;
      
 
        $color = $this->parseColor($userColor);
        print_r($color); 

        if (isset($this->options['decimal'])) {
            $output = $this->toDecimal($color);
        }

        if (isset($this->options['hex'])) {
            $output = $this->toHex($color);
        }

        echo 'OUTPUT=' . $output . PHP_EOL;

    }

    protected function toDecimal($color){
        $output = '';

        foreach (['red', 'green', 'blue'] as $hue) {
            $value = $color[$hue];

            if ( $value ) {
                $answer = hexdec($value);

                if ($output){
                    $output .= ', ';
                }

                $output .= $answer;
            }
        }

        return $output;
    }

    protected function toHex($color){
        $output = '';

        foreach (['red', 'green', 'blue'] as $hue) {
            $value = $color[$hue];

            if ( is_numeric($value) ) {
                $answer = sprintf("%02x", $value);

                $output .= $answer;
            }
        }

        return $output;
    }

    protected function parseColor($value) {
        $rgbDecimalRegex = '/(\d{1,3})\s*\,\s*(\d{1,3})\s*\,\s*(\d{1,3})$/'; 
        $rgbHex3Regex = '/^#?([0-9a-fA-F]{3})$/'; 
        $rgbHex6Regex = '/^#?([0-9a-fA-F]{6})$/'; 

        $color = [
            'red' => 0,
            'green' => 0,
            'blue' => 0
        ];
        
        if (preg_match($rgbDecimalRegex, $value, $matches) === 1){
            $color['red'] = $matches[1];
            $color['green'] = $matches[2];
            $color['blue'] = $matches[3];

            return $color;
        }
       
        if (preg_match($rgbHex3Regex, $value, $matches) === 1){
            $rgb = $matches[1];

            $color['red'] = substr($matches[1], 0, 1);
            $color['green'] = substr($matches[1], 1, 1);
            $color['blue'] = substr($matches[1], 2, 1);

            return $color;
        }
       
        if (preg_match($rgbHex6Regex, $value, $matches) === 1){
            $rgb = $matches[1];

            $color['red'] = substr($matches[1], 0, 2);
            $color['green'] = substr($matches[1], 2, 2);
            $color['blue'] = substr($matches[1], 4, 2);

            return $color;
        }
       
        return false; 
    }

    /**
     * Show how to use this program
     *
     * @return void
     */
    public function displayHelp()
    {
        echo $this->getNameAndVersion();

        echo <<<SHOW_HELP

{$this->name} [options] <keyword>
        
-h | --help Display this help
-v | --version Display the version information of this program

<keyword> is a term to filter the talks listing

SHOW_HELP;
    }

}
