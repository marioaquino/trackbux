// contains database code

var TrackbuxDB = {
	
	db: Titanium.Database.open('trackbux'),
	
	debug: function(mesg) {
		Titanium.API.info(mesg);
	},
	
	createTables: function() {
		TrackbuxDB.db.execute('create table if not exists account (account_id integer primary key autoincrement,name text not null,budget_amount integer not null default 300,currency text not null default "usdol",recurring_budget_period_increment integer not null default 1,recurring_budget_period_unit integer not null default 2)');
		TrackbuxDB.db.execute('create table if not exists budget (budget_id integer primary key autoincrement,account_id integer not null,period numeric not null,amount real not null,foreign key(account_id) references account(account_id))');
		TrackbuxDB.db.execute('create table if not exists expense (expense_id integer primary key autoincrement,budget_id integer not null,amount real not null,created_at numeric not null,foreign key(budget_id) references budget(budget_id))');
	},
	
	insertDefaultData: function() {
		// insert some test data
		TrackbuxDB.db.execute('insert into account(name) values("Monthly Budget")');
		TrackbuxDB.db.execute('insert into budget (account_id,period,amount) values (1,DATE("2010-02-28"),300)');
		TrackbuxDB.db.execute('insert into expense (budget_id,amount,created_at) values (1,5,DATETIME("NOW"))');
	},
	
	getAccounts: function() {
		var rows = TrackbuxDB.db.execute('select * from account');
		var dataArray = [];
		if (rows && rows.rowCount > 0) {
			while (rows.isValidRow()) {
				var rowData = { 
					title: rows.fieldByName('name'),
					name: rows.fieldByName('name'),
					account_id: rows.fieldByName('account_id'),
					hasDetail: true,
					hasChild: true
				};
				TrackbuxDB.debug(rowData);
				dataArray.push(rowData);
	      rows.next();			
			}
		}
		rows.close();
		return dataArray;
	},

  getCurrentBudget: function(account_id) {
		TrackbuxDB.debug("in getCurrentBudget");
		var rows = TrackbuxDB.db.execute('select * from budget where account_id=? order by period desc',account_id);
		var budget = null;
		if (rows && rows.rowCount > 0 && rows.isValidRow()) {
			TrackbuxDB.debug("has rows");
			budget = {
				budget_id: rows.fieldByName('budget_id'),
				account_id: account_id,
				period: rows.fieldByName('period'),
				amount: rows.fieldByName('amount')
			};
		}
		else {
			TrackbuxDB.debug("no rows");
		}
		rows.close();
		return budget;
	},
		
	// getTotalExpense: function(budget_id) {
	// 	TrackbuxDB.debug("in getTotalExpense");
	// 	var rows = TrackbuxDB.db.execute('select sum(amount) as "total_expense" from expense where budget_id=?', budget_id);
	// 	TrackbuxDB.debug("after exec");
	// 	var totalExpense = 0;
	// 	if (rows && rows.rowCount > 0 && rows.isValidRow()) {
	// 		totalExpense = rows.fieldByName('total_expense');
	// 		TrackbuxDB.debug("totalExpense is: " + totalExpense);
	// 	}
	// 	rows.close();
	// 	return totalExpense;
	// },

	getTotalExpense: function(budget_id) {
		TrackbuxDB.debug("in getTotalExpense");
		var rows = TrackbuxDB.db.execute('select amount from expense where budget_id=?', budget_id);
		var totalExpense = 0;
		if (rows && rows.rowCount > 0) {
			while (rows.isValidRow()) {
				var expense = rows.fieldByName('amount');
				totalExpense += expense;
				rows.next();
			}
		}
		TrackbuxDB.debug("totalExpense is: " + totalExpense);
		rows.close();
		return totalExpense;
	},

	getBudgetSummary: function(budget) {
		TrackbuxDB.debug("in getBudgetSummary");
		var totalExpense = TrackbuxDB.getTotalExpense(budget.budget_id);
		return {
			budget_id: budget.budget_id,
			amountSpent: totalExpense,
			amountRemaining: budget.amount - totalExpense,
			nextCycle: budget.period
		};
	},
	
	addExpense: function(budget_id,amount) {
		TrackbuxDB.debug("in addExpense");
		TrackbuxDB.db.execute('insert into expense (budget_id,amount,created_at) values (?,?,DATETIME("NOW"))',budget_id,amount);
		TrackbuxDB.debug("rowsAffected=" + TrackbuxDB.db.rowsAffected);
		return (TrackbuxDB.db.rowsAffected==1);
	},
	
	hasAccounts: function() {
		var rows = TrackbuxDB.db.execute('select * from account');
		TrackbuxDB.debug("rowCount=" + rows.rowCount);
		var numRows = rows.rowCount;
		rows.close();
		return (numRows > 0);
	},
	
	init: function() {
		TrackbuxDB.debug("in init");
		TrackbuxDB.createTables();
		TrackbuxDB.debug("after creating tables");
		if (!TrackbuxDB.hasAccounts()) {
			TrackbuxDB.debug("no accounts yet, insert some default data.");
			TrackbuxDB.insertDefaultData();
			TrackbuxDB.debug("after inserting default data.");
		}
	}
};