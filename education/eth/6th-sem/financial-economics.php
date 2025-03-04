<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>
 
	<?php include('/nas/jkupfersc/elements/head.php'); ?>
	<link rel="stylesheet" href="/student/jkupfersc/css/course.css" type="text/css" />

	<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
  <script id="MathJax-script" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.0/es5/tex-mml-chtml.min.js"></script>
	<script>
    MathJax = {
      tex: {inlineMath: [['$', '$'], ['\\(', '\\)']]}
    };
  </script>


	<!-- Document Title
	============================================= -->
	<title>Financial Economics</title>

</head>

<body class="stretched dark">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<!-- Header
		============================================= -->
		<?php include('/nas/jkupfersc/elements/header-study.php'); ?>
		<!-- #header end -->

		<!-- Page Title
		============================================= -->
		<section id="page-title" >
		<!-- style="background-color: #E7FDFF; border-bottom: 1px solid #D3FCFF;" -->
			
			<div class="container clearfix">
				<h1>Financial Economics</h1>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education.php">Education</a></li>
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education/eth.php">ETH</a></li>
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education/eth.php#6th-semester">6th Semester</a></li>
				</ol>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">
			<div class="content-wrap" >
				<div class="container-course clearfix">

					<div id="side-navigation" class="row">

						<div class="col-md-20 col-lg-20"> 
							<ul class="sidenav position-md-fixed" style="overflow: hidden;">
								<li><a href="#overview"><i class="icon-clipboard-list"></i>Overview<i class="icon-chevron-right"></i></a></li>
								<li><a href="#topic1"><i class="icon-star3"></i>Topic1<i class="icon-chevron-right"></i></a></li>
								<li><a href="#topic2"><i class="icon-star3"></i>Topic2<i class="icon-chevron-right"></i></a></li>
								<li><a href="#topic3"><i class="icon-star3"></i>Topic3<i class="icon-chevron-right"></i></a></li>
							</ul>
						</div>

						<div class="col-md-80 col-lg-80">

							<div id="overview">
								<h3>Overview</h3>
								<p>
									Capital Asset Pricing Model (CAPM)

									We need Financial system to allow desynchronization of income and consumption.
									Time (Continues spending vs discrete income)
									Risk (Hedge, Insurance)

									Riskless assets
									Always have risks (risk of default, inflation)
									<br>
									Discounting: <br>
									$p_{0}= \frac{p_{n}}{\prod (1+r_{i})}$
									<br>

									Compounding: <br>
									<br>

									Present Value: <br>
									$PV(r)=\sum_{n=1}^{\infty}\frac{return\:of\:year\:n}{(1+r)^{n}}$
									<br>




								</p>
							</div>

							<div class="min-vh-25"></div>

							<div id="topic1">
								<h3>Topic1</h3>
								text 2
							</div>

							<div class="min-vh-25"></div>

							<div id="topic2">
								<h3>Topic2</h3>
								text 3
							</div>

							<div class="min-vh-25"></div>

							<div id="topic3">
								<h3>Topic3</h3>
								text 4
							</div>

							<div class="min-vh-25"></div>


						</div>

					</div>

				</div>
			</div>
		</section><!-- #content end -->

		<!-- Footer
		============================================= -->
		<?php include('/nas/jkupfersc/elements/footer.php'); ?> 

		<!-- #footer end -->

	</div><!-- #wrapper end -->

	<!-- Go To Top
	============================================= -->
	<div id="gotoTop" class="icon-angle-up"></div>

	<!-- JavaScripts
	============================================= -->
	<?php include('/nas/jkupfersc/elements/js.php'); ?>

	<!-- Footer Scripts
	============================================= -->
	<script src="/student/jkupfersc/js/functions.js"></script>

</body>
</html>