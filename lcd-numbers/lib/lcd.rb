class Lcd
  def display number
    digits = {0 => " - \n| |\n   \n| |\n - \n",
              1 => "   \n  |\n   \n  |\n   \n",
              2 => " - \n  |\n - \n|  \n - \n",
              3 => " - \n  |\n - \n  |\n - \n"}

    number_parts = number.to_s.chars.map(&:to_i)
    
    a = []

    for i in (0...digits[0].split("\n").length)
      b = []
      for n in number_parts do
        b.push(digits[n].split("\n")[i]) 
      end
      a.push b
    end

    s = ""

    for line in a do
       st = ""
       st += line.join(" ")
       s += st + "\n"
    end

    s
  end
end
