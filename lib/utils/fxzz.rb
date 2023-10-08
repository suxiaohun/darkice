def calculate(a=0.5,b=0.5,c=0.5)
  res = 1
  ARGV.each do |k|
    res = res*(1-k.to_f)*2
  end
  puts res.round(3)
end


calculate

# 主属性[全属性]
# 基础攻击力
# 基础爆伤
# 暴击（默认满）
# 技能伤害
# 投掷伤害（文本错误）
# 头击
# 元素伤害（附魔）
# 双击
#
# 主属性加成[全属性加成]
# 攻击力加成
# 伤害加成
#
# 最终攻击力
# 最终伤害

#