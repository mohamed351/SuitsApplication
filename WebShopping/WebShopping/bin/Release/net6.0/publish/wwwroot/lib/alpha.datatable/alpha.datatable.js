function tablePlugin(selector, url, columns) {

    var x = $(selector).DataTable({ //"#citytbl"
        lengthChange: false,
        info: true,
        searching: true,
        search: true,
        ordering: false,
        responsive: true,
        searchable: true,
        processing: true,
        serverSide: true,
        language: {
            paginate: {
                next: "Next",
                previous: "Pervious"
            }
        },
        ajax: {
            url: url,
            async: true,
            dataSrc: function (json) {

                console.log(json);
                return json.data;
            }

        },
        columns: columns

    });
    console.log(x);
    return x;

}