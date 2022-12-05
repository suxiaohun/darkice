require 'sinatra'


set :bind, '0.0.0.0'

get '/hex' do

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
    if num < 16 ** 4
      len = 4
    else
      len = 8
    end
  end
  num.to_s(16).rjust(len, "0").scan(/.{1,2}/).reverse.join
end

def level_hex(num)
  hex(num)
end

def class_hex(num)
  hex(num)
end

def strength_hex(num)
  hex(num)
end

def physique_hex(num)
  hex(num)
end

def agility_hex(num)
  hex(num)
end

def intelligence_hex(num)
  hex(num)
end

def durability_hex(num)
  hex(num * 100, 8)
end

def creator_hex(name, type)
  has_name = "03" # 02 or 03 is no name
  len = name.to_s.size * 2
  if len > 0
    has_name = "04" # 04 is name
  end
  len = len.to_s(16).rjust(2, "0")
  name_hex = name.chars.map { |x| hex x.ord }.join
  hex(type) + has_name + len + name_hex
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
  hex(num, 8)
end

def atk_range_hex(num)
  [num].pack("e").bytes.map { |x| x.to_s(16) }.join.rjust(8, "0")
end

def hole_hex(num)
  hex(num, 8) + "00000000" * num
end

# todo 特殊属性添加，第一个8表示有几条；第二个8表示哪个属性；第三个8表示几率；第四个8表示增加的属性/特性具体数值
def spec_hex(num)
  hex(num, 8)
end

puts hex_gen(255, 255, 255, 255, 255, 255, 255, "111", false, "axes", 17, 0, 8888, 9999, 6666, 7777, 4, 40, 40, 2, 0)