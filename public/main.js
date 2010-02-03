/* 
 This file was generated by Dashcode.  
 You may edit this file to customize your widget or web page 
 according to the license.txt file included in the project.
 */

//
// This template also demonstrates how to make use of client-side database storage to store content that can be used, whether the application is online or offline.
// The database has one trivial table: a simple key-value table. You can imagine yourself having different tables with different columns, if you are familiar with relational database concepts.
//
// On devices that doesn't have the local database feature, the settings will not be remembered.
//

var database = null;                            // The client-side database
var DB_tableName = "SimpleKeyValueTable";       // database name
var originalSettings = {};                      // original message and settings, in case there is no client side database

//
// Function: load()
// Called by HTML body element's onload event when the web application is ready to start
//
function load()
{
    var element = document.getElementById('message');
    if (element) {
        originalSettings.message = element.value;
        originalSettings.color = 'black'; // We only have a limited set of color chips, so use 'black' here.
        var fontSettings = getFontSettingsFromElement(element);
        originalSettings.fontFamily = fontSettings.fontFamily;
        originalSettings.fontSize = fontSettings.fontSize;
        element.value = '';
    }
    
    dashcode.setupParts();
    
    initDB();
    if (!database) {
        element.value = originalSettings.message;
    }

	updateSummary();
}

function updateSummary() 
{
	$.getJSON(summaryUrl(), function(map) {
		setGaugeValue('gauge', map.percentage_used);
		setElementText('amountSpentVal', map.amount_spent);
		setElementText('amountRemainingVal', map.amount_remaining);
		setElementText('nextCycleVal', map.end_date);
	});
}

function summaryUrl() {
	//FIXME
	return 'http://192.168.1.102:8080/summary/1.json';
}

//
// Function: setGaugeValue(gaugeId, value)
// Sets the value of one of the monitor gauges
//
// gaugeId: Gauge to set
// value: Value to set gauge to
//
function setGaugeValue (gaugeId, value)
{
    var element = document.getElementById(gaugeId);
    if (element != null && element.object != null && element.object.setValue != null) {
        element.object.setValue(value);
    }
}

//
// Function: setElementText(elementName, elementValue)
// Set the text contents of an HTML div
//
// elementName: Name of the element in the DOM
// elementValue: Text to display in the element
//
function setElementText(elementName, elementValue)
{
    var element = document.getElementById(elementName);
    if (element) {
        element.innerText = elementValue;
    }
}

//
// Function: flipToFront(event)
// Flip to the front view to show the normal utility view
//
function flipToFront(event)
{
    var views = document.getElementById('views');
    var front = document.getElementById('front');
    if (views && views.object && front) {
        views.object.setCurrentView(front, true);
    }
}

//
// Function: flipToSettings(event)
// Flip to the back view to present user customizable settings
//
function flipToSettings(event)
{
    var views = document.getElementById('views');
    var settings = document.getElementById('settings');
    if (views && views.object && settings) {
        views.object.setCurrentView(settings);
    }
}

//
// Function: initDB()
// Init and create the local database, if possible
//
function initDB()
{
    try {
        if (window.openDatabase) {
            database = openDatabase("BudgetMinder", "1.0", "Budget Minder App Database", 1000);
            if (database) {
                database.transaction(function(tx) {
                    tx.executeSql("SELECT COUNT(*) FROM " + DB_tableName, [],
                    function(tx, result) {
                        loadMessage();
                    },
                    function(tx, error) {
                        // Database doesn't exist. Let's create one.
                        tx.executeSql("CREATE TABLE " + DB_tableName +
                        " (id INTEGER PRIMARY KEY," +
                        "  key TEXT," +
                        "  value TEXT)", [], function(tx, result) {
                            initMessage();
                            loadMessage();
                        });
                    });
                });
            }
        }
    } catch(e) {
        database = null;
    }
}

//
// Function: showError(errorString)
// Show an error
//
// errorString: string to be displayed
//
function showError(errorString)
{
    var element = document.getElementById('message');
    element.value = errorString;
    element.setAttribute('style', 'font-family: Helvetica; font-weight: bold; color: rgb(178, 6, 40);');
}

//
// Function: cleanTable()
// Utility function to clean table. It can be used to test table re-creation
//
function cleanTable()
{
    try {
        if (window.openDatabase) {
            database = openDatabase("Message", "1.0", "Message Database");
            if (database) {
                database.transaction(function(tx) {
                    tx.executeSql("DROP TABLE " + DB_tableName, []);
                });
            }
        }
    } catch(e) { 
    }
}

