class CommonController < ApplicationController

  include XiuxianInfo

  skip_before_action :verify_authenticity_token, only: [:chatgpt]

  def sign_out

  end


  def chatgpt
    if request.post?
      api_key = "xxx"
      client = OpenAI::Client.new(
        access_token: api_key,
        log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production.
      )
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: "Hello!"}], # Required.
          temperature: 0.7,
        })
      puts response.dig("choices", 0, "message", "content")
      # => "Hello! How may I assist you today?"
      puts response
    end
  end

  def test

    @c = %w(1607327664672)
  end

  def index
  end


  def colors

  end

  def encode_upload

  end

  def encode_convert
    file =  params[:file]
    file_name = file.original_filename
    content = file.read
    File.delete(file.tempfile.path) if File.exist?(file.tempfile.path)


    unless content.force_encoding('UTF-8').valid_encoding?
      content.encode!("utf-8", 'GB18030') rescue raise "unsupported encode, check the book"
    end


    send_data content, filename: file_name
  end



  def skills
    @skills = []
    100.times do
      @skills << rand_skill
    end
  end

  def items
    @items = []
    100.times do
      @items << rand_item
    end
  end

  def groups
    @groups = []
    100.times do
      @groups << rand_group
    end
  end


end
