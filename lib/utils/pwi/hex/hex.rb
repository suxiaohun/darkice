get '/index' do

  erb :index
end

get '/convert' do
  @code = params[:code] || "0000000000000000000000003c8601003c8601002c00040447004d0000000000090000001100000000000000e7030000e7030000e7030000e703000004000000000020420000204202000000000000000000000006000000ad690000250600000100000005000000974c0000e50c00001e000000862100000f270000682500000f270000542500000f270000492200000f270000"
  @str = ""
  @code.split(" ").each do |v|
    @str += "\n\n\n"
    temp = v[120..-1].scan(/.{1,8}/)
    temp.each do |t|
      d = Integer("0x" + t.scan(/.{1,2}/).reverse.join)
      @str += " " + d.to_s
    end
  end

  erb :convert
end

get '/hex' do
  lev = params[:level]
  cla = params[:class]
  strength = params[:strength]
  vitality = params[:vitality]
  agility = params[:agility]
  energy = params[:energy]
  durability = params[:durability]
  creator = params[:creator] || "111"
  enable_min_range = params[:enable_min_range] ? true : false
  # enable_min_range = false
  weapon_type = params[:weapon_type]
  grade = params[:grade]
  ammunition = params[:ammunition]
  min_phy_damage = params[:min_phy_damage]
  max_phy_damage = params[:max_phy_damage]
  min_mag_damage = params[:min_mag_damage]
  max_mag_damage = params[:max_mag_damage]
  atk_speed = params[:atk_speed]
  atk_range = params[:atk_range]
  atk_min_range = params[:atk_min_range]
  hole = params[:hole]

  # 特殊属性添加
  spec = spec_check(params)

  # spec = params[:spec] || 0
  type = EQUIPMENT_TYPE_WEAPON

  @code = hex_gen(lev, cla, strength, vitality, agility, energy, durability,
                  creator, enable_min_range, weapon_type, grade, ammunition,
                  min_phy_damage, max_phy_damage, min_mag_damage, max_mag_damage,
                  atk_speed, atk_range, atk_min_range, hole, spec,
                  type)

  # code = "<textarea cols='48' rows='20' style='font-size: 30px;'><%= @code %></textarea><br><br><br><%= @code.scan(/.{1,48}/) %>"
  code = "<textarea cols='48' rows='20' style='font-size: 30px;'><%= @code %></textarea>"
  erb code
end

EQUIPMENT_TYPE_WEAPON = 44 # weapon
EQUIPMENT_TYPE_ARMOR = 36 # armor

WEAPON_TYPES = {
  "axes" => 9
}

def hex_gen(lev, cla, strength, physique, agility, intelligence, durability,
            creator, enable_min_range, weapon_type, grade, ammunition,
            min_phy_damage, max_phy_damage, min_mag_damage, max_mag_damage,
            atk_speed, atk_range, atk_min_range, hole, spec,
            type = EQUIPMENT_TYPE_WEAPON)
  level_hex(lev) +
    class_hex(cla) +
    strength_hex(strength) +
    physique_hex(physique) +
    agility_hex(agility) +
    intelligence_hex(intelligence) +
    durability_hex(durability) +
    durability_hex(durability) +
    creator_hex(creator, type) +
    min_effective_range_hex(enable_min_range) +
    weapon_type_hex(weapon_type) +
    grade_hex(grade) +
    ammunition_hex(ammunition) +
    damage_hex(min_phy_damage) +
    damage_hex(max_phy_damage) +
    damage_hex(min_mag_damage) +
    damage_hex(max_mag_damage) +
    atk_speed_hex(atk_speed) +
    atk_range_hex(atk_range) +
    atk_range_hex(atk_min_range) +
    hole_hex(hole) +
    spec_hex(spec)
end

def hex(num, len = nil)
  unless len
    if num.to_i < 16 ** 4
      len = 4
    else
      len = 8
    end
  end
  num.to_i.to_s(16).rjust(len, "0").scan(/.{1,2}/).reverse.join
