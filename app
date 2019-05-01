// Initialize Firebase
  var config = {
      apiKey: "AIzaSyA_vYMMwJZwo4XNWpRYL5vhdFgtq1l13_U",
      authDomain: "test-neet.firebaseapp.com",
      databaseURL: "https://test-neet.firebaseio.com",
      projectId: "test-neet",
      storageBucket: "test-neet.appspot.com",
      messagingSenderId: "689626797297"
  };
  firebase.initializeApp(config);

const auth = firebase.auth();
var db = firebase.database();
var userPos = {}
$(document).ready(function(){



    
   
})



function pushPage(page, anim) {
    if (anim) {
        document.getElementById('appNavigator').pushPage(page.id, { data: { title: page.title }, animation: anim });
    } else {
        document.getElementById('appNavigator').pushPage(page.id, { data: { title: page.title } });
    }
};

function swipeNext(id) {
    var activeIndex = document.querySelector('ons-carousel').getActiveIndex();
    carousel.setActiveIndex(activeIndex + 1);
    console.log(carousel._swiper.itemCount);
    if (activeIndex + 2 == carousel._swiper.itemCount) {
        $("#btnSubmit").show();
        $("#btnNext").hide();
    }
    else {
        $("#btnSubmit").hide();
        $("#btnNext").show();
    }
}

function swipePrev(id) {
    var activeIndex = document.querySelector('ons-carousel').getActiveIndex();
    carousel.setActiveIndex(activeIndex - 1);
    console.log(carousel._swiper.itemCount);
    if (activeIndex + 2 == carousel._swiper.itemCount) {
        $("#btnSubmit").show();
        $("#btnNext").hide();
    }
    else {
        $("#btnSubmit").hide();
        $("#btnNext").show();
    }
}

var LoginApp = angular.module("healthcareLoginApp", ['multipleDatePicker','onsen']);

