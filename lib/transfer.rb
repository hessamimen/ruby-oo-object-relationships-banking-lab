class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && amount < sender.balance && status == "pending"
      @status = "complete"
      sender.balance -= amount
      receiver.balance += amount
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && amount <= receiver.balance && status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end
