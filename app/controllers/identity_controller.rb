class IdentityController < ApplicationController

  skip_forgery_protection

  def image_verification
    # todo check param
    blob1 = params[:image1].try(:read)
    blob2 = params[:image2].try(:read)

    puts "blob1 size: #{blob1.size}" if blob1.present?
    puts "blob2 size: #{blob2.size}" if blob2.present?

    res = call_grpc(method: GRPC_FACE_VERIFY, img1: blob1, img2: blob2)

    render json: res
  end

  def handhold_idcard_verification

    render json: { code: 1000 }
  end

  def idnumber_verification

  end

  def idnumber_match

  end

end
