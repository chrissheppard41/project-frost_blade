myApp.filter('truncate', function () {
        return function (text, length, end) {
            if (isNaN(length))
                length = 10;

            if (end === undefined)
                end = "...";

            if (text.length <= length || text.length - end.length <= length) {
                return text;
            }
            else {
                return String(text).substring(0, length-end.length) + end;
            }

        };
    })
    .filter('joinBy', function () {
        return function (input,delimiter) {
            return (input || []).join(delimiter || ', ');
        };
    })
    .filter('active', function () {
        return function (input,delimiter) {
            if(delimiter == input && (input == "up" || input == "down")) {
                return " active";
            }
        };
    })
    .filter('hidden', function () {
        return function (input, delimiter) {
            if(delimiter === true) {
                return "True";
            } else {
                return "False";
            }
        };
    })
    .filter('groups', function () {
        return function (input, delimiter) {
            return (input.toLowerCase()).replace(" ", "");


        };
    });