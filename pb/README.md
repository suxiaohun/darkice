
- `gem install grpc`
- `gem install grpc-tools`
- 在项目根目录下执行：```grpc_tools_ruby_protoc --ruby_out=. --grpc_out=.  face_api.proto```
- 会在pb/下生成对应的pb文件
