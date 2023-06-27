@editor @editor_tiny @tiny_html @javascript
Feature: Edit HTML in TinyMCE
  To write rich text - I need to be able to easily edit the HTML.


  Scenario: Edit HTML in TinyMCE
    Given I log in as "admin"
    When I open my profile in edit mode
    And I set the field "Description" to "This is my draft"
    And I should see "This is my draft"
    And I click on the "View > Source code" menu item for the "Description" TinyMCE editor
    And I should see "Source code"
    And I should see "This is my draft" source code for the "Description" TinyMCE editor




