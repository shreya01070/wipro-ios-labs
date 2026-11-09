import Foundation
class BankAccount{
  private var balanceAmount; Double
  private var history: [String] = []
  var balance: Double{
    return balanceAmount
  }

  var transactionHistory: [String]{
    return history
  }

  init?(initialBalance: Double){
    if initialBalance <= 0{
      print("please enter a valid starting balance")
      return nil
    }

    balanceAmount = initialBalance
    history.append("Account opened with $\(initialBalance)")
  }
  func deposit(amount: Double){
    if amount <= 0{
      print("Invalid deposit amount")
      return
    }
    balanceAmount += amount
    history.append("Deposited $\(amount)")
    print("Amount deposited succesfully")
  }
  func withdraw(amount: Double){
    if amount > balanceAmount{
      print("insufficient balance")
      return
    }
    balanceAmount -= amount
    history.append("withdraw $\(amount)")

    print("Amount withdrwa successfully")
  }
}
 
  
