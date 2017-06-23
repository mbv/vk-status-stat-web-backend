function generateTimes() {
    var result = [];
    for (var hour = 0; hour < 24; hour++) {
        for (var minute = 0; minute < 60; minute++) {
            result.push(((hour < 10) ? "0" : "") + hour + ":" + ((minute < 10) ? "0" : "") + minute)
        }
    }
    return result;
}
$(document).ready(function () {
    var myChart = new Chart($("#myChart"), {
        type: 'line',
        data: {
            labels: generateTimes(),
            datasets: [{
                label: 'Count:',
                data: [],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Online'
            },
            tooltips: {
                mode: 'index',
                intersect: false
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Month'
                    }
                }],
                yAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Value'
                    }
                }]
            }
        }
    });
    $.ajax({
        method: "GET",
        url: $(location).attr('href') + "/chart"
    })
        .done(function (result_array) {
            myChart.data.datasets[0].data = result_array;
            myChart.update();
        });
});