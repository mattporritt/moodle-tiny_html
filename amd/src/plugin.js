// This file is part of Moodle - https://moodle.org/
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
// along with Moodle.  If not, see <https://www.gnu.org/licenses/>.

/**
 * Tiny tiny_html for Moodle.
 *
 * @module      tiny_html/plugin
 * @copyright   2023 Matt Porritt <matt.porritt@moodle.com>
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

import {getTinyMCE} from 'editor_tiny/loader';
import {getPluginMetadata} from 'editor_tiny/utils';

import {component, pluginName} from './common';
import {html_beautify} from './beautify/beautify-html';

import {basicSetup, EditorView, html} from './codemirror/codemirror';

const beautifyOptions = {
    indent_size: 2,
    wrap_line_length: 80,
    unformatted: [],
};

const windowManagerConfig = {
    title: 'Source code',
    size: 'large',
    body: {
        type: 'panel',
        items: [
            {
                type: 'htmlpanel',
                html: '<div id="codeMirrorContainer" style="height: 100%;"></div>',
            },
        ],
    },
    buttons: [
        {
            type: 'cancel',
            name: 'cancel',
            text: 'Cancel',
        },
        {
            type: 'submit',
            name: 'save',
            text: 'Save',
            primary: true,
        },
    ],
    initialData: null,
    onSubmit: null,
};

// Setup the tiny_html Plugin.
export default new Promise(async(resolve) => {
    // Note: The PluginManager.add function does not support asynchronous configuration.
    // Perform any asynchronous configuration here, and then call the PluginManager.add function.
    const [
        tinyMCE,
        pluginMetadata,
    ] = await Promise.all([
        getTinyMCE(),
        getPluginMetadata(component, pluginName),
    ]);

    // Reminder: Any asynchronous code must be run before this point.
    tinyMCE.PluginManager.add(pluginName, (editor) => {
        // Return the pluginMetadata object. This is used by TinyMCE to display a help link for your plugin.

        // Overriding the default 'mceCodeEditor' command
        editor.addCommand('mceCodeEditor', () => {
            // Get the current content of the editor
            const content = editor.getContent({source_view: true});

            // Beautify the content using html_beautify
            const beautifiedContent = html_beautify(content, beautifyOptions);

            // Create the CodeMirror instance
            let cmInstance;

            // Create a new window to display the beautified code
            editor.windowManager.open({
                ...windowManagerConfig,
                onAction: () => {
                    const container = document.getElementById('codeMirrorContainer');
                    window.console.log('we are open');
                    window.console.log(container);
                    cmInstance = new EditorView({
                        state: EditorView.create({
                            doc: beautifiedContent,
                            extensions: [basicSetup, html()],
                        }),
                        parent: container,
                    });
                },
                onSubmit: (api) => {
                    const cmContent = cmInstance.state.doc.toString();
                    editor.setContent(cmContent, {source_view: true});
                    api.close();
                },
            });
        });

        return pluginMetadata;
    });

    resolve(pluginName);
});
