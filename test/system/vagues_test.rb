require "application_system_test_case"

class VaguesTest < ApplicationSystemTestCase
  setup do
    @vague = vagues(:one)
  end

  test "visiting the index" do
    visit vagues_url
    assert_selector "h1", text: "Vagues"
  end

  test "creating a Vague" do
    visit vagues_url
    click_on "New Vague"

    fill_in "Rentree", with: @vague.rentree
    fill_in "Status", with: @vague.status
    click_on "Create Vague"

    assert_text "Vague was successfully created"
    click_on "Back"
  end

  test "updating a Vague" do
    visit vagues_url
    click_on "Edit", match: :first

    fill_in "Rentree", with: @vague.rentree
    fill_in "Status", with: @vague.status
    click_on "Update Vague"

    assert_text "Vague was successfully updated"
    click_on "Back"
  end

  test "destroying a Vague" do
    visit vagues_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vague was successfully destroyed"
  end
end
