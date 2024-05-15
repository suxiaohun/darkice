json.extract! question, :id, :title, :options, :mode, :answer, :created_at, :updated_at
json.url question_url(question, format: :json)
