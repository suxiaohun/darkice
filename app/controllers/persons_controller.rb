require_relative '../../pb/pwi_pb'
require_relative '../../pb/pwi_services_pb'
class PersonsController < ApplicationController

  def index

    userid = 1056

    host = "10.4.243.51:29400"
    client = Pb::PwiApi::Stub.new(host, :this_channel_is_insecure, timeout: 0.3)

    grpc_param = Pb::GetUserRolesArg.new(userid: userid)

    binding.pry
    res = client.send("GetUserRoles", grpc_param)
    binding.pry
    render json: res

  end




  def db_new
  end

  def db_info

  end

  def create

  end

  def destroy

  end

  def image_add

  end

  def image_delete

  end

end
