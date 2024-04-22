class DashboardCalculator
  def initialize(user)
    @user = user
  end

  def call
    {
      total_balance: total_balance,
      total_you_owe: TotalOwedByUserQuery.new(@user).call,
      total_you_are_owed: TotalOwedToUserQuery.new(@user).call,
      friends_you_owe: DebtsByUserQuery.new(@user).call,
      friends_who_owe_you: CreditsToUserQuery.new(@user).call
    }
  end

  private

  def total_balance
    total_you_are_owed - total_you_owe
  end

  def total_you_owe
    TotalOwedByUserQuery.new(@user).call
  end

  def total_you_are_owed
    TotalOwedToUserQuery.new(@user).call
  end
end