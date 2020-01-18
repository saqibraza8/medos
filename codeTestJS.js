// JavaScript source code
//var htmlTemplate = '<div style="width:100%;height:100px;border:2px solid black;display:flex"> <div id="rangeHolder1"></div> <div>-</div> <div id="rangeHolder2"></div> </div> <div style="width:100%;height:500px;display:flex"> <div style="width:50%;padding:20px"> <div style="width:100%;height:100%;border:2px solid black;display:flex;flex-direction:column"> <div id="monthNameA">Month A</div> <div id="monthAArr"> <div style="width:80px;height:80px;padding:5px"> <div style="width:100%;height:100%;border:2px solid black;text-align:center"> 2-wednesday </div> </div> </div> </div> </div> <div style="width:50%;padding:20px"> <div style="width:100%;height:100%;border:2px solid black;display:flex;flex-direction:column"> <div id="monthNameB">Month B</div> <div id="monthBArr"></div> </div> </div> </div>'
var htmlTemplate = `<div style="width:100%;height:100px;border:2px solid black;display:flex;font-size:30px">
        <div id="rangeHolder1" style="margin-left:25%"></div>
        <div> - </div>
        <div id="rangeHolder2"></div>
    </div>

    <div style="width:100%;height:180px;display:flex">
        <div style="width:47%;padding:10px">
            <div style="width:100%;height:100%;border:2px solid black;">
                <div id="monthNameA" style="font-size: 25px;text-align:center">Month A</div>
                <div id="monthAArr" style="display:flex;overflow-y:scroll">
                    
                </div>
            </div>

        </div>
        <div style="width:47%;padding:10px">
            <div style="width:100%;height:100%;border:2px solid black;">
                <div id="monthNameB" style="font-size: 25px;text-align:center">Month B</div>
                <div id="monthBArr" style="display:flex;overflow-y:scroll"></div>
            </div>

        </div>
    </div>`;


function getDaysArr(year, month) {
    var monthIndex = month - 1;
    var names = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    var date = new Date(year, monthIndex, 1);
    var result = [];
    while (date.getMonth() == monthIndex) {
        result.push(date.getDate() + "-" + names[date.getDay()]);
        date.setDate(date.getDate() + 1);
    }
    return result;
}

function selectDate(item, cat) {
    var operatingMonth = cat == 1 ? months[0] : months[1];

    if (selection[cat]) {
        if (document.getElementById(selection[cat].id)){
            document.getElementById(selection[cat].id).style.backgroundColor = myCalenderConfig["unselectedColor"];
        }
        
    }
    
    var dateObj = {
        dateDisplay: item.innerHTML.split("-")[0] + " " + monthMap[operatingMonth - 1] + " " + year,
        actualDate: item.innerHTML.split("-")[0] + "-" + operatingMonth + "-" + year,
        id: item.id
    };
    selection[cat] = dateObj;
    item.style.backgroundColor = myCalenderConfig["selectedColor"];

    document.getElementById("rangeHolder" + cat).innerHTML = " " + selection[cat].dateDisplay + " ";


}

var monthMap = {
    0: "January",
    1: "Feburary",
    2: "March",
    3: "April",
    4: "May",
    5: "June",
    6: "July",
    7: "August",
    8: "September",
    9: "October",
    10: "November",
    11: "December"
}

var selection = { 1: null, 2: null };

var myCalender = {
    getSelectedDates: function () {
        if (selection[1] == null && selection[2] == null)
            return "No dates Selected yet"
        else {
            return {
                "date from A": selection[1] ? selection[1] : "No Date selected from A",
                "date from B": selection[2] ? selection[2] : "No Date selected from B",
            }
        }
    },
    getMonths: function () {
        return {
            "months": months,
            "displayValues": function () {
                var displayMonths = [];
                months.forEach(function (m) {
                    displayMonths.push(monthMap[m - 1]);
                });

                return displayMonths;
            }
        }
    },
    getYear: function () {
        return year;
    },
    setYear: function (newYear) {
        year = newYear;
        loadCalender(year, months);
    },
    setMonths: function (arr) {
        months = arr;
        loadCalender(year, months);
    }
}

var myCalenderConfig = {
    unselectedColor: "white",
    selectedColor: "yellow",
    setSelectedColor: function (color) {
        this.selectedColor = color;
    },
    setUnselectedColorColor: function (color) {
        this.unselectedColor = color;
    }
};

function loadCalender(year, months) {
    document.getElementsByTagName("my-calender")[0].innerHTML = htmlTemplate;

    document.getElementById("monthAArr").innerHTML = "";


    var daysArray1 = getDaysArr(year, months[0]);
    var daysArray2 = getDaysArr(year, months[1]);

    daysArray1.forEach(function (dateItem) {
        var html = document.getElementById("monthAArr").innerHTML;
        document.getElementById("monthAArr").innerHTML = html + '<div style="width:80px;height:80px;padding:5px;margin:0px !important"> <div style="width:100%;height:100%;border:2px solid black;text-align:center" id="' + dateItem + '" onclick="selectDate(this,1)">' + dateItem + '</div> </div>'

    })

    document.getElementById("monthBArr").innerHTML = "";
    daysArray2.forEach(function (dateItem) {
        var html = document.getElementById("monthBArr").innerHTML;
        document.getElementById("monthBArr").innerHTML = html + '<div style="width:80px;height:80px;padding:5px;margin:0px !important"> <div style="width:100%;height:100%;border:2px solid black;text-align:center" id="' + dateItem + '" onclick="selectDate(this,2)">' + dateItem + '</div> </div>'

    })

    document.getElementById("monthNameA").innerHTML = monthMap[months[0] - 1] + " " + year;
    document.getElementById("monthNameB").innerHTML = monthMap[months[1] - 1] + " " + year


}

if (document.getElementsByTagName("my-calender")) {

    var year = document.getElementsByTagName('my-calender')[0].attributes.year.value
    var months = document.getElementsByTagName('my-calender')[0].attributes.months.value.split(",");


    loadCalender(year, months);

}
