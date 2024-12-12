require "rails_helper"

RSpec.shared_examples "contents" do |content_listing_page, new_content_button, create_button,show_content, edit_content|
  # scenario "user view content" do
  #   expect(something).to eq("parameter1")
  # end

  scenario "user create a new content" do
    visit content_listing_page
    click_on new_content_button
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
    click_on create_button
  end

  scenario "user can submit the content for review"  do
    visit content_listing_page
    click_on new_content_button
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
    click_on create_button
    click_on show_content
    click_on edit_content
    click_on "Save for Review"
  end
  scenario "user can approve the content" do
    visit content_listing_page
    click_on new_content_button
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
    click_on create_button
    click_on show_content
    click_on edit_content
    click_on "Save for Review"
    click_on show_content
    click_on edit_content
    click_on "Approve"
  end
  scenario "user can reject the content" do
    visit content_listing_page
    click_on new_content_button
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
    click_on create_button
    click_on show_content
    click_on edit_content
    click_on "Save for Review"
    click_on show_content
    click_on edit_content
    click_on "Reject"
  end
  scenario "user can't fill f-word" do
    visit content_listing_page
    click_on new_content_button
    fill_in("Title", :with => "RubyOn fxxx")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
    click_on create_button
    puts page.html
    expect(page).to have_text("Rubyon fxxx contains restricted language and cannot be saved")
  end


  # scenario "user edit a content" do
  # end

  # scenario "user delete a content" do
  # end

  # scenario "user view a content" do
  # end

  # scenario "user can submit the content for review" do
  #   user_enters_content_page
  #   user_creates_a_new_content
  #   user_should_see_draft_content
  #   user_submits_content_for_review
  #   user_should_see_content_submitted_for_review
  # end
  # scenario "user can approve the content" do
  #   user_enters_content_page
  #   user_creates_a_new_content
  #   user_should_see_draft_content
  #   user_submits_content_for_review
  #   user_should_see_content_submitted_for_review
  #   user_approves_content
  #   user_should_see_content_published
  # end
  # scenario "user can reject the content" do
  #   user_enters_content_page
  #   user_creates_a_new_content
  #   user_should_see_draft_content
  #   user_submits_content_for_review
  #   user_should_see_content_submitted_for_review
  #   user_rejects_content
  #   user_should_see_content_draft
  # end
  #
end
