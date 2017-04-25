<%--
  Created by IntelliJ IDEA.
  User: zhaodongchao
  Date: 2017/3/21 21:53
  telphone:17621008632
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>系统主页</title>
  <meta name="description" content="这是我无聊的时候，网上找模版搭的简单系统">
  <meta name="author" content="赵东朝">
  <!--
  Visual Admin Template
  http://www.templatemo.com/preview/templatemo_455_visual_admin
  -->
  <link href="${ctx}/css/open-sans.css" rel='stylesheet' type='text/css'>
  <link href="${ctx}/static/bootstrap/css/font-awesome.min.css" rel="stylesheet">
  <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx}/css/templatemo-style.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <script src="${ctx}/static/bootstrap/js/jquery.min.js"/>
  <script src="${ctx}/static/bootstrap/js/bootstrap.min.js"/>
  <script src="${ctx}/static/js/jquery-migrate-1.2.1.min.js"></script> <!--  jQuery Migrate Plugin -->
  <script src="${ctx}/static/js/templatemo-script.js"></script>      <!-- Templatemo Script -->
</head>
<body>
<!-- Left column -->
<div class="templatemo-flex-row">
  <div class="templatemo-sidebar">
    <header class="templatemo-site-header">
      <div class="square"></div>
      <h1>Visual Admin</h1>
    </header>
    <div class="profile-photo-container">
      <img src="${ctx}/images/profile-photo.jpg" alt="Profile Photo" class="img-responsive">
      <div class="profile-photo-overlay"></div>
    </div>
    <!-- Search box -->
    <form class="templatemo-search-form" role="search">
      <div class="input-group">
        <button type="submit" class="fa fa-search"></button>
        <input type="text" class="form-control" placeholder="Search" name="srch-term" id="srch-term">
      </div>
    </form>
    <div class="mobile-menu-icon">
      <i class="fa fa-bars"></i>
    </div>
    <nav class="templatemo-left-nav">
      <ul>
        <li><a href="#" class="active"><i class="fa fa-home fa-fw"></i>Dashboard</a></li>
        <li><a href="data-visualization.html"><i class="fa fa-bar-chart fa-fw"></i>Charts</a></li>
        <li><a href="data-visualization.html"><i class="fa fa-database fa-fw"></i>Data Visualization</a></li>
        <li><a href="maps.html"><i class="fa fa-map-marker fa-fw"></i>Maps</a></li>
        <li><a href="manage-users.html"><i class="fa fa-users fa-fw"></i>Manage Users</a></li>
        <li><a href="preferences.html"><i class="fa fa-sliders fa-fw"></i>Preferences</a></li>
        <li><a href="#"><i class="fa fa-eject fa-fw"></i>测试</a></li>
      </ul>
    </nav>
  </div>
  <!-- Main content -->
  <div class="templatemo-content col-1 light-gray-bg">
    <div class="templatemo-top-nav-container">
      <div class="row">
        <nav class="templatemo-top-nav col-lg-12 col-md-12">
          <ul class="text-uppercase">
            <li><a href="" class="active">Admin panel</a></li>
            <li><a href="">Dashboard</a></li>
            <li><a href="${ctx}/test.html">TestPlugins</a></li>
            <shiro:hasRole name="admin">
              <li><a href="${ctx}/index/admin">后台管理</a></li>
            </shiro:hasRole>
            <li><a href="${ctx}/login_out">安全退出</a></li>
          </ul>
        </nav>
      </div>
    </div>
    <div class="templatemo-content-container">
      <div class="templatemo-flex-row flex-content-row">
        <div class="templatemo-content-widget white-bg col-2">
          <i class="fa fa-times"></i>
          <div class="square"></div>
          <h2 class="templatemo-inline-block">Visual Admin Template</h2><hr>
          <p>Works on all major browsers. IE 10+. Visual Admin is <a href="http://www.templatemo.com/tag/admin" target="_parent">free responsive admin template</a> for everyone. Feel free to use this template for your backend user interfaces. Please tell your friends about <a href="http://www.templatemo.com" target="_parent">templatemo.com</a> website. You may <a href="http://www.templatemo.com/contact" target="_parent">contact us</a> if you have anything to say.</p>
          <p>Nunc placerat purus eu tincidunt consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus dapibus nulla quis risus auctor, non placerat augue consectetur. Fusce mi lacus, semper sit amet mattis eu.</p>
        </div>
        <div class="templatemo-content-widget white-bg col-1 text-center">
          <i class="fa fa-times"></i>
          <h2 class="text-uppercase">Maris</h2>
          <h3 class="text-uppercase margin-bottom-10">Design Project</h3>
          <img src="${ctx}/images/bicycle.jpg" alt="Bicycle" class="img-circle img-thumbnail">
        </div>
        <div class="templatemo-content-widget white-bg col-1">
          <i class="fa fa-times"></i>
          <h2 class="text-uppercase">Dictum</h2>
          <h3 class="text-uppercase">Sedvel Erat Non</h3><hr>
          <div class="progress">
            <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
          </div>
          <div class="progress">
            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 50%;"></div>
          </div>
          <div class="progress">
            <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
          </div>
        </div>
      </div>
      <div class="templatemo-flex-row flex-content-row">
        <div class="col-1">
          <div class="templatemo-content-widget orange-bg">
            <i class="fa fa-times"></i>
            <div class="media">
              <div class="media-left">
                <a href="#">
                  <img class="media-object img-circle" src="${ctx}/images/sunset.jpg" alt="Sunset">
                </a>
              </div>
              <div class="media-body">
                <h2 class="media-heading text-uppercase">Consectur Fusce Enim</h2>
                <p>Phasellus dapibus nulla quis risus auctor, non placerat augue consectetur.</p>
              </div>
            </div>
          </div>
          <div class="templatemo-content-widget white-bg">
            <i class="fa fa-times"></i>
            <div class="media">
              <div class="media-left">
                <a href="#">
                  <img class="media-object img-circle" src="${ctx}/images/sunset.jpg" alt="Sunset">
                </a>
              </div>
              <div class="media-body">
                <h2 class="media-heading text-uppercase">Consectur Fusce Enim</h2>
                <p>Phasellus dapibus nulla quis risus auctor, non placerat augue consectetur.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-1">
          <div class="panel panel-default templatemo-content-widget white-bg no-padding templatemo-overflow-hidden">
            <i class="fa fa-times"></i>
            <div class="panel-heading templatemo-position-relative"><h2 class="text-uppercase">User Table</h2></div>
            <div class="table-responsive">
              <table class="table table-striped table-bordered">
                <thead>
                <tr>
                  <td>No.</td>
                  <td>First Name</td>
                  <td>Last Name</td>
                  <td>Username</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                  <td>1.</td>
                  <td>John</td>
                  <td>Smith</td>
                  <td>@jS</td>
                </tr>
                <tr>
                  <td>2.</td>
                  <td>Bill</td>
                  <td>Jones</td>
                  <td>@bJ</td>
                </tr>
                <tr>
                  <td>3.</td>
                  <td>Mary</td>
                  <td>James</td>
                  <td>@mJ</td>
                </tr>
                <tr>
                  <td>4.</td>
                  <td>Steve</td>
                  <td>Bride</td>
                  <td>@sB</td>
                </tr>
                <tr>
                  <td>5.</td>
                  <td>Paul</td>
                  <td>Richard</td>
                  <td>@pR</td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div> <!-- Second row ends -->
      <div class="templatemo-flex-row flex-content-row templatemo-overflow-hidden"> <!-- overflow hidden for iPad mini landscape view-->
        <div class="col-1 templatemo-overflow-hidden">
          <div class="templatemo-content-widget white-bg templatemo-overflow-hidden">
            <i class="fa fa-times"></i>
            <div class="templatemo-flex-row flex-content-row">
              <div class="col-1 col-lg-6 col-md-12">
                <h2 class="text-center">Modular<span class="badge">new</span></h2>
                <div id="pie_chart_div" class="templatemo-chart"></div> <!-- Pie chart div -->
              </div>
              <div class="col-1 col-lg-6 col-md-12">
                <h2 class="text-center">Interactive<span class="badge">new</span></h2>
                <div id="bar_chart_div" class="templatemo-chart"></div> <!-- Bar chart div -->
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="text-right">
        <p>Copyright &copy; 2084 Company Name
          | Designed by <a href="http://www.templatemo.com" target="_parent">templatemo</a></p>
      </footer>
    </div>
  </div>
