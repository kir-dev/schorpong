require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "creating a Event" do
    visit events_url
    click_on "New Event"

    fill_in "Application Deadline", with: @event.application_deadline
    fill_in "Content", with: @event.content
    fill_in "Event Date", with: @event.event_date
    fill_in "Image", with: @event.image
    fill_in "Intro", with: @event.intro
    fill_in "Name", with: @event.name
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "updating a Event" do
    visit events_url
    click_on "Edit", match: :first

    fill_in "Application Deadline", with: @event.application_deadline
    fill_in "Content", with: @event.content
    fill_in "Event Date", with: @event.event_date
    fill_in "Image", with: @event.image
    fill_in "Intro", with: @event.intro
    fill_in "Name", with: @event.name
    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "destroying a Event" do
    visit events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event was successfully destroyed"
  end
end