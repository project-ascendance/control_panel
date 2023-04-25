json.extract! create_content_dto, :id, :type, :title, :end_date, :start_date, :image, :body, :sites, :creation_time, :author, :created_at, :updated_at
json.url create_content_dto_url(create_content_dto, format: :json)
