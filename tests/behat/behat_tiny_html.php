<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * TinyMCE HTML plugin custom behat steps definitions.
 *
 * @package    tiny_html
 * @category   test
 * @copyright  2023 Matt Porritt <matt.porritt@moodle.com>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Mink\Element\NodeElement;
use Behat\Mink\Exception\DriverException;
use Behat\Mink\Exception\ExpectationException;

// NOTE: no MOODLE_INTERNAL test here, this file may be required by behat before including /config.php.
require_once(__DIR__ . '/../../../../behat/behat_base.php');

/**
 * TinyMCE HTML plugin custom behat steps definitions.
 *
 * @package    tiny_html
 * @category   test
 * @copyright  2023 Matt Porritt <matt.porritt@moodle.com>
 */
class behat_tiny_html extends behat_base {
    /**
     * Execute some JavaScript for a particular Editor instance.
     *
     * The editor instance is available on the 'instance' variable.
     *
     * @param string $editorid The ID of the editor
     * @param string $code The code to execute
     */
    protected function execute_javascript_for_editor(string $editorid, string $code): void {
        $js = <<<EOF
        require(['editor_tiny/editor'], (editor) => {
            const instance = editor.getInstanceForElementId('{$editorid}');
            {$code}
        });
        EOF;

        $this->execute_script($js);
    }

    /**
     * Select the element type/index for the specified TinyMCE editor.
     *
     * @When /^I should see "(?P<textlocator_string>(?:[^"]|\\")*)" source code for the "(?P<locator_string>(?:[^"]|\\")*)" TinyMCE editor$/
     * @param string $textlocator The type of element to select (for example `p` or `span`)
     * @param string $locator The editor to select within
     */
    public function get_source_code(string $textlocator, string $locator): void {
        $this->require_tiny_tags();

        $editor = $this->get_textarea_for_locator($locator);
        $editorid = $editor->getAttribute('id');

        // Ensure that a name is set on the iframe relating to the editorid.
        $js = <<<EOF
            const element = instance.dom.select("{$textlocator}")[{$position}];
            instance.selection.select(element);
        EOF;

        $this->execute_javascript_for_editor($editorid, $js);
    }

}
