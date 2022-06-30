require_relative '../../pb/face_api_pb'
require_relative '../../pb/face_api_services_pb'
class ApplicationController < ActionController::Base

  private

  def call_grpc(method:, img: nil, img1: nil, img2: nil, feat1: nil, feat2: nil)
    # host = "127.0.0.1:50050"
    host = "10.4.243.51:50050"
    client = Pb::FaceApi::Stub.new(host, :this_channel_is_insecure, timeout: 0.3)

    case method
    when GRPC_FACE_EXTRACT
      grpc_lambda = lambda { |arg| client.send(GRPC_FACE_EXTRACT, arg) }
      grpc_param = Pb::FaceExtractRequest.new(img: img)
    when GRPC_FEAT_VERIFY
      grpc_lambda = lambda { |arg| client.send(GRPC_FEAT_VERIFY, arg) }
      grpc_param = Pb::FeatVerifyRequest.new(feat1: feat1, feat2: feat2)
    when GRPC_FACE_VERIFY
      grpc_lambda = lambda { |arg| client.send(GRPC_FACE_VERIFY, arg) }
      grpc_param = Pb::FaceVerifyRequest.new(img1: img1, img2: img2)
    else
      raise "unsupported method"
    end

    begin
      res = grpc_lambda.call(grpc_param)
    rescue => e
      raise e
    end

    case res.code
    when 1000
      res
    else
      raise "unknown code"
    end
  end
end
