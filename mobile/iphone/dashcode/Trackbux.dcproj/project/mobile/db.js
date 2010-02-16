// contains database functions

// User class
function User()
{
	this.username = "";
	this.user_id = "";
	this.default_budget_amount = 0;
	this.currency = "";
	this.locale = "";
	this.recurring_budget_period_increment = 0;
	this.recurring_budget_period_unit = 0;
}

// Budget class
function Budget() 
{
	this.budget_id = 0;
	this.period = null;
	this.amount = 0.0;
}

// Expense class
function Expense()
{
	this.expense_id = 0;
	this.budget_id = 0;
	this.amount = 0.0;
	this.created_at = null;
}

var currDB = null;  
var currUser = null;
var currBudget = null;
var currTotalExpense = 0.0;

// Initialize database. Create tables if necessary.
function db_init()
{
    try {
        if (window.openDatabase) {
            var shortName = "Trackbux";
            var version = "1.0";
            var displayName = "Trackbux App Database";
            var maxSize = 65536; // in bytes
            currDB = openDatabase(shortName,version,displayName,maxSize);
			if (currDB)
			{
				// try to get current user
				currDB.transaction(
					function (transaction) {
						transaction.executeSql("select * from user;",[],
				            getUserHandler,
                            function(tx, error) {
                                // Database doesn't exist. Let's create one.
                                transaction.executeSql('CREATE TABLE user (username text,user_id text,default_budget_amount integer not null default 300,currency text not null default "usdol",locale text not null default "en", recurring_budget_period_increment integer not null default 1,recurring_budget_period_unit integer not null default 2);', [], nullDataHandler, killTransaction);
                                transaction.executeSql('CREATE TABLE budget (budget_id integer primary key autoincrement,period numeric not null,amount real not null);', [], nullDataHandler, killTransaction);
                                transaction.executeSql('CREATE TABLE expense (expense_id integer primary key autoincrement,budget_id integer not null,amount real not null,created_at numeric not null);', [], insertDefaultData, killTransaction);           
                            }
                        )
                    }
                );
			}
        }
        else {
            alert("Local storage not supported");
        }
    } catch(e) {
        handleError(e);
        currDB = null;
    }
}

function db_addExpense(amount)
{
    currDB.transaction(
		function (transaction) {
            transaction.executeSql('insert into expense (budget_id,amount,created_at) values (?,?,DATETIME("NOW"));',[currBudget.budget_id,amount],
            function(transaction,results) {
                getCurrentTotalExpense(currDB,currBudget.budget_id);
            }
            ,killTransaction);
		}
	);
}

function displayBudget()
{
    var amtSpentElem = document.getElementById('amountSpentVal');
    amtSpentElem.innerHTML = currTotalExpense;
    var amtRemainingElem = document.getElementById('amountRemainingVal');
    var amtRemaining = currBudget.amount - currTotalExpense;
    amtRemainingElem.innerHTML = amtRemaining;
    var nextCycleElem = document.getElementById('nextCycleVal');
    nextCycleElem.innerHTML = currBudget.period;
    // TODO
    //var daysUntilElem = document.getElementById('daysUntilVal');
    // reset expense
    var expenseElem = document.getElementById('expenseField');
    expenseElem.value = 0;
}

function createUser(row)
{
	var user = new User();
	user.username = row["username"];
	user.user_id = row["user_id"];
	user.default_budget_amount = row["default_budget_amount"];
	user.currency = row["currency"];
	user.locale = row["locale"];
	user.recurring_budget_period_increment = row["recurring_budget_period_increment"];
	user.recurring_budget_period_unit = row["recurring_budget_period_unit"];
	return user;
}

function createBudget(row)
{
	var budget = new Budget();
	budget.budget_id = row["budget_id"];
	budget.period = row["period"];
	budget.amount = row["amount"];
	return budget;
}

function getUserHandler(transaction,results)
{
    if (results.rows.length==0)
    {
        // no user
        currUser = null;
        alert("No user");
    }
    else
    {
        currUser = createUser(results.rows.item(0));
        getCurrentBudget(currDB);
    }
}

function getCurrentUser(db)
{
	db.transaction(
		function (transaction) {
			transaction.executeSql("select * from user;",[],
                getUserHandler,
				errorHandler);
		}
	);
}

function getCurrentBudget(db)
{
	db.transaction(
		function (transaction) {
			transaction.executeSql("select * from budget order by period desc;",[],
				function(transaction,results) {
					if (results.rows.length==0)
					{
						currBudget = null;
					}
					else
					{
						currBudget = createBudget(results.rows.item(0));
						getCurrentTotalExpense(db,currBudget.budget_id);
					}
				},
				errorHandler);
		}
	);	
}

function getCurrentTotalExpense(db,budget_id)
{
	db.transaction(
		function (transaction) {
			transaction.executeSql("select sum(amount) as 'total_expense' from expense where budget_id=?;",[ budget_id ],
				function(transaction,results) {
					if (results.rows.length==0)
					{
						currTotalExpense = 0.0;
					}
					else
					{
						var row = results.rows.item(0);
						currTotalExpense = row['total_expense'];
                        displayBudget();
					}
				},
				errorHandler);
		}
	);	
}

function insertDefaultData(transaction,results)
{
    transaction.executeSql('insert into user (default_budget_amount,currency,locale,recurring_budget_period_increment, recurring_budget_period_unit) values (500,"usdol","en",1,2);',[],nullDataHandler,killTransaction);
    transaction.executeSql('insert into budget (period,amount) values (DATE("2010-02-28"),300);',[],nullDataHandler,killTransaction);
    transaction.executeSql('insert into expense (budget_id,amount,created_at) values (1,5,DATETIME("NOW"));',[],getCurrentUser(currDB),killTransaction);
}

/*! This is used as a data handler for a request that should return no data. */
function nullDataHandler(transaction, results)
{
    // nothing here, since there is no data
}

/*! When passed as the error handler, this silently causes a transaction to fail. */
function killTransaction(transaction, error)
{
	return true; // fatal transaction error
}

function handleError(error)
{
    // error.message is a human-readable string.
    // error.code is a numeric error code
    // list of error code is available at:
    // http://developer.apple.com/safari/library/documentation/iPhone/Conceptual/SafariJSDatabaseGuide/UsingtheJavascriptDatabase/UsingtheJavascriptDatabase.html#//apple_ref/doc/uid/TP40007256-CH3-SW9
    
    alert('Oops.  Error was ' + error.message + ' (Code ' + error.code + ')');    
}

function errorHandler(transaction, error)
{
    handleError(error);
    
    // Handle errors here
    var we_think_this_error_is_fatal = true;
    if (we_think_this_error_is_fatal) return true;
    return false;
}