//
// Function: clearSettings()
// Reset settings to default
//
function clearSettings(event)
{
    if (database) {
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM " + DB_tableName, [],
            function(tx, result) {
                initMessage();
                loadMessage();
            },
            function (tx, error) {
                showError("Can't reset database");
            });
        });
    }
    else {
        initMessage();
        loadMessage();
    }
}

//
// Function: getFontSettingsFromElement(element)
// Get font family and size of an element
//
function getFontSettingsFromElement(element)
{
    var computedStyle = document.defaultView.getComputedStyle(element, null);
    var returnValue = {};
    
    returnValue.fontFamily = computedStyle.getPropertyValue("font-family");
    // Simplistic matching of font names like 'Marker Felt'
    try {
        if (returnValue.fontFamily.charAt(0) == "'") {
            returnValue.fontFamily = returnValue.fontFamily.substring(1, returnValue.fontFamily.length-1);
        }
    }
    catch (e) {}
    
    returnValue.fontSize = computedStyle.getPropertyValue("font-size");
    
    return returnValue;
}

//
// Function: initMessage()
// Initialize the message string to defaults. If there is database, the initialization values will be saved as well.
//
function initMessage()
{
    var element = document.getElementById('message');
    if (!element) return;
    
    // Clean inline styles so that external styles can be applied during init
    element.style.fontFamily = '';
    element.style.fontSize = '';
    element.value = originalSettings.message;
    
    if (database) {
        database.transaction(function (tx) {
            tx.executeSql("INSERT INTO " + DB_tableName + " (id, key, value) VALUES (?, ?, ?)", [0, 'message', originalSettings.message]);
            tx.executeSql("INSERT INTO " + DB_tableName + " (id, key, value) VALUES (?, ?, ?)", [1, 'font-family', originalSettings.fontFamily]);
            tx.executeSql("INSERT INTO " + DB_tableName + " (id, key, value) VALUES (?, ?, ?)", [2, 'font-size', originalSettings.fontSize]);
            tx.executeSql("INSERT INTO " + DB_tableName + " (id, key, value) VALUES (?, ?, ?)", [3, 'color', originalSettings.color]);
        });
    }
}

//
// Function: updateSelectValue(selectElement, value)
// Update the settings UI so that the right popup value is selected
//
// selectElement: the element with the popup
// value: the new value
//
function updateSelectValue(selectElement, value)
{
    var options = selectElement.options;
    var i = 0;
    for (; i < options.length; i++) {
        if (options.item(i).value == value) break;
    }
    if (i < options.length) {
        selectElement.selectedIndex = i;
    }
}

//
// Function: loadMessage()
// Load saved message and settings from the database. If there is no local database, we just use element's original properties
//
//
function loadMessage()
{
    var element = document.getElementById('message');
    
    if (database) {
        database.transaction(function(tx) {
            tx.executeSql("SELECT key, value FROM " + DB_tableName, [],
            function(tx, result) {
                for (var i = 0; i < result.rows.length; ++i) {
                    var row = result.rows.item(i);
                    var key = row['key'];
                    var value = row['value'];

                    if (key == 'message') {
                        element.value = value;
                    }
                    else {
                        element.style[key] = value;
                        if (key == 'font-family') {
                            updateSelectValue(document.getElementById('fontFamily'), value);
                        }
                        else if (key == 'font-size') {
                            updateSelectValue(document.getElementById('fontSize'), value);
                        }
                        else if (key == 'color') {
                            updateColorChip(value);
                        }
                    }
                }
            },
            function(tx, error) {
                showError('Failed to retrieve stored information from database - ' + error.message);
            });
        });
    }
    else {
        // Load defaults
        updateColorChip(originalSettings.color);
        updateSelectValue(document.getElementById('fontFamily'), originalSettings.fontFamily);
        updateSelectValue(document.getElementById('fontSize'), originalSettings.fontSize);
    }
}

//
// Function: messageChanged(event)
// Update the database when user changed the message
//
//
function messageChanged(event)
{
    if (database) {
        var element = document.getElementById('message');
        database.transaction(function (tx) {
            tx.executeSql("UPDATE " + DB_tableName + " SET key = 'message', value = ? WHERE id = 0", [element.value]);
        });
    }
}

function authenticate(event)
{
    // Insert Code Here
}


function addExpense(event)
{
    // Insert Code Here
}