</div>

<!-- JS -->

<script src="${ctx}/static/googlechart/google.chart.js"></script> <!-- Google Chart -->
<script src="${ctx}/static/googlechart/corechart.js"></script> <!-- Google Chart -->
<script>
  /* Google Chart
   -------------------------------------------------------------------*/
  // Load the Visualization API and the piechart package.
 // google.load('visualization', '1.0', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.setOnLoadCallback(drawChart);

  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Topping');
      data.addColumn('number', 'Slices');
      data.addRows([
          ['Mushrooms', 3],
          ['Onions', 1],
          ['Olives', 1],
          ['Zucchini', 1],
          ['Pepperoni', 2]
      ]);

      // Set chart options
      var options = {'title':'How Much Pizza I Ate Last Night'};

      // Instantiate and draw our chart, passing in some options.
      var pieChart = new google.visualization.PieChart(document.getElementById('pie_chart_div'));
      pieChart.draw(data, options);

      var barChart = new google.visualization.BarChart(document.getElementById('bar_chart_div'));
      barChart.draw(data, options);
  }

  $(document).ready(function(){

      $(window).resize(function () {
          drawChart();
      });
      $(window).bind('resize', function (e) {
          if (window.RT) clearTimeout(window.RT);
          window.RT = setTimeout(function () {
              this.location.reload(false);
            /* false to get page from cache */
          }, 200);
      });
  });

</script>


</body>
</html>



