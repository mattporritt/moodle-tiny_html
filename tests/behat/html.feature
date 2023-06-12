@editor @editor_tiny @tiny_html @javascript
Feature: Edit HTML in TinyMCE
  To write rich text - I need to be able to easily edit the HTML.


  Scenario: Edit HTML in TinyMCE
    Given I log in as "admin"
    When I open my profile in edit mode
    And I click on the "Link" button for the "Description" TinyMCE editor
    And I set the field "URL" to "https://moodle.org/"
    Then the field "Text to display" matches value "https://moodle.org/"
    And I click on "Create link" "button" in the "Create link" "dialogue"
    And the field "Description" matches value "<p><a href=\"https://moodle.org/\">https://moodle.org/</a></p>"
    And I select the "a" element in position "0" of the "Description" TinyMCE editor
    And I click on the "Link" button for the "Description" TinyMCE editor
    And the field "Text to display" matches value "https://moodle.org/"
    And the field "URL" matches value "https://moodle.org/"
    And I click on "Close" "button" in the "Create link" "dialogue"

