var tabGroup = Titanium.UI.createTabGroup();

var add = function(winTitle, url, tabIcon, tabTitle) {
	var win1 = Titanium.UI.createWindow({  
	    title:winTitle,
		barColor:'#000'
	});

	var webview = Ti.UI.createWebView({
		url:url
	});

	win1.add(webview);

	var tab1 = Titanium.UI.createTab({  
	    icon:tabIcon,
	    title:tabTitle,
	    window:win1
	});

	tabGroup.addTab(tab1);  
};

add('Trackbux', 'index.html', 'accountsicon.png', 'Current');
add('Account', 'accounts.html', 'accountsicon.png', 'Account');

tabGroup.open({
	transition:Titanium.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT
});
