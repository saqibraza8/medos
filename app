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
    auth.onAuthStateChanged(function(firebaseUser){
        $(".loader").show();
        
        
        if(firebaseUser){
            var searchMail = firebaseUser.email.replace("@","");
            searchMail = searchMail.replace(".","");
            db.ref('user-mail/'+searchMail).once('value',function(snapshot){
                this.lookUpNumber = snapshot.val().phone;
                
            }).then(function(){
                db.ref('users/'+this.lookUpNumber).once('value',function(snapshot){
                    $scope.userObject = snapshot.val();
                
                });
            });
           
            $("#notLogged").hide();
            $("#logedIn").show();
        }
        else{
           $("#notLogged").show();
            $("#logedIn").hide();
        }
        
		$(".loader").hide();

    })
    
    this.login = function(){
    
        this.userObject = [];

        alert("Log in disabled in demo version. You are logged in as demoUser. Please Contact administrator for more details")
    	
  //  	$scope.username = this.username;
		//$scope.password = this.password;
		//$(".loader").show();
  //  	db.ref('users/'+this.username).once('value',function(snapshot){
  //  		if(snapshot.val()!=null){
  //  			this.userObject = snapshot.val();
  //  			this.userObject.password = this.password;
  //  		}
  //  		else{
  //  		    this.userObject = snapshot.val();
  //  		    $scope.userObject = this.userObject;
  //  		}
    	
  //  	}).then(function(){
  //  	    if(this.userObject!=null){
  //  	    $scope.userObject = this.userObject;
  //  		const promise =  auth.signInWithEmailAndPassword(this.userObject.email,$scope.password);
  //                              promise.catch(function(e){
  //                                  alert(e.message);
  //                                  $(".loader").hide();
                                    
  //                              });
    		
  //  		}
  //  		else{
  //  			alert('Phone number does not exist');
  //  			$(".loader").hide();
  //  		}
    		
  //  	})
    	
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

            db.ref("demoTest/" + testId).set(testResultObj);
        //}
    }
    this.register = function(){
    
    	$(".loader").show();
    	this.userObject = [];
    	$scope.username = this.username;
		$scope.password = this.password;
		$scope.name = this.name;
		$scope.email = this.email;
    	if(this.password == this.repPassword){
    		db.ref('users/'+this.username).once('value',function(snapshot){
    		
    		  this.userObject = snapshot.val();
    		  
    	
    	}).then(function(){
    		if(this.userObject==null){
    			 //auth.createUserWithEmailAndPassword($scope.email,$scope.password).then(function(){
    			 //const promise =  auth.signInWithEmailAndPassword($scope.email,$scope.password);
    			 //promise.then(function(){
    			 firebase.database().ref('users/' + $scope.username).set({
                        name :   $scope.name,      
                        email:   $scope.email
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
    
    this.logout = function(){
    	firebase.auth().signOut();
    	location.reload();
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
        $("#testArea").show();

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
    $scope.beginMedTest = function () {
        $scope.testAnswers = {};
        localStorage.setItem("testID", "test_user1_" + "medicine" + new Date().getTime());
        $scope.testAnswers[localStorage.getItem("testID")] = {};
        $("#clicker_test").hide();
        $('.loader').show();
       

        //limit = this.userObject.sets.MEDICINE;
        //globalUserObject = this.userObject;

        //this.questionArray = globalQuestionObject;


        var medQuestions = _.filter(questionBank, function (item) { return item.qusid.toString().substring(0, 2) == '11' });
        var attemptedQues = [];
        var arr = []
        while (arr.length < 45) {
            var r = Math.floor(Math.random() * 600) + 1;
            var s = r + "";
            while (s.length < 3) s = "0" + s;
            var checkstr = "1100" + s
            if (arr.indexOf(s) === -1 && attemptedQues.indexOf(checkstr) == -1) arr.push("1100" + s);
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

       
        $scope.countDownDate = new Date(moment().add(60, 'minutes'));

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

            document.getElementById("testTimer").innerHTML = minutes + "m " + seconds + "s ";

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
        
        pushPage({ 'id': 'startTheTest.html', 'title': 'Medicine Test' });
    }
    
    $scope.footNav = function(id){
        $('#appCarousel').trigger('to.owl.carousel', parseInt(id))
    }

    
}).config(function ($httpProvider) {
    $httpProvider.defaults.headers.post = {};
    $httpProvider.defaults.headers.post["Content-Type"] = "application/json; charset=utf-8";
})

