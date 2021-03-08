function fn(s) {
    var jsonDate = new Date(s);
    var actualDate = new Date();

    if (jsonDate.getDate() == actualDate.getDate() && jsonDate.getMonth() == actualDate.getMonth() && jsonDate.getFullYear() == actualDate.getFullYear()){
    	return true;
    } else {
    	return false;
    }
}