import Foundation

var accountId = 1
class Account {
    var id: Int
    var customerId: Int
    var accountBalanceInKobo: Int = 0
    var interestRate: Double = 0.0
    
    //Initializers
    //Initializers are called to create a new instance of a particular type.
    init(customerId: Int) {
        self.customerId = customerId
        self.id = accountId
        accountId = accountId + 1
    }
    
    func deposit(amount: Int) -> Int {
        //ABSTRACTION
        //we are exposing deposit() method to the user to perform the calculations, but hiding the internal calculations.
        let convertAmountToKobo = amount * 100
        self.accountBalanceInKobo = self.accountBalanceInKobo + convertAmountToKobo
        return self.accountBalanceInKobo
    }
    
    func withdrawal(amount: Int) -> Int {
        //ABSTRACTION
        //we are exposing withdrawal() method to the user to perform the calculations, but hiding the internal calculations.
        let convertAmountToKobo = amount * 100
        if convertAmountToKobo <= 0 {
            print("\(self.customerId) Cannot withdraw Less than o kobo")
        } else if convertAmountToKobo > self.accountBalanceInKobo  {
            print("Insufficient Fund")
        }
        
        if self.accountBalanceInKobo < convertAmountToKobo  {
            return self.accountBalanceInKobo
        }
        self.accountBalanceInKobo = self.accountBalanceInKobo - convertAmountToKobo
        
        return self.accountBalanceInKobo
    }

    func charge() -> Int {
        //ABSTRACTION
        //we are exposing charge() method to the user to perform the calculations, but hiding the internal calculations.
        let chargeAmount = 100 * 100
        let updatedBalance = self.accountBalanceInKobo - chargeAmount
        return updatedBalance
    }
    
    func bonus() -> Int {
        //ABSTRACTION
        //we are exposing bonus() method to the user to perform the calculations, but hiding the internal calculations.
        let bonusAdded = 10 * 100
        self.accountBalanceInKobo += bonusAdded
        return self.accountBalanceInKobo
    }
}


//Savings Account
//INHERITANCE
//SavingsAccount Inherit the roperties of the Parent Class Account, Technically SavingsAccount Here is the Child Class
class savingsAccount: Account {
    //ENCAPSULATION
    //Encapsulation is a concept by which we hide data and methods from outside intervention and usage.
    //We hide the data of variable “_interestRate” from any outside intervention and usage.
    private var _interestRate: Double = 0.1
    
    //METHOD OVERRIDING:
    //Here we are overriding the interestRate Property
    override var interestRate: Double {
        get {return _interestRate}
        set {_interestRate = newValue}
    }
    override func deposit(amount: Int) -> Int {
        super.deposit(amount: amount)
        self.bonus()
        return self.accountBalanceInKobo
    }
}

//Current Account
//INHERITANCE
//CurrentAccount Inherit the roperties of the Parent Class Account, Technically CurrentAccount Here is the Child Class
class currentAccount: Account {
    //ENCAPSULATION
    //Encapsulation is a concept by which we hide data and methods from outside intervention and usage.
    //We hide the data of variable “_interestRate” from any outside intervention and usage.
    private var _interestRate: Double = 0.05
    
    //METHOD OVERRIDING:
    //Here we are overriding the interestRate Property
    override var interestRate: Double {
        get {return _interestRate}
        set {_interestRate = newValue}
    }
    
    override func withdrawal(amount: Int) -> Int {
        return charge() - amount
    }
}

/*
 var testCurrent = currentAccount(id: 1, customerId: 1, accountBalanceInKobo: 5000, interestRate: 0.4)
 print(testCurrent.withdrawal(amount: 400))

*/

var seedId  = 1
class Customer {
    var _id: Int
    var _name: String
    var _address: String
    var _phoneNumber: String
    var account: [Account]? = []
    
    public var id: Int {
        get {
            return _id
        }
        set{
            newValue
        }
    }
    
    public var name: String {
        get {
            return _name
        }
        set{
            newValue
        }
    }
    
    public var phoneNumber: String {
        get {
            return _phoneNumber
        }
        set{
            newValue
        }
    }
    
    public var address: String {
        get {
            return _address
        }
        set{
            newValue
        }
    }
    
    init(name: String, address: String, phoneNumber: String) {
        self._id = seedId
        self._name = name
        self._address = address
        self._phoneNumber = phoneNumber
        seedId = seedId + 1
    }
    
    func deposit(account: Account, amount: Int) -> Int {
        //ABSTRACTION
        //we are exposing deposit() method to the user to perform the calculations, but hiding the internal calculations.
        let newBalance = account.deposit(amount: amount)
        return newBalance
    }
    
    func accountBalance(account: Account) -> Int {
       // print(account.accountBalanceInKobo)
        return account.accountBalanceInKobo
    }
    
    func withdrawal(account: Account, amount: Int) -> Int {
        //ABSTRACTION
        //we are exposing withdrawal() method to the user to perform the calculations, but hiding the internal calculations.
        let newBalance = account.withdrawal(amount: amount)
        return newBalance
    }
    
    
    
   
    
    func openAccount(account: accountType) -> [Account]? {
        if account == accountType.savings {
            let freshSavingAccount = savingsAccount(customerId: self.id)
            print("\(self.name) Opened a Savings account \(self.id)")
            self.account?.append(freshSavingAccount)
        }
        if account == accountType.current {
            let freshCurrentAccount = currentAccount(customerId: self.id)
            print("\(self.name) Opened a Current account \(self.id)")
            self.account?.append(freshCurrentAccount)
        }
        return self.account
    }
    
    func closeAccount(accountPassed: Account) -> [Account]? {
        var i = 0
        while i < account?.count ?? <#default value#> {
            if account?[i].id == accountPassed.id {
                account?.remove(at: i)
            }
            i = i + 1
        }
        return self.account
    }
}

enum accountType {
    case savings, current
}

var tim = Customer(name: "Fred", address: "Ogun", phoneNumber: "08087365425")
var tunji = Customer(name: "Tunji", address: "Ibadan", phoneNumber: "09002393728")
var kunle = Customer(name: "Kunle", address: "Lagos", phoneNumber: "08023645367")

tim.openAccount(account: accountType.savings)
tim.openAccount(account: accountType.current)
tunji.openAccount(account: accountType.savings)
kunle.openAccount(account: accountType.current)
kunle.openAccount(account: accountType.savings)

var timAccount = tim.account?[0]
var timAccount2 = tim.account?[1]
var tunjiAccount = tunji.account?[0]
var kunleAccount = kunle.account?[0]
var kunleSecondAccount = kunle.account?[1]



tim.account?[0].id
tim.account?[1].id
tunji.account?[0].id
kunle.account?[0].id
kunle.account?[1].id

tim.deposit(account: timAccount ?? <#default value#>, amount: 50)
tim.withdrawal(account: timAccount ?? <#default value#>, amount: 40)
tim.deposit(account: timAccount ?? <#default value#>, amount: 50)
tim.accountBalance(account: timAccount ?? <#default value#>)

tunji.deposit(account: tunjiAccount ?? <#default value#>, amount: 60)
tunji.withdrawal(account: tunjiAccount ?? <#default value#>, amount: 10)
tunji.accountBalance(account: tunjiAccount ?? <#default value#>)

let remove = kunle.closeAccount(accountPassed: tim.account?[0] ?? <#default value#>)




//tim.closeAccount(accountPassed: tim.account[0]!)
//tim.accountTotal()

//tim.deposit(account: account1[0]!, amount: 500)
//tim.withdrawal(account: account1[0]!, amount: 200)