end

def level_hex(num = 0)
  hex(num)
end

def class_hex(num = 0)
  hex(num)
end

def strength_hex(num = 0)
  hex(num)
end

def physique_hex(num = 0)
  hex(num)
end

def agility_hex(num = 0)
  hex(num)
end

def intelligence_hex(num = 0)
  hex(num)
end

def durability_hex(num = 999)
  hex(num.to_i * 100, 8)
end

def creator_hex(name, type)
  has_name = "03" # 02 or 03 is no name
  len = name.to_s.size * 2
  if len > 0
    has_name = "04" # 04 is name
  end
  len = len.to_s(16).rjust(2, "0")
  name_hex = name.chars.map { |x| hex x.ord }.join
  res = hex(type) + has_name + len + name_hex
  puts res
  res
end

def min_effective_range_hex(enable)
  num = enable ? 1 : 0
  hex(num, 8)
end

def weapon_type_hex(type)
  hex(WEAPON_TYPES[type], 8)
end

def grade_hex(num)
  hex(num, 8)
end

# todo bow e.g. need
def ammunition_hex(num)
  hex(0, 8)
end

def damage_hex(num)
  hex(num, 8)
end

def atk_speed_hex(num)
  speed = 20.0 / (num.to_i)
  hex(speed, 8)
end

def atk_range_hex(num)
  [num.to_i].pack("e").bytes.map { |x| x.to_s(16) }.join.rjust(8, "0")
end

def hole_hex(num)
  hex(num, 8) + "00000000" * num.to_i
end

