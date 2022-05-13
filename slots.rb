coins = 100
points = 0

def stop_slots(slots)
  input = gets.to_i
  if input
    3.times { slots << rand(1..9) }
    puts "---------------"
    3.times.with_index do |i|
      puts "|#{slots[0 + i]}|#{slots[3 + i]}|#{slots[6 + i]}|"
    end
  end
end

def get_position(slots)
  positions = []
  positions << "上" if slots.values_at(0, 3, 6).uniq.one?
  positions << "下" if slots.values_at(2, 5, 8).uniq.one?
  positions << "中央" if slots.values_at(1, 4, 7).uniq.one?
  if slots.values_at(0, 2, 4, 6, 8).uniq.one?
    positions << "X字型"
  elsif slots.values_at(0, 4, 8).uniq.one? || slots.values_at(2, 4, 6).uniq.one?
    positions << "斜め"
  end
end

while coins > 0
  puts "---------------"
  puts "残りコイン数#{coins}"
  puts "ポイント#{points}"
  puts "何コイン入れますか？"
  puts "1(10コイン) 2(30コイン) 3(50コイン) 4(やめとく)"
  input = gets.to_i
  spent_coins = 0
  case input
  when 1
    spent_coins = 10
  when 2
    spent_coins = 30
  when 3
    spent_coins = 50
  when 4
    puts "またね！"
    break
  else
    next
  end
  puts "---------------"
  if coins - spent_coins < 0
    puts "入れられるのは残りコイン数までです"
    next
  end
  coins -= spent_coins
  slots = []
  puts "エンターを3回押しましょう！"
  3.times { stop_slots(slots) }

  unless get_position(slots).nil?
    positions = []
    nums = []
    get_points = 0
    positions.push(get_position(slots)).flatten!
    nums << slots[0] && get_points += 100 if positions.include?("上")
    nums << slots[2] && get_points += 100 if positions.include?("下")
    nums << slots[4] && get_points += 300 if positions.include?("中央")
    nums << slots[4] && get_points += 400 if positions.include?("X字型")
    nums << slots[4] && get_points += 200 if positions.include?("斜め")
    get_points *= 10 if spent_coins == 30
    get_points *= 20 if spent_coins == 50
    get_points *= 70 if nums.include?(7)
    get_coins = get_points / 2 + nums.max * spent_coins
    puts "---------------"
    positions.zip(nums) { |p, n| puts "#{p}に#{n}が揃いました！" }
    puts "#{get_points}ポイント獲得！"
    puts "#{get_coins}コイン獲得！"
    points += get_points
    coins += get_coins
  end

  puts "手持ちのコインが尽きました" if coins == 0
end
