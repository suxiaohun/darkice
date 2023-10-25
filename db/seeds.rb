# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "admin@test.com",password: "123456" )

Post.create([
              { title: "ETL对档案级联相关oplog的操作逻辑"},
              { title: "白俄罗斯和巴基斯坦加入国际月球科研站计划"},
              { title: "台媒-業界人士研判華為晶片突破是因荷蘭asml助攻"},
              { title: "Overview of Helpers Provided by Action View"},
              { title: "海淀区今天实况：14度 小雨，湿度：96%，东风：1级。白天：23度,多云"},
              { title: "You’re in good company"},
              { title: "开源RISC-V将改变全球计算架构垄断格局"},
              { title: "Explainer: How UN delivers lifesaving aid amid crises"},
              { title: "巴西市场首笔跨境人民币商业贷款落地"},
              { title: "印尼5个月未降雨 巴厘岛已进入紧急状态"},
              { title: "Working with JavaScript in Rails"}
            ])

