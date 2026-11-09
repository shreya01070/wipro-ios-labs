import Foundation
print("Bank Account Details")
let Account1 = BankAccount(initialBalance:0)
if let myAccount = BankAccount(initialBalance: 500){

  print("Account Created Succesfully")
  print("initialBalance: $\(myAccount.balance)")

  print("\nPerforming transactions")

  myAccount.deposit(amount: -50)
  myAccount.withdraw(amount: 1000)

  myAccount.deposit(amount: 200)
  myAccount.withdraw(amount: 150)

  print("\nFinal Balance: $\(myAccount.balance)")
  print("\nTransaction History:")
  for item in myAccount.transactionHistory{
    print(item)
  }
}
  
