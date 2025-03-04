<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<?php include('elements/head.php'); ?>


	<!-- Document Title
	============================================= -->
	<title>Subjects</title>

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

		<?php include('elements/header-study.php'); ?>
		
		<!-- Content
		============================================= -->
		<section id="content">
			<div class="content-wrap" style="background-color: #ece3da;">
				<div class="container clearfix">

					<div class="row mb-50">
						<div class="col-lg-12">
							<h1 class="font-secondary display-3 fw-bold parallax" style="color:#215CAF;" data-start="transform: translateY(0px)" data-200-start="transform: translateY(-30px)">ETH Zurich</h1>
									<p align="justify">
										ETH Zurich (English: ETH; Swiss Federal Institute of Technology in Zürich; German: Eidgenössische Technische Hochschule Zürich) is a public research university in the city of Zürich, Switzerland. 
										Founded by the Swiss Federal Government in 1854 with the stated mission to educate engineers and scientists, the school focuses primarily on science, technology, engineering, and mathematics. 
										It is part of the Swiss Federal Institutes of Technology Domain, part of the Swiss Federal Department of Economic Affairs, Education and Research. 
										In the 2022 edition of QS World University Rankings, ETH Zurich was ranked 8th in the world, placing it as the fourth-best European university after the University of Oxford, the University of Cambridge and Imperial College London. 
										In the 2021 QS World University Rankings by subject, it ranked 4th in the world for engineering and technology (2nd in Europe) and 1st for earth and marine science. 
										Also, ETH ranked 15th in the world in the Times Higher Education World University Rankings of 2021-22. <br><br>

										ETH Zurich has a world-class reputation in academia and industry. As of 2021 there are 24,500 students from over 120 countries, of which 4,460 are pursuing doctoral degrees. 
										ETH Zurich has a total budget of CHF 1,9 billion per year. <br><br>

										22 Nobel laureates, 2 Fields Medalists, 3 Pritzker Prize winners, and 1 Turing Award winner have been affiliated with the Institute, including Albert Einstein and John von Neumann. 
										It is a founding member of the IDEA League and the International Alliance of Research Universities (IARU), and a member of the CESAER network.
									</p>
						</div>
					</div>

					<div class="row my-5">
						<div class="col-lg-10">
							<div id="block-portfolio-1" class="portfolio row grid-container gutter-40" data-layout="fitRows">

								<!-- Portfolio Item: Start -->
								<article class="portfolio-item col-md-4 col-6 parallax" data-bottom-top="transform: translateY(7%)" data-top-bottom="transform: translateY(-7%)">
									<!-- Grid Inner: Start -->
									<div class="grid-inner">
										<!-- Image: Start -->
										<div class="portfolio-image rounded">
											<a href="#">
												<img src="images/home/eth.jpg" alt="Digital Circuits">
											</a>
											<div class="bg-overlay">
												<div class="bg-overlay-content dark" data-hover-animate="fadeIn">
													<a href="images/home/eth.jpg" class="overlay-trigger-icon bg-light text-dark" data-hover-animate="zoomIn" data-hover-animate-out="zoomOut" data-hover-speed="350" data-lightbox="image" title="Digital Circuits"><i class="icon-line-plus"></i></a>
												</div>
											</div>
										</div>
										<div class="portfolio-desc text-center py-3">
											<h3><a href="#">Digital Circuits</a></h3>
										</div>
										<!-- Image: End -->
									</div>
									<!-- Grid Inner: End -->
								</article>
								<!-- Portfolio Item: End -->

								

							</div>

						</div>
					</div>

					<div class="min-vh-50"></div>

				</div>
			</div>
		</section><!-- #content end -->

		<?php include('elements/footer.php'); ?>
	</div><!-- #wrapper end -->

	<!-- Go To Top
	============================================= -->
	<div id="gotoTop" class="icon-angle-up"></div>

	<!-- JavaScripts
	============================================= -->
	<script src="js/jquery.js"></script>
	<script src="js/plugins.min.js"></script>

	<!-- Footer Scripts
	============================================= -->
	<script src="js/functions.js"></script>

	<script>

	</script>

</body>
</html>