SPEC_ATTRS = {
  "s_hp" => [0, "生命值", 9576, 100],
  "s_mp" => [0, "真气值", 9556, 100],
  "s_accuracy" => [0, "准确度", 8582, 9999],
  "s_pd_max" => [0, "物理攻击上限", 9191, 185],
  "s_pd" => [0, "物理攻击", 9595, 100],
  "s_md" => [0, "法术攻击", 9617, 100],
  "s_delay" => [0, "吟唱时间", 11106, 12],
  "s_atk_lev" => [0, "攻击等级", 11422, 80],
  "s_def_lev" => [0, "防御等级", 11423, 80],
  "s_strength" => [0, "力量", 11424, 30],
  "s_energy" => [0, "灵力", 11425, 30],
  "s_agility" => [0, "敏捷", 11426, 30],
  "s_qipo" => [0, "气魄", 11428, 100],
  "s_critical" => [0, "爆击率", 8777, 5], # ? 11107
  "s_atk_interval" => [0, "攻击间隔", 8529, 1], # ? 8613
  # spec addons

  # "kuangzhanshi" => [146, 1, "狂战士"], # 狂战士
  # "silie" => [809, 1, "撕裂"], # 撕裂
  # "shihun" => [810, 1, "蚀魂"], # 蚀魂
  # "jitui" => [811, 1, "击退"], # 击退
  # "ningshen" => [812, 1, "凝神"], # 凝神
  # "suiling" => [813, 1, "碎灵"], # 碎灵

  # "shifangbazhen" => [1170, 1, "十方八阵"], # 十方八阵
  # "suijia" => [1169, 1, "碎甲"], # 碎甲

  # "meiyingjie" => [1, "魅影劫", 27053, 1577,], # 还有个27803,27805
  # 太清咒：受到攻击时有一定几率解除自身异常状态，同时免疫击晕、减速效果，移动速度提高200%%，持续5秒。
  # "taiqingzhou" => [1, "太清咒", 27053, 1573, 1, 5],
  # 第一个值看起来没用；第二个是触发几率（无论近战、远程都能触发）
  "kuangzhanshen" => [1, "狂战神", 18659, 1168, 1],

  # 碎灵池：被祝福过的八阵之力，更大机率使敌人陷入定身及封印状态不能攻击。
  "shifangbazhen" => [1, "十方八阵", 18661, 1170, 1],
  # 碎灵池：被祝福过的碎灵之力，更大机率驱散对方有益状态。
  "suiling" => [1, "碎灵", 16833, 813, 1],
  "suilingchi" => [1, "碎灵池", 18663, 1172, 1],

  # 炽绯魂：攻击有一定几率打出加倍伤害。
  "chifeihun" => [1, "炽绯魂", 19605, 3299, 30],

  # 行僵疫：攻击有一定几率使目标受到的治疗效果降低50%%，效果持续8秒。
  "xingjiangyi" => [1, "行僵疫", 19606, 3300, 30],

  # 重霄劫：攻击有一定几率使自己暴击率提高30%%，暴击伤害提高30%%，效果持续10秒。
  "chongxiaojie" => [1, "重霄劫", 19607, 3301, 30],

  # 蚀心斩：攻击有一定几率使目标物理防御与法术防御降低100%%，效果持续8秒。
  "shixinzhan" => [1, "蚀心斩", 19608, 3302, 30],

  #逍遥意：攻击有一定几率使自身吟唱时间缩短30%%，效果持续8秒。
  "xiaoyaoyi" => [1, "逍遥意", 19609, 3303, 30],

  # 第一个是内置cd；第二个是触发几率；内置cd从触发时开始算
  # 太清咒无CD，可以改变几率
  # 其他有内置CD
  # 磐龙甲：受到攻击时有一定几率使自身在接下来的5秒内闪避所有负面状态。
  # "panlongjia" => [1, "磐龙甲", 27804, 3304, 30, 20],

  # ---------
  # 描述有问题，这三个应该是残缺的
  "tiangangzhen" => [1, "天罡阵", 27803, 1574, 3, 100],
  # 法术防御不会消失，bug？
  "tianxiangwu" => [1, "天香舞", 27803, 1576, 3, 100],
  # 似乎是太清咒的缩简版，没啥用，第一个确实是内置cd
  "meiyingjie" => [1, "魅影劫", 27803, 1577, 3, 100],
  # ----------

  # 可以改几率
  "taiqingzhou" => [1, "太清咒", 27803, 1573, 10, 100],
  # 可以改触发几率
  "panlongjia" => [1, "磐龙甲", 27804, 3304, 3, 100],
  # 可以改触发几率
  "fengcanying" => [1, "风残影", 27805, 3305, 3, 100],
  # 可以改触发几率，但依然会受到普通攻击（如果没切换目标的话），技能会丢失目标
  "posuoti" => [1, "婆娑体", 27053, 3306, 3, 100],
  # 可以改触发几率，但只有debuff消失后才会重新触发
  "cibeihu" => [1, "慈悲护", 27053, 3307, 3, 100],
}

def spec_check(options)
  res = []
  SPEC_ATTRS.each do |k, v|
    if options[k]
      if v[0] == 0
        v[3] = options[k + "_val"]
      end
      res << v
    end
  end
  res
end

# todo 附加词条，恒定第一个8（表示有几条附加属性）
# 附加此条分两种
# 1.固定数值（两个8）：第一个8表示属性ID；第二个8表示添加的数值
# 2.特殊效果（至少两个8）：
#   - 第一个8应该是title，目前看起来改了也没用；
#     - 有问题，不是随便写的，27806对应攻击等级：11422
#     - 29807对应防御等级：11423
#   - 第二个8表示属性ID；根据属性不同，有额外的8
#   - 确实有个8是改变触发几率的，至于数值与几率的对应关系还需要验证
def spec_hex(attrs)
  # puts attrs
  static_attr = ""
  spec_attr = ""
  count = 0
  attrs.each do |v|
    count += 1
    if v[0] == 0
      static_attr += hex(v[2], 8) + hex(v[3], 8)
    else
      # "taiqingzhou" => [1, "太清咒", 27053, 1574, 1, 5],
      v.each_with_index do |vv, i|
        next if i < 2
        spec_attr += hex(vv, 8)
      end
    end
  end
  puts count
  hex(count, 8) + spec_attr + static_attr
end

