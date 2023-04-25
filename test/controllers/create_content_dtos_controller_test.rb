require "test_helper"

class CreateContentDtosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @create_content_dto = create_content_dtos(:one)
  end

  test "should get index" do
    get create_content_dtos_url
    assert_response :success
  end

  test "should get new" do
    get new_create_content_dto_url
    assert_response :success
  end

  test "should create create_content_dto" do
    assert_difference("CreateContentDto.count") do
      post create_content_dtos_url, params: { create_content_dto: { author: @create_content_dto.author, body: @create_content_dto.body, creation_time: @create_content_dto.creation_tme, end_date: @create_content_dto.end_date, image: @create_content_dto.image, sites: @create_content_dto.sites, start_date: @create_content_dto.start_date, title: @create_content_dto.title, type: @create_content_dto.type } }
    end

    assert_redirected_to create_content_dto_url(CreateContentDto.last)
  end

  test "should show create_content_dto" do
    get create_content_dto_url(@create_content_dto)
    assert_response :success
  end

  test "should get edit" do
    get edit_create_content_dto_url(@create_content_dto)
    assert_response :success
  end

  test "should update create_content_dto" do
    patch create_content_dto_url(@create_content_dto), params: { create_content_dto: { author: @create_content_dto.author, body: @create_content_dto.body, creation_time: @create_content_dto.creation_time, end_date: @create_content_dto.end_date, image: @create_content_dto.image, sites: @create_content_dto.sites, start_date: @create_content_dto.start_date, title: @create_content_dto.title, type: @create_content_dto.type } }
    assert_redirected_to create_content_dto_url(@create_content_dto)
  end

  test "should destroy create_content_dto" do
    assert_difference("CreateContentDto.count", -1) do
      delete create_content_dto_url(@create_content_dto)
    end

    assert_redirected_to create_content_dtos_url
  end
end
