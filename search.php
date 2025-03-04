<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<?php include('/nas/jkupfersc/elements/head.php'); ?>

	<!-- Document Title
	============================================= -->
	<title>Search Results</title>

</head>

<body class="stretched">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<!-- Header
		============================================= -->
		<?php include('/nas/jkupfersc/elements/header.php'); ?>
		<!-- #header end -->

		<!-- Page Title
		============================================= -->
		<section id="page-title">

			<div class="container clearfix">
				<h1>Search Results</h1>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Search</li>
				</ol>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">
			<div class="content-wrap">
				<div class="container clearfix">

					<gcse:searchresults-only></gcse:searchresults-only>

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

	<script>
		(function() {
			var cx = 'd0581c78355ee4745';
			var gcse = document.createElement('script');
			gcse.type = 'text/javascript';
			gcse.async = true;
			gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
				'//www.google.com/cse/cse.js?cx=' + cx;
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(gcse, s);
		})();
	</script>


</body>
</html>