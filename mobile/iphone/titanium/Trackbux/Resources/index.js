window.onload = function()
{
    spec = { "criticalValue": 90, "imageHeight": 188, 
			"imagePointer": "Images/gauge_needle.png", 
			"imageWidth": 57, "minValue": 99, "pivotOffsetX": 28, 
			"pivotOffsetY": 28, "pointerReach": 85, "startAngle": 45, 
			"stopAngle": 315, "warningValue": 50 };

	var gaugeObject = CreateGauge("gauge", spec);
	
	Titanium.Gesture.addEventListener('shake',function(){
		var alerty = Titanium.UI.createAlertDialog();
		alerty.setTitle("Not stirred!");
		alerty.show();
	},false);
	
};
