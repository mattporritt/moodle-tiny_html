@editor @editor_tiny @tiny_html @javascript
Feature: Edit HTML in TinyMCE
  To write rich text - I need to be able to easily edit the HTML.


  Scenario: Edit HTML in TinyMCE source code view
    Given I log in as "admin"
    When I open my profile in edit mode
    And I set the field "Description" to "<div><p>This is my draft</p></div>"
    And I click on the "View > Source code" menu item for the "Description" TinyMCE editor
    And I should see "Source code"
    Then I should see this multiline source code for the "Description" TinyMCE editor:
      """
      <div>
        <p>This is my draft</p>
      </div>
      """

  Scenario: Use HTML tag completion in TinyMCE source code view
    Given I log in as "admin"
    When I open my profile in edit mode
    And I set the field "Description" to "<p>This is my draft</p>"
    And I click on the "View > Source code" menu item for the "Description" TinyMCE editor
    And I should see "Source code"
    And I should see "<p>This is my draft</p>" source code for the "Description" TinyMCE editor
    And I add "<add" to the source code for the "Description" TinyMCE editor
    And I press enter
    And I should see this multiline source code for the "Description" TinyMCE editor:
      """
      <p>This is my draft</p>
      <address
      """
    And I add ">" to the source code for the "Description" TinyMCE editor
    Then I should see this multiline source code for the "Description" TinyMCE editor:
      """
      <p>This is my draft</p>
      <address></address>
      """
