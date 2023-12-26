namespace :pwi do


  def init_mobs
    File.open("lib/utils/pwi/mobs2", "a+") do |io|
      index = -1
      io.each_line do |line|
        index += 1
        next if index == 0
        puts index
        attrs = line.chomp!.split("\t")
        Pwi::Mob.create_or_find_by!(id: attrs[0],
                         name: attrs[1],
                         life: attrs[2])
      end

    end
  end

  desc "init pwi base data"
  task init: :environment do
    init_mobs
  end

end
