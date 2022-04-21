coins = 100
points = 0

def slot_stop(slots)
  input = gets.to_i
  if input
    3.times { slots << rand(1..9) }
    puts "---------------"
    puts "|#{slots[0]}|#{slots[3]}|#{slots[6]}|"
    puts "|#{slots[1]}|#{slots[4]}|#{slots[7]}|"
    puts "|#{slots[2]}|#{slots[5]}|#{slots[8]}|"
  end
end

while coins > 0
  spent_coins = 0
  puts "---------------"
  puts "残りコイン数#{coins}"
  puts "ポイント#{points}"
  puts "何コイン入れますか？"
  puts "1(10コイン) 2(30コイン) 3(50コイン) 4(やめとく)"
  input = gets.to_i
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
  puts "エンターを3回押しましょう！"
  coins -= spent_coins
  slots = []
  3.times { slot_stop(slots) }

  get_points = 0
  if slots.values_at(0, 3, 6).uniq.one?
    position = "上"
    num = slots[0]
    get_points += 100
  end
  if slots.values_at(2, 5, 8).uniq.one?
    position = "下"
    num = slots[2]
    get_points += 100
  end
  if slots.values_at(0, 4, 8).uniq.one? || slots.values_at(2, 4, 6).uniq.one?
    position = "斜め"
    num = slots[4]
    get_points += 200
  end
  if slots.values_at(1, 4, 7).uniq.one?
    position = "真ん中"
    num = slots[1]
    get_points += 300
  end

  if get_points > 0
    if spent_coins == 30
      get_points *= 10
    elsif spent_coins == 50
      get_points *= 20
    end
    if num == 7
      get_points *= 70
    end
    get_coins = get_points / 2 + num * spent_coins
    puts "---------------"
    puts "#{position}に#{num}が揃いました！"
    puts "#{get_points}ポイント獲得！"
    puts "#{get_coins}コイン獲得！"
    points += get_points
    coins += get_coins
  end

  if coins <= 0
    puts "手持ちのコインが尽きました"
  end
end
