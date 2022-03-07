require "application_system_test_case"

class NominatorsTest < ApplicationSystemTestCase
  setup do
    @nominator = nominators(:one)
  end

  test "visiting the index" do
    visit nominators_url
    assert_selector "h1", text: "nominators"
  end

  test "creating a nominator" do
    visit nominators_url
    click_on "New nominator"

    fill_in "First name", with: @nominator.first_name
    fill_in "Last name", with: @nominator.last_name
    fill_in "Title", with: @nominator.title
    fill_in "University", with: @nominator.university_id
    click_on "Create nominator"

    assert_text "nominator was successfully created"
    click_on "Back"
  end

  test "updating a nominator" do
    visit nominators_url
    click_on "Edit", match: :first

    fill_in "First name", with: @nominator.first_name
    fill_in "Last name", with: @nominator.last_name
    fill_in "Title", with: @nominator.title
    fill_in "University", with: @nominator.university_id
    click_on "Update nominator"

    assert_text "nominator was successfully updated"
    click_on "Back"
  end

  test "destroying a nominator" do
    visit nominators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "nominator was successfully destroyed"
  end
end
