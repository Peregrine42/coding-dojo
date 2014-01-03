require_relative "../lib/lcd"

describe Lcd do
  it "can display 0" do
    result = Lcd.new.display 0
    expect(result).to eq <<-EOF
 - 
| |
   
| |
 - 
   EOF
  end

  it "can display 1" do
    result = Lcd.new.display 1
    expect(result).to eq <<-EOF
   
  |
   
  |
   
   EOF
  end

  it "can display 2" do
    result = Lcd.new.display 2
    expect(result).to eq <<-EOF
 - 
  |
 - 
|  
 - 
EOF
  end
  
  it "can display 12" do
    result = Lcd.new.display 12
    expect(result).to eq <<-EOF
     - 
  |   |
     - 
  | |  
     - 
    EOF
  end

  it "can display 123" do
    result = Lcd.new.display 123
    expect(result). to eq <<-EOF
     -   - 
  |   |   |
     -   - 
  | |     |
     -   - 
    EOF
  end
end
