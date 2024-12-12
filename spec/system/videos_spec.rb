require "rails_helper"
# require_relative "./../support/shared_examples/contents_spec.rb"

describe "Video management" do
  # it_should_behave_like "contents", "admin/videos"

  let!(:video) { create(:viedo, title: "RubyOnRuby", description: "Initial Description") }

  scenario "User allows creating an video" do
    visit_admin_page
    click_link_new_video
    fill_in_video_details
    click_button_create
    user_should_see_an_video
  end

  scenario "User sees a list of videos" do
    visit_admin_page
    user_should_see_a_list_of_videos
  end

  scenario "User allows editing an video" do
    visit_admin_page
    user_selects_an_video
    user_selects_an_video_to_edit
    fill_in_video_details
    user_saves_that_video
    user_edited_the_video
  end

  scenario "User allows deleting an video" do
    visit_admin_page
    user_selects_an_video
    user_destroy_the_video
    user_should_see_the_video_is_deleted
  end

  def visit_admin_page
    visit admin_videos_path
  end

  def user_selects_an_video
    # Use the created video's path
    visit admin_video_path(video)
  end

  def click_link_new_video
    # click_on('btn_new_videos')
    # click_on('New video')
    # find('new-video-btn').click
    visit new_admin_video_path
  end

  def user_destroy_the_video
    click_on('Destroy this video')
  end

  def user_selects_an_video_to_edit
    click_on('Edit this video')
  end

  def fill_in_video_details
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixture/file/test_image.png')
  end

  def click_button_create
    click_on("Create video")
  end

  def user_should_see_an_video
    expect(page).to have_content("RubyOnRuby1")
  end

  def user_should_see_a_list_of_videos
    expect(page).to have_content("videos")
    expect(page).to have_content(video.title)
    expect(page).to have_content(video.description)
    expect(page).to have_css("img[src*='test_image.png']")
  end

  def user_saves_that_video
    click_on("Update video")
  end

  def user_edited_the_video
    expect(page).to have_content("RubyOnRuby1")
  end

  def user_should_see_the_video_is_deleted
    # expect(page).not_to have_content(video.title)
    expect(page).to have_text("video was successfully destroyed.")
  end
end