LoginApp.controller("mainController", function ($scope, $http, $sce, $timeout, $element, $window,  $log, $filter, $element) {

    this.questionArray = [
    
        //{   "id":1,
        //    "q":"There are 15 questions and time alloted is 20 minutes.",
        //    "op":["aron1","varun1","ram","rahim"]
        //},
        //{   "id":2,
        //    "q":"There are 16 questions and time alloted is 20 minutes.",
        //    "op":["aron2","varun2","ram","rahim"]
        //},
        //{   "id":3,
        //    "q":"There are 17 questions and time alloted is 20 minutes.",
        //    "op":["aron3","varun3","ram","rahim"]
        //},
        //{   "id":4,
        //    "q":"There are 18 questions and time alloted is 20 minutes.",
        //    "op":["aron4","varun4","ram","rahim"]
        //}
    ]
    
	this.username='';
	this.password='';
    $scope.showQNav = function(){
        
        var ques = [];
		
		
        for(var i=0;i<this.questionArray.length;i++){
        
            ques.push({'label' :'Question '+(i+1)})
        }
        

        ons.openActionSheet({
            title: 'Navigate to',
            cancelable: true,
            buttons: ques
        }).then(function (index) {
            if (index > -1) {
                if (index + 1 == carousel._swiper.itemCount) {
                    $("#btnSubmit").show();
                    $("#btnNext").hide();
                }
                else {
                    $("#btnSubmit").hide();
                    $("#btnNext").show();
                }
                carousel.setActiveIndex(index + 1 );
            }
            
        })

    }
    function goToQues(id){
        carousel.setActiveIndex(id);
    }
    $scope.refreshClicker = function () {
        var status = localStorage.getItem("state");
        $(".loader").show();
        var state = status + "Answers";
        var rightAns = localStorage.getItem(state).split(",");
        this.detailQuestions = _.filter(questionBank, function (question) { return rightAns.indexOf(question.qusid.toString()) > -1 })
        
        $(".loader").hide();
                
    }
    $scope.toggleAcc = function(){
    
        if($('.mdl-layout__drawer.account').hasClass('active')){       
            $('.mdl-layout__drawer.account').removeClass('active'); 
            $('.mdl-layout__drawer.account').css('width','0px');
        }
        else{
            $('.mdl-layout__drawer.account').addClass('active');
            $('.mdl-layout__drawer.account').css('width','100%');
        }
    }
    this.userObject = [];
  //  auth.onAuthStateChanged(function(firebaseUser){
  //      $(".loader").show();
        
        
  //      if(firebaseUser){
  //          var searchMail = firebaseUser.email.replace("@","");
  //          searchMail = searchMail.replace(".","");
  //          db.ref('user-mail/'+searchMail).once('value',function(snapshot){
  //              this.lookUpNumber = snapshot.val().phone;
                
  //          }).then(function(){
  //              db.ref('users/'+this.lookUpNumber).once('value',function(snapshot){
  //                  $scope.userObject = snapshot.val();
                
  //              });
  //          });
           
  //          $("#notLogged").hide();
  //          $("#logedIn").show();
  //      }
  //      else{
  //         $("#notLogged").show();
  //          $("#logedIn").hide();
  //      }
        
		//$(".loader").hide();

  //  })
    function loadHomePage() {
        $(".loader").show();
        
        var userID = localStorage.getItem("userID");
        if (userID != null) {
            db.ref("users/" + userID).on('value', function (snapshot) {
                var testsTillNow = snapshot.val().tests;
                //entire code here
                localStorage.setItem("Validator", snapshot.val().subscription.code);
                localStorage.setItem("fullName", snapshot.val().name);
                localStorage.setItem("email", snapshot.val().email);
                localStorage.setItem("testsObj", JSON.stringify(snapshot.val().tests));
                var testIDs = Object.keys(testsTillNow);

                var scores = [];

                testIDs.forEach(function (id) {
                    scores.push(Math.round(parseFloat(testsTillNow[id].result)));
                })

                var topScore = Math.max(...scores);

                var gaugeOptions = {

                    chart: {
                        type: 'solidgauge'
                    },

                    title: null,

                    pane: {
                        center: ['50%', '85%'],
                        size: '140%',
                        startAngle: -90,
                        endAngle: 90,
                        background: {
                            backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
                            innerRadius: '60%',
                            outerRadius: '100%',
                            shape: 'arc'
                        }
                    },

                    tooltip: {
                        enabled: false
                    },

                    // the value axis
                    yAxis: {
                        stops: [
                            [0.1, '#55BF3B'], // green
                            [0.5, '#DDDF0D'], // yellow
                            [0.9, '#DF5353'] // red
                        ],
                        lineWidth: 0,
                        minorTickInterval: null,
                        tickAmount: 2,
                        title: {
                            y: -70
                        },
                        labels: {
                            y: 16
                        }
                    },

                    plotOptions: {
                        solidgauge: {
                            dataLabels: {
                                y: 5,
                                borderWidth: 0,
                                useHTML: true
                            }
                        }
                    }
                };

                var chartRpm = Highcharts.chart('containerTopScore', Highcharts.merge(gaugeOptions, {
                    yAxis: {
                        min: 0,
                        max: 100,
                        title: {
                            text: 'Your Top Score'
                        }
                    },

                    series: [{
                        name: 'RPM',
                        data: [topScore],
                        dataLabels: {
                            format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                                ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y:.1f}</span><br/>' +
                                '<span style="font-size:12px;color:silver">%'
                        },
                        tooltip: {
                            valueSuffix: ' revolutions/min'
                        }
                    }]

                }));

                Highcharts.chart('containerScore', {

                    title: {
                        text: 'Test Score History. Tap on points to revise.'
                    },

                    xAxis: {
                        categories: testIDs,
                        labels:
                        {
                            enabled: false
                        }
                    },

                    yAxis: {
                        title: {
                            text: 'Scores'
                        }
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle'
                    },

                    plotOptions: {
                        series: {
                            label: {
                                connectorAllowed: false
                            },

                            point: {
                                events: {
                                    click: function () {

                                        //alert('Category: ' + this.category + ', value: ' + this.y);
                                        var testID = this.category;
                                        db.ref("demoTest/" + testID).on('value', function (snapshot) {
                                            var dbObj = snapshot.val();
                                            //console.log(dbObj);

                                            localStorage.setItem("testScore", dbObj.result);
                                            localStorage.setItem("correctAnswers", dbObj.right);
                                            localStorage.setItem("wrongAnswers", dbObj.wrong);

                                            pushPage({ 'id': 'reviseTest.html', 'title': 'Medicine' })
                                        });
                                    }
                                }
                            }
                        }
                    },

                    series: [{

                        data: scores
                    }],

                    responsive: {
                        rules: [{
                            condition: {
                                maxWidth: 500
                            },
                            chartOptions: {
                                legend: {
                                    layout: 'horizontal',
                                    align: 'center',
                                    verticalAlign: 'bottom'
                                }
                            }
                        }]
                    }

                });

                $(".loader").hide();

            });
        }
        else {
            var html = '<p style="padding: 25%;font-size: 18px;font-weight: bold;"> Please Login or Register to continue</p>';
            document.getElementById("containerTopScore").innerHTML = html;
        }



    }
    $scope.verificationCode = "";
    $scope.showSubcription = function () {
        console.log($scope, this);
        pushPage({ 'id': 'subscription.html', 'title': 'Subscription Details' });
        var _this = $scope
        $(".loader").show();

                var obj = localStorage.Validator
                if (obj === "INVALID") {
                    $scope.btnText = "Subscribe";
                    $scope.disableTest = false;
                    $(".loader").hide();
                }
                else {
                    $scope.verificationCode = obj;
                    $scope.disableTest = true;
                    $scope.btnText = "Your Subscription is Active.";
                    
                    $(".loader").hide();
                }
        //    }).then(function () {
        //        if (localStorage["subCode"]) {
        //            
        //        }
                
                    
                
                
        //    })
        //}, 1000);
        
    }
    this.subscribe = function () {
        var code = $("#codeInput")[0].value;
        if (code.length > 0) {
            db.ref("subscriptioncodes/" + code).once('value', function (snapshot) {
                if (snapshot.val() == null) {
                    alert("Please Enter a valid Subscription Code");
                }
                else {
                    if (snapshot.val().isActive.toString() === "false") {
                        var isActive = localStorage.userID;
                        db.ref("users/" + localStorage.userID + "/" + "subscription").set({ code }).then(function () {
                            db.ref("subscriptioncodes/" + code).set({ isActive }).then(function () {
                                alert("You have successfully activated your subscription");
                            })
                        })
                    }
                    else {
                        alert("Please Enter a valid Subscription Code");
                    }
                }
            });
        }
        else {
            alert("Please Enter a valid Code");
        }
        
    }
    $scope.openCueCards = function () {
        console.log($scope, this);
        
        $(".loader").show();

        
        var testJSON = JSON.parse(localStorage.testsObj);
        if (Object.keys(testJSON).length > 0) {
            pushPage({ 'id': 'cuecards.html', 'title': 'Cue Cards' });

            var WrongQuestionArray = [];
            var wrongID = "";
            Object.keys(testJSON).forEach(function (key) {
                if (wrongID.length == 0) {
                    wrongID = wrongID + testJSON[key].wrong;
                }
                else {
                    wrongID = wrongID + "," + testJSON[key].wrong;
                }

            });
            WrongQuestionArray = wrongID.split(",");



            var medQuestions = _.filter(questionBank, function (item) { return WrongQuestionArray.indexOf(item.qusid.toString()) > -1 });
            var questions = [];
            var qidArr = [];

            medQuestions.forEach(function (quest) {
                if (WrongQuestionArray.indexOf(quest.qusid.toString()) > -1 && questions.indexOf(quest) == -1) {
                    if (qidArr.indexOf(quest.qusid.toString()) == -1) {
                        questions.push(quest);
                        qidArr.push(quest.qusid.toString());
                    }

                }
            });

            $scope.cueCardArray = questions;
        }
        else {
            alert("You have not attempted any tests yet.")
        }
            

        $(".loader").hide();

        
    }

    $scope.personalDetails = function () {
        console.log($scope, this);
        pushPage({ 'id': 'personalDetails.html', 'title': 'Personal Details' });
        var _this = $scope
        $(".loader").show();

        
        $scope.fullName = localStorage.fullName;
        $scope.email = localStorage.email;
        $scope.blckPhone = localStorage.userID;
        $scope.disableTest = true;
            

        $(".loader").hide();
        
       

    }
    this.login = function(){
    
        this.userObject = [];

        //alert("Log in disabled in demo version. You are logged in as demoUser. Please Contact administrator for more details")
    	
    	$scope.username = this.username;
        $scope.password = this.password;
        localStorage.setItem("typePw", this.password);
        localStorage.setItem("typeID", this.username);
		$(".loader").show();
    	db.ref('users/'+this.username).once('value',function(snapshot){
    		if(snapshot.val()!=null){
    			
                if (snapshot.val().password == localStorage["typePw"]) {
                    
                    localStorage.setItem("userID", localStorage["typeID"]);
                    
                    loadHomePage();
                    
                    $("#notLogged").hide();
                    $("#logedIn").show();
                    $(".loader").hide()
                }
                else {
                    alert("You have entered an incorrect password");
                    $(".loader").hide();
                }
    		}
    		else{
                alert("Phone Number Does not Exist.");
                $(".loader").hide();
    		}
    	
        })

     //       .then(function () {
    	//    if(this.userObject!=null){
    	//    $scope.userObject = this.userObject;
    	//	const promise =  auth.signInWithEmailAndPassword(this.userObject.email,$scope.password);
     //                           promise.catch(function(e){
     //                               alert(e.message);
     //                               $(".loader").hide();
                                    
     //                           });
    		
    	//	}
    	//	else{
    	//		alert('Phone number does not exist');
    	//		$(".loader").hide();
    	//	}
    		
    	//})
    	
    }

   
    $scope.submitTest = function () {
        var testId = Object.keys(this.testAnswers)[0];
        var questionsAttempted = Object.keys(this.testAnswers[testId]);
        clearInterval(xTimer);
        //if (questionsAttempted.length == 0) {
        //    alert("You have not attempted any question. Please attempt atlaest one question.");
        //}
        //else {
            $scope.testFlow = false;
            var totalMarks = this.questionArray.length;
            var rightQuestions = [];
            var wrongQuestions = [];
            var _this = this;
            questionsAttempted.forEach(function (question) {
                if (_this.testAnswers[testId][question]) {
                    if (_this.testAnswers[testId][question].result === "correct") {
                        rightQuestions.push(question);
                    }
                    
                }
            });
            this.questionArray.forEach(function (question) {
                if (rightQuestions.indexOf(question.qusid) == -1) {
                    wrongQuestions.push(question.qusid);
                }
            });

            var result = (rightQuestions.length / totalMarks) * 100;

            this.result = result;

            document.getElementById("scoreContainer").innerHTML = " " + Math.round(parseFloat(result)) + "%";

            this.rightQuestions = rightQuestions.length;

            document.getElementById("rightContainer").innerHTML = " " + rightQuestions.length;

            this.wrongQuestions = wrongQuestions.length;

            document.getElementById("wrongContainer").innerHTML = " " + wrongQuestions.length;

            $("#testArea").hide();

            $("#resultArea").show();

            var testResultObj = {};

            testResultObj["ID"] = testId;
            testResultObj["result"] = result;
            testResultObj["right"] = rightQuestions.toString();
            testResultObj["wrong"] = wrongQuestions.toString();

        db.ref("users/" + localStorage.userID + "/tests/" + testId).set(testResultObj);
        //}
    }
    this.register = function(){
    
    	$(".loader").show();
    	this.userObject = [];
    	$scope.username = this.username;
		$scope.password = this.password;
		$scope.name = this.name;
		$scope.email = this.email;
        if (this.password == this.repPassword) {
            
    		db.ref('users/'+this.username).once('value',function(snapshot){
    		
    		  this.userObject = snapshot.val();
    		  
    	
    	}).then(function(){
    		if(this.userObject==null){
    			 //auth.createUserWithEmailAndPassword($scope.email,$scope.password).then(function(){
    			 //const promise =  auth.signInWithEmailAndPassword($scope.email,$scope.password);
    			 //promise.then(function(){
    			 firebase.database().ref('users/' + $scope.username).set({
                        name :   $scope.name,      
                        email: $scope.email,
                        password: $scope.password,
                        subscription: { code: "INVALID" },
                        tests: "Not Yet"
                    }).then(function(){
                    	alert('Registered Succesfully');
                    	location.reload();
                    });
    			 //})
    			 	
    			 //});
    		}
    		else{
    			alert('Phone number already exists');
    			$(".loader").hide();
    		}
    		
    	})
    	}
    	else{
    	
    		alert("Passwords dont match");
    	}
    	
    	
    }
    
    this.logout = function () {
        var r = confirm("Are you sure Logout?");
        if (r) {
            delete localStorage["userID"];
            delete localStorage["Validator"];
            
            location.reload();
        }
    	
    }

    $scope.nextQ = function(){
    
        $('#questions').trigger('to.owl.carousel', parseInt($('#questions .owl-item.active')[0].childNodes[0].id.split('_')[1]) + 1);
        if((parseInt($('#questions .owl-item.active')[0].childNodes[0].id.split('_')[1]) + 1)==$scope.questionArray.length){
            $("#nextBtn").hide();
            $("#btnSubmit").show();
        }
    }
    $scope.previousQ = function(){
    
        $('#questions').trigger('to.owl.carousel', parseInt($('#questions .owl-item.active')[0].childNodes[0].id.split('_')[1]) - 1)  ;
        $("#nextBtn").show();
        $("#btnSubmit").hide();
    }

    $scope.navToQ = function(){
        
        carousel.setActiveIndex(this.item.id -1 );
        //if(this.item.id==$scope.questionArray.length){
        //    $("#nextBtn").hide();
        //    $("#btnSubmit").show();
        //}
        //else{
        //    $("#nextBtn").show();
        //    $("#btnSubmit").hide();
        //}
    }

    $scope.startTest = function(){
    
        $("#testSubContainer").children().hide(); 
        //$("#testArea").show();

        $("#testCtrls").show();
    }

    $scope.toggleMenu = function(){
    
        if($('.mdl-layout__drawer.menu').hasClass('active')){       
            $('.mdl-layout__drawer.menu').removeClass('active');
            $('.mdl-layout__drawer.menu').css('width','0px');
        }
        else{
            $('.mdl-layout__drawer.menu').addClass('active');
            $('.mdl-layout__drawer.menu').css('width','100%');
        }
    }

    var globalUserObject;

    $scope.toogleTestView = function(testHeader,testDiv){
        $scope.testHeader = testHeader;

        $("#testSubContainer").children().hide(); 
        $("#"+testDiv).show();
        $("#testCtrls").hide();

        if($('.mdl-layout__drawer.fullTest').hasClass('active')){       
            $('.mdl-layout__drawer.fullTest').removeClass('active');
            $('.mdl-layout__drawer.fullTest').css('width','0px');
        }
        else{
            $('.mdl-layout__drawer.fullTest').addClass('active');
            $('.mdl-layout__drawer.fullTest').css('width','100%');
        }
    
    }
    var limit;
    var globalQuestionObject;
    var testLimitNow;
    var globalUserObject;
    $scope.selectAnswer = function(id){
        var qid = id.item.qusid;
        $scope.testAnswers[localStorage.getItem("testID")][qid] = {};
        $scope.testAnswers[localStorage.getItem("testID")][qid]["result"] = (event.currentTarget.value.split("_")[1] === id.item.ans) ? "correct" : "wrong";


    }
    $scope.testAnswers = {};
    $scope.testID = "";
    $scope.showCorrectAnswers = function () {
        localStorage.setItem("state","correct");
        pushPage({ 'id': 'reviseTestDetail.html', 'title': 'Correct Answers' });
       
    }
    $scope.showWrongAnswers = function () {
        localStorage.setItem("state", "wrong");
        pushPage({ 'id': 'reviseTestDetail.html', 'title': 'Correct Answers' });
    }
    $scope.testFlow = false;
    $scope.countDownDate = new Date();
    $scope.clickTestTile = function (id, subject) {
        if (localStorage.userID == null) {
            alert("You need to login first")
        }
        else {
            localStorage.setItem("QID", id);
            localStorage.setItem("testSubject", subject);
            if (localStorage.Validator === "INVALID" || localStorage.Validator === null) {
                alert("Please get a subscription first");
            }
            else {
                if (id == "full") {
                    $scope.questionLength = '300';
                    $scope.timeLength = '3 hours 30 mins';
                }
                else {
                    $scope.questionLength = '50';
                    $scope.timeLength = '60 mins';
                }

                pushPage({ 'id': 'takeTest.html', 'title': subject });
            }
        }
        
        
    }
    $scope.beginMedTest = function () {
        $scope.testAnswers = {};
        localStorage.setItem("testID", "test_user1_" + "medicine" + new Date().getTime());
        $scope.testAnswers[localStorage.getItem("testID")] = {};
        $("#clicker_test").hide();
        $('.loader').show();
        $('#testArea').show();
        $('#testTimer').show();
        $("#btnStartTest").hide();

        //limit = this.userObject.sets.MEDICINE;
        //globalUserObject = this.userObject;

        //this.questionArray = globalQuestionObject;


        var medQuestions = _.filter(questionBank, function (item) { return item.qusid.toString().substring(0, 2) == localStorage.QID });
        var testJSON = JSON.parse(localStorage.testsObj);
        var attemptedQues = [];
        Object.keys(testJSON).forEach(function (testKey) {
            attemptedQues = [...testJSON[testKey].right.split(",")];
            attemptedQues = [...testJSON[testKey].wrong.split(",")];
        });

        if (localStorage.QID === "full") {
            var questions = [];

            var pattern =
                [{ code: "29", number: 15 },
                { code: "28", number: 15 },
                { code: "27", number: 15 },
                { code: "25", number: 20 },
                { code: "26", number: 20 },
                { code: "23", number: 25 },
                { code: "24", number: 10 },
                { code: "22", number: 25 },
                { code: "11", number: 19 },
                { code: "18", number: 18 },
                { code: "12", number: 12 },
                { code: "16", number: 16 },
                { code: "14", number: 14 },
                { code: "19", number: 19 },
                { code: "20", number: 12 },
                { code: "13", number: 25 },
                { code: "15", number: 15 },
                { code: "17", number: 10 },
                { code: "21", number: 10 }
                ];

            pattern.forEach(function (subItem) {
                var arr = []
                while (arr.length < subItem.number) {
                    var r = Math.floor(Math.random() * 600) + 1;
                    var s = r + "";
                    while (s.length < 3) s = "0" + s;
                    var checkstr = subItem.code + "00" + s
                    if (arr.indexOf(s) === -1 && attemptedQues.indexOf(checkstr) == -1) arr.push(subItem.code + "00" + s);
                }

                console.log(arr);


                var qidArr = [];

                questionBank.forEach(function (quest) {
                    if (arr.indexOf(quest.qusid.toString()) > -1 && questions.indexOf(quest) == -1) {
                        if (qidArr.indexOf(quest.qusid.toString()) == -1) {
                            questions.push(quest);
                            qidArr.push(quest.qusid.toString());
                        }

                    }
                })

            })

        }
        else {
            var arr = []
            while (arr.length < 45) {
                var r = Math.floor(Math.random() * 600) + 1;
                var s = r + "";
                while (s.length < 3) s = "0" + s;
                var checkstr = localStorage.QID + "00" + s
                if (arr.indexOf(s) === -1 && attemptedQues.indexOf(checkstr) == -1) arr.push(localStorage.QID + "00" + s);
            }

            console.log(arr);

            var questions = [];
            var qidArr = [];

            medQuestions.forEach(function (quest) {
                if (arr.indexOf(quest.qusid.toString()) > -1 && questions.indexOf(quest) == -1) {
                    if (qidArr.indexOf(quest.qusid.toString()) == -1) {
                        questions.push(quest);
                        qidArr.push(quest.qusid.toString());
                    }

                }
            })
        }

        


        //$.ajax({
        //    url: "GlobalQuestionSet.json",
        //    async: false,
        //    dataType: 'json',
        //    success: function (json) {
        //        //console.log(json); 
        //        //var totalSet = _.filter(json,function(item,index){

        //        //    return index > limit;

        //        //})

        //        //var freshquestion = _.filter(totalSet,function(item,index){
        //        //    return index < 45;
        //        //})
        //        //testLimitNow = limit + 45;
        //        //var alreadyWrongIDMedicine = _.filter(globalUserObject.incorrectId.split(";"),function(item){ return item.toString().substring(0,2) === "11"});

        //        //var previousWrongQuestionforRevsion = _.filter(json,function(item){ return alreadyWrongIDMedicine.indexOf(item.qusid.toString())>-1 });

        //        //var finalQuestionArray = freshquestion.concat(previousWrongQuestionforRevsion);

        //        //globalQuestionObject = finalQuestionArray;

        //    }
        //});

        this.questionArray = questions;
        $scope.testFlow = true;
        $('.loader').hide();

        if (localStorage.QID === "full") {
            $scope.countDownDate = new Date(moment().add(3.5, 'hours'));
        }
        else {
            $scope.countDownDate = new Date(moment().add(60, 'minutes'));
        }
       

        // Update the count down every 1 second
        if (timerValid) {
            clearInterval(xTimer);
            timerValid = null;
        }
        
        timerValid = setInterval(xTimer, 1000);
    }
    var timerValid;
    function xTimer () {

        if ($scope.testFlow) {
            // Get todays date and time
            var now = new Date().getTime();

            // Find the distance between now and the count down date
            var distance = $scope.countDownDate - now;

            // Time calculations for days, hours, minutes and seconds
            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((distance % (1000 * 60)) / 1000);

            // Output the result in an element with id="demo"
            if (localStorage.QID === "full") {
                document.getElementById("testTimer").innerHTML = hours + "h " + minutes + "m " + seconds + "s ";
            }
            else {
                document.getElementById("testTimer").innerHTML = minutes + "m " + seconds + "s ";
            }
            

            // If the count down is over, write some text 
            if (distance < 0) {
                clearInterval(xTimer);
                timerValid = null;
                alert("Your time is up. The test will be submitted now.");
                $("#btnSubmit").trigger('click');
            }
        }


    }

    $scope.startMedicineTest = function(){

        pushPage({ 'id': 'startTheTest.html', 'title': localStorage.testSubject });
    }
    
    $scope.footNav = function(id){
        $('#appCarousel').trigger('to.owl.carousel', parseInt(id))
    }

    
}).config(function ($httpProvider) {
    $httpProvider.defaults.headers.post = {};
    $httpProvider.defaults.headers.post["Content-Type"] = "application/json; charset=utf-8";
})

