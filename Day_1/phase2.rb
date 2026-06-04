class BankAccount
  attr_reader :balance, :owner

  def initialize(owner, initial_balance)
    @owner   = owner
    @balance = initial_balance
    @rate    = 0.05
  end

  # BUG 1 => logic: deposit subtracts money instead of adding it
  # FIX: @balance -= amount  will be @balance += amount
  def deposit(amount)
    if amount > 0
      @balance += amount
      puts "  New balance: ${"%.2f" % @balance}"
    else
      puts "  Error: Deposit amount must be positive."
    end
  end

  # BUG 2 logic: no amount check — allows negative balance
  # FIX: add a condition that returns  if amount > @balance

  # BUG 3 syntax: missing `end` to close withdraw 
  # FIX: add `end` 

  def withdraw(amount)
    if amount > @balance
      puts "  Error: Not enough money."
      return
    end
    @balance -= amount
    puts "  New balance: ${"%.2f" % @balance}"
  end

  # BUG 4 logic: multiplying by @rate (0.05) replaces balance with 5% of itself
  # FIX: @balance * @rate  will be @balance * (1 + @rate)
  def apply_interest
    @balance = @balance * (1 + @rate)
    puts "  New balance: ${"%.2f" % @balance}"
  end

  # BUG 5 syntax: #( instead of #{ in string interpolation — prints literal text
  # FIX: "$#(@balance}"  will be  "$#{@balance}"
  def display_info
    puts "Owner  : #{@owner}"
    puts "Balance: $#{@balance}"
  end
end