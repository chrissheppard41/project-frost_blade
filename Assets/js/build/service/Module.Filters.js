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
    })
    .filter('date', function () {
        return function (input, delimiter) {
            return moment(input, 'YYYY-MM-DD HH:mm:ss').fromNow();
        };
    })
    .filter('range', function() {
        return function(input, total, page) {
            total--;

            var buffer = 3,
                start = page - buffer,
                end = page + buffer;

            if(start < 0) {
                end -= (start);
                start = 0;
            }

            if(end >= total) {
                start -= (end - total);
                if(start < 0) start = 0;
                end = total;
            }

            for (var i = start, j = end; i <= j; i++)
                input.push(i);

            return input;
        };
    });