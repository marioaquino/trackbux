var Trackbux = {

	CURRENT_ACCOUNT_PROP: "currentAccount",

	debug: function(mesg) {
		Titanium.API.info(mesg);
	},
	
	setCurrentAccountID: function(account_id) {
		Titanium.App.Properties.setInt(Trackbux.CURRENT_ACCOUNT_PROP, account_id);
	},

	getCurrentAccountID: function() {
		var acct_id = Titanium.App.Properties.getInt(Trackbux.CURRENT_ACCOUNT_PROP, 0);
		return (acct_id > 0 ? acct_id : null);
	}
	
};

