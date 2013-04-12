 
module.exports = {
    reporter: function (results) {
	var len = results.length;
	var str = "";
	var errsprinted = 0; 

	results.forEach(function (result) {
	    var file = result.file;
	    var error = result.error;

	    if (error.reason === "Mixed spaces and tabs.") {
		len--;
		return;
	    }

	    if(error.reason == "Use the object literal notation {}."){
		len--;
		return;
	    }

	    if(errsprinted < 5){
		errsprinted++;
		str += file + ': line ' + error.line + ', col ' +
		error.character + ', ' + error.reason + "\r\n";
	    }
	});

	var missedlines = len - errsprinted;
	if(missedlines > 0){
	    str += "...and " + missedlines + " more errors" + "\r\n";
	}
	 
	if (str) {
	    process.stdout.write(str + "\r\n");
	}
    }
};
