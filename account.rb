require "yaml"

class BankAccount

  attr_accessor :first_name, :last_name, :address, :your_account

  def initialize
    @your_account = []
    open()
  end

  def list
    show_result(@your_account)
  end

  def show
    puts "Enter Email:"
    @email = gets.chomp
    found_user = @your_account.select {|account| account['email'] == @email }
    puts "User detail with email #{@email}"
    puts "Name: #{found_user['first_name']} #{found_user['last_name']}"
    puts "Address: #{found_user['address']}"
  end

  def delete
    puts "Enter Emai:"
    @email = gets.chomp
    found_user = @your_account.select {|account| account['email'] == @email }
    @your_account = @your_account - [found_user]
    save()
  end


  def search
    puts "Enter search string:"
    @s_string = gets.chomp
    found_users = @your_account.select {|acc| acc['email'].to_s.include?(@s_string) || acc['first_name'].to_s.include?(@s_string) || acc['last_name'].to_s.include?(@s_string) || acc['address'].to_s.include?(@s_string) }
    show_result(found_users)
  end

  def new_account(first_name, last_name, address)
    puts "Enter Email:"
    @email = gets.chomp
    puts "Enter your first name:"
    @first_name = gets.chomp
    puts "Enter your last name"
    @last_name = gets.chomp
    puts "Enter your address:"
    @address = gets.chomp

    @your_account << {'email' => @email, 'first_name' => @first_name, 'last_name' => @last_name, 'address' => @address}
    save()
  end

  def run
    loop do
      puts "Please choose your action"
      puts "1. Create New user"
      puts "2. List all Users"
      puts "3. Show user detail"
      puts "4. Search user"
      puts "5. Exit"
      puts "Enter your choice:"
      input = gets.chomp
      case input
      when '1'
        new_account(first_name, last_name, address)
      when '2'
        list
      when '3'
        show
      when '4'
        search
      when '5'
        break
      end
    end
  end

  private
  def save
    File.open("accountinfo.yml", "w+") do |file|
      file.write(@your_account.to_yaml)
    end
  end

  def open
    if File.exist?("accountinfo.yml")
      @your_account = YAML.load_file("accountinfo.yml")
    end
  end

  def show_result(users)
    puts "---------------------------------------------------------------------"
    puts "Full Name     |    Email        |        Address"
    users.each do |user|
      puts "#{user['first_name']} #{user['last_name']}    |   #{user['email']}   |   #{user['address']}"
    end
    puts "---------------------------------------------------------------------"
  end

end

bank_account = BankAccount.new
bank_account.run
