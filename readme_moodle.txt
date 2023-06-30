Description of adding JS-Beautify and CodeMirror libraries into Moodle.

npm install --save @codemirror/basic-setup @codemirror/lang-xml


Description of importing the js-beautify library into Moodle.

* Download the latest version from https://github.com/beautify-web/js-beautify/releases
* Copy lib/beautify*.js into lib/editor/tiny/plugins/html/amd/src/beautify
* Copy LICENSE into lib/editor/atto/plugins/html/yui/src/beautify
* Update lib/editor/atto/plugins/html/thirdpartylibs.xml
* Rebuild the module
