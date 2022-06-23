class IdentityController < ApplicationController

  def image_verification

    render json: {code: 1000}
  end

  def handhold_idcard_verification

    render json: {code: 1000}
  end


  def idnumber_verification

  end

  def idnumber_match

  end






end
