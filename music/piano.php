<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<?php include('/nas/jkupfersc/elements/head.php'); ?>

	<link rel="stylesheet" href="/student/jkupfersc/css/colors.php?color=baa1ff" type="text/css" />
	<link rel="stylesheet" href="/student/jkupfersc/css/piano.css" type="text/css" />


	<!-- Document Title
	============================================= -->
	<title>Piano</title>

	<style>

		#block-portfolio-1 .portfolio-image,
		#block-portfolio-1 .portfolio-image > a {
			transition: all .5s cubic-bezier(0.0, 0.0, 0.58, 1.0);
			transform-origin: center;
		}

		#block-portfolio-1 .portfolio-item:hover .portfolio-image { transform: scale(0.97); }

		#block-portfolio-1 .portfolio-item:hover .portfolio-image > a {
			transform: scale(1.17);
		}

	</style>

</head>

<body class="stretched">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<?php include('/nas/jkupfersc/elements/header-music.php'); ?>
		
		<!-- Content
		============================================= -->
		<section class="dark include-header">
			<div class="min-vh-20" style="background-color: #e6ddff;"></div>
		</section>
		
		<section id="content" >
			<div class="content-wrap" style="background-color: #e6ddff;">
				<div class="container clearfix">

					<div class="row mb-50">
						<div class="col-lg-12">
							<h1 class="font-secondary display-3 fw-bold parallax" data-start="transform: translateY(0px)" data-200-start="transform: translateY(-30px)">Piano - Coming Soon</h1>
									<p align="justify">

									<br><br>
								</p>
						</div>
					</div>

					<h1 id="piano-basic">Basics</h1>
							<div id="block-portfolio-1" class="portfolio row grid-container gutter-40" data-layout="fitRows">


							</div>
					<div class="min-vh-10"></div>

					<h1 id="piano-intermediate">Intermediate Songs</h1>
							<div id="block-portfolio-1" class="portfolio row grid-container gutter-40" data-layout="fitRows">

								

							</div>
					<div class="min-vh-10"></div>

					<div class="min-vh-50"></div>

				</div>
			</div>
		</section><!-- #content end -->

		<?php include('/nas/jkupfersc/elements/footer.php'); ?>
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

	<script>

	</script>

</body>
</html>