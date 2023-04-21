require "application_system_test_case"

class CreateContentDtosTest < ApplicationSystemTestCase
  setup do
    @create_content_dto = create_content_dtos(:one)
  end

  test "visiting the index" do
    visit create_content_dtos_url
    assert_selector "h1", text: "Create content dtos"
  end

  test "should create create content dto" do
    visit create_content_dtos_url
    click_on "New create content dto"

    fill_in "Author", with: @create_content_dto.author
    fill_in "Body", with: @create_content_dto.body
    fill_in "Creation tme", with: @create_content_dto.creation_tme
    fill_in "End date", with: @create_content_dto.end_date
    fill_in "Image", with: @create_content_dto.image
    fill_in "Sites", with: @create_content_dto.sites
    fill_in "Start date", with: @create_content_dto.start_date
    fill_in "Title", with: @create_content_dto.title
    fill_in "Type", with: @create_content_dto.type
    click_on "Create Create content dto"

    assert_text "Create content dto was successfully created"
    click_on "Back"
  end

  test "should update Create content dto" do
    visit create_content_dto_url(@create_content_dto)
    click_on "Edit this create content dto", match: :first

    fill_in "Author", with: @create_content_dto.author
    fill_in "Body", with: @create_content_dto.body
    fill_in "Creation tme", with: @create_content_dto.creation_tme
    fill_in "End date", with: @create_content_dto.end_date
    fill_in "Image", with: @create_content_dto.image
    fill_in "Sites", with: @create_content_dto.sites
    fill_in "Start date", with: @create_content_dto.start_date
    fill_in "Title", with: @create_content_dto.title
    fill_in "Type", with: @create_content_dto.type
    click_on "Update Create content dto"

    assert_text "Create content dto was successfully updated"
    click_on "Back"
  end

  test "should destroy Create content dto" do
    visit create_content_dto_url(@create_content_dto)
    click_on "Destroy this create content dto", match: :first

    assert_text "Create content dto was successfully destroyed"
  end
end
