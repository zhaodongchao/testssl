$(window).load(function(){

  //### Login Page Panel Animations
  //
  //###############################
  var jsPanelSignUp = $('.js-panel-sign-up');
  var jsPanelSignIn = $('.js-panel-sign-in');

  $('.js-sign-up').on("click",function(){
    if(jsPanelSignUp.hasClass('out')){
      jsPanelSignUp.removeClass('out').addClass('in');
    }
    if(jsPanelSignIn.hasClass('in')){
      jsPanelSignIn.removeClass('in').addClass('out');
    }
  });

  $('.js-back-to-sign-in').on("click",function(e){
    e.preventDefault();
    if(jsPanelSignUp.hasClass('in')){
      jsPanelSignUp.removeClass('in').addClass('out');
    }
    if(jsPanelSignIn.hasClass('out')){
      jsPanelSignIn.removeClass('out').addClass('in');
    }
  });

  //### Form Validate Control
  //
  //###############################
  $('#formLogin').form('submit', {
    onSubmit: function () {
      var jsAlert =  $('.js-alert');
      var isValid = $(this).form('validate');
      if (!isValid) {
        jsAlert.removeClass('alert-hide');
        jsAlert.addClass('alert-show');
        setTimeout(function(){
          $('.js-alert').addClass('alert-hide');
        }.bind(undefined, 10), 3000);

      }else{
        console.log('error');
      }
      return $(this).form('enableValidation').form('validate');
    },

    success: function () {
      console.log('success');
    }
  });

  //### User Profile Dialog
  //
  //###############################
  $('#userProfile').dialog({
    title: 'User Profile',
    width: 360,
    height: 580,
    closed:true,
    cache: true,
    modal: true,
    iconCls: 'fa fa-user'
  });
});

//### Navigation JSON Root
//
//###############################
qc.main.slideMenuUrl = "assets/javascripts/json/sidebarNav/mainMenuTreeData.json";
