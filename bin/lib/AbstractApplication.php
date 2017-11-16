<?php
/**
 * PHP Command Line Applications
 *
 * @license MIT
 */

namespace Cli;

class AbstractApplication
{
    /** @var string name of the program */
    protected $name = 'name';

    /** @var string the version of your program */
    protected $version = '0.1.0-alpha';

    /**
     * Retrieve the program name and version
     *
     * @return string
     */
    public function getNameAndVersion()
    {
        return "{$this->name} {$this->version}\n";
    }

    /**
     *
     */
    public function run()
    {
        echo "Running" . __CLASS__ . "!\n\n";
    }
}
