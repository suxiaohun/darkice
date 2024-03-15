class CommonController < ApplicationController
  layout 'home'

  include XiuxianInfo

  def sign_out

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

    raise "unsupported encode, check the book" unless content.force_encoding('UTF-8').valid_encoding?

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
