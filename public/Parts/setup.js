/* 
 This file was generated by Dashcode and is covered by the 
 license.txt included in the project.  You may edit this file, 
 however it is recommended to first turn off the Dashcode 
 code generator otherwise the changes will be lost.
 */
var dashcodePartSpecs = {
    "addExpenseBtn": { "creationFunction": "CreatePushButton", "initialHeight": 40, "initialWidth": 96, "leftImageWidth": 5, "onclick": "addExpense", "rightImageWidth": 5, "text": "Add Expense" },
    "amountRemainingVal": { "creationFunction": "CreateText" },
    "amountSpentVal": { "creationFunction": "CreateText" },
    "authenticateBtn": { "creationFunction": "CreatePushButton", "initialHeight": 30, "initialWidth": 89, "leftImageWidth": 5, "onclick": "authenticate", "rightImageWidth": 5, "text": "Authenticate" },
    "currencyLabel": { "creationFunction": "CreateText", "text": "$" },
    "cycleLabel": { "creationFunction": "CreateText", "text": "Next Cycle:" },
    "daysUntilVal": { "creationFunction": "CreateText" },
    "done": { "creationFunction": "CreatePushButton", "initialHeight": 30, "initialWidth": 49, "leftImageWidth": 5, "onclick": "flipToFront", "rightImageWidth": 5, "text": "Done" },
    "footer": { "creationFunction": "CreateText", "text": "Trackbux by Mario Aquino" },
    "gauge": { "creationFunction": "CreateGauge", "criticalValue": 90, "minValue": 99, "pivotOffsetX": 28, "pivotOffsetY": 28, "pointerReach": 85, "startAngle": 45, "stopAngle": 315, "warningValue": 50 },
    "infoButton": { "creationFunction": "CreatePushButton", "customImage": "Images/info.png", "customImagePosition": "PushButton.IMAGE_POSITION_CENTER", "customImagePressed": "Images/info_clicked.png", "initialHeight": 40, "initialWidth": 40, "leftImageWidth": 1, "onclick": "flipToSettings", "rightImageWidth": 1 },
    "nextCycleVal": { "creationFunction": "CreateText" },
    "passwordLabel": { "creationFunction": "CreateText", "text": "Password" },
    "remainingLabel": { "creationFunction": "CreateText", "text": "Amount Remaining:" },
    "reset": { "creationFunction": "CreatePushButton", "initialHeight": 33, "initialWidth": 157, "leftImageWidth": 5, "onclick": "clearSettings", "rightImageWidth": 5, "text": "Clear Settings" },
    "settingsTitle": { "creationFunction": "CreateText", "text": "Settings" },
    "spentLabel": { "creationFunction": "CreateText", "text": "Amount Spent:" },
    "usernameLabel": { "creationFunction": "CreateText", "text": "Username" },
    "views": { "creationFunction": "CreateStackLayout", "subviewsTransitions": [{ "direction": "right-left", "duration": "", "timing": "ease-in-out", "type": "flip" }, { "direction": "right-left", "duration": "", "timing": "ease-in-out", "type": "flip" }] }
};
