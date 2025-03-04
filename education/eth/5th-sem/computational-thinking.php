<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>
 
	<?php include('/nas/jkupfersc/elements/head.php'); ?>
	<link rel="stylesheet" href="/student/jkupfersc/css/course.css" type="text/css" />
	<?php include('/nas/jkupfersc/elements/mathjax.php'); ?>



	<!-- Document Title
	============================================= -->
	<title>Computational Thinking</title>

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
				<h1>Computational Thinking (Python)</h1>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education.php">Education</a></li>
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education/eth.php">ETH</a></li>
					<li class="breadcrumb-item"><a href="/student/jkupfersc/education/eth.php#5th-semester">5th Semester</a></li>
				</ol>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">
			<div class="content-wrap" >
				<div class="container-course clearfix">

					<div id="side-navigation" class="row">

						<aside class="col-md-20 col-lg-20"> 
							<ul class="sidenav position-md-fixed" style="overflow: hidden;">
								<li><a href="#overview"><i class="icon-clipboard-list"></i>Overview<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Algorithms"><i class="icon-star3"></i>Algorithms<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Complexity"><i class="icon-star3"></i>Complexity<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Cryptography"><i class="icon-star3"></i>Cryptography<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Databases"><i class="icon-star3"></i>Databases<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Machine Learning"><i class="icon-star3"></i>Machine Learning<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Neural Networks"><i class="icon-star3"></i>Neural Networks<i class="icon-chevron-right"></i></a></li>
								<li><a href="#Computability"><i class="icon-star3"></i>Computability<i class="icon-chevron-right"></i></a></li>
							</ul>
						</aside>

						<section class="col-md-80 col-lg-80">

							<div id="overview">
								<h3 class="smallmargin" style="text-align:center">Overview</h3>
								<p class="center" style="text-indent: 0">
									<a href="/student/jkupfersc/pdf/education/eth/5th-sem/python_cheat_sheet.pdf" target="_blank">Here is a <u>cheat sheet</u> for python.</a>
								</p>
								<p>
								This course provides a comprehensive overview of the <strong>key topics in computer science</strong>, filling in the knowledge gaps between Information Technology & EE and the Computer Science bachelor's degrees. 
								It is designed to provide students with a comprehensive understanding of the key topics in computer science and to prepare them for advanced studies in various computer science fields.
								This course uses <strong>Python</strong> for code examples.
								The curriculum covers seven critical areas of study including: 
								</p>
								<ol style="margin-left: 3rem;">
									<li>
										<p class="smallmargin"><strong><a href="#Algorithms"> Algorithms:</a></strong> 
										In this section, the fundamental concepts of algorithms are explored, including recursive, greedy, backtracking, dynamic programming, linear programming, linear relaxation, and flow algorithms.
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Complexity"> Complexity Theory:</a></strong> 
										This section covers the complexity topics of P and NP, NP-hard, Boolean Formulas and Circuits, solving hard problems, approximation techniques for vertex cover, bin packing, metric (Travelling Salesman Problem)TSP and knapsack, and the non-approximability of TSP. 
										</p>
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Cryptography"> Cryptography:</a></strong> 
										This section covers various topics including encryption techniques such as perfect encryption, key exchange protocals, public key cryptography, and digital signatures, as well as more specialized topics such as cryptographic hashing, public key infrastructure, and zero-knowledge proofs. 
										It also delves into practical applications like Transport Layer Security, commitment schemes, threshold secret sharing, and multiparty computation.
										</p>
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Databases"> Databases:</a></strong> 
										This section covers concepts related to database management, including dictionaries, hashing. 
										Different types of databases such as key-value databases, relational databases. 
										And modeling techniques in databases like keys, constraints, and joins.
										</p>
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Machine Learning"> Machine Learning:</a></strong> 
										This section covers topics such as linear regression, feature modeling, generalization and overfitting, bias-variance tradeoff, regularization, gradient descent, logistic regression, decision trees, and evaluation.
										</p>
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Neural Networks"> Neural Networks:</a></strong> 
										This section focuses on key topics such as nodes and networks, universal approximation, training of neural networks, practical considerations, regularization, advanced layer design, popular network architectures, and applications in reinforcement learning.
										</p>
									</li> <br>
									<li>
										<p class="smallmargin"><strong><a href="#Computability"> Computability:</a></strong> 
										This section delves into the fundamental concepts of computational theory, including the Halting Problem, the Turing Machine, computing on grids, and the Post Correspondence Problem.
										</p>
									</li> <br>
								</ol>
							</div>

							<div class="min-vh-25"></div>
							<div id="Algorithms">
								<h3 style="text-align:center">1. Algorithms</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560px" height="315px" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB6qCDlcNA0NbZL-zcmB7XVs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>
								<br>
								<p>
									Algorithms are a set of instructions that solve a problem. 
									Algorithm f can be defined as y = f(x), where y is the output and x is the input. 
									There are several algorithms that solve problems in different ways, including Recursion, Greedy, Backtracking, Dynamic Programming, Linear Programming, Linear Relaxation, and Flows.
								</p>
								<h4 class="nomargin">1.1 Recursion (optimal solution but not fast)</h4>
								<p>
									Recursion is a technique in algorithm design where a problem is split into subproblems and the algorithm invokes itself on the subproblems. 
									For example, consider the knapsack problem, where a list of items with values and weights is given, and the goal is to find the maximum value that can be stored in a knapsack with a certain weight capacity. 
									This problem can be solved using a recursive algorithm, as shown below. <br>
									<a href="https://colab.research.google.com/drive/1z-E4ly8dZS-DIJ8oDvk_A-BhWph5JwIs?usp=sharing" target="_blank"><u>All of the codes can be found here! </u></a> <br>
									We define the Items for the knapsack by creating a Item class and adding items to the Items list : <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-definition-in-python.png" width="300px" alt="Knapsack Definition in Python"><br>
									The following is a recursive solution for the knapsack problem with an exponential time complexity $\mathcal{O}(2^n)$, which is unsuitable for large n = amount of items: <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-recursion.png" width="600px" alt="Knapsack Recursion Algorithm">
								</p>
								<h4 class="nomargin">1.2 Greedy (subobtimal solution but fast)</h4>
								<p>
									A greedy algorithm makes locally optimal choices at each step of a problem-solving process in order to arrive at a global solution. 
									The algorithm follows the principle of "making the best choice at the current moment without considering future consequences".
									It is simple and efficient and commonly used in optimization problems, with a time complexity of $\mathcal{O}(n)$ or $\mathcal{O}(n\log(n))$. 
									However, greedy algorithms do not always guarantee optimal solutions.
									The following code shows a greedy solution for the knapsack problem which sorts items by their value-to-weight ratio with a time complexity of $\mathcal{O}(n\log(n))$: <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-greedy-algorithm.png" width="500px" alt="Knapsack Greedy Algorithm"> <br>
								</p>

								<h4 class="nomargin">1.3 Backtracking (optimal solution but not too fast)</h4>
								<p>
									Backtracking is a problem-solving technique that involves constructing a candidate solution incrementally and backtracks when a contradiction is reached, with the aim of finding a valid solution. 
									Efficient backtracking algorithms rely on two key ingredients: look-ahead and pruning. 
									Look-ahead involves ordering the search space such that the most relevant solutions are considered first, while pruning identifies sub-optimal paths early and discards them without explicitly checking.
									The recursion algorithm in 1.1 can be seen as an inefficient backtracking algorithm. <br>
									The following is a more efficient backtracking solution, which sorts items by their value-to-weight ratio and prunes, but still has a time complexity of $\mathcal{O}(2^n)$: <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-backtracking-algorithm.png" width="600px" alt="Knapsack Backtracking Algorithm"> <br>
								</p>

								<h4 class="nomargin">1.4 Dynamic Programming (optimal solution, fast, but uses extra memory)</h4>
								<p>
									Dynamic programming is a technique to reduce the time complexity of an algorithm by utilizing extra memory. 
									It involves dividing a problem into sub-problems that can be optimized independently, with intermediate results stored to avoid duplicate computations. 
									Knapsack problem can be solved using dynamic programming, and a value matrix V is stored where $V\left[ i \right]\left[ c \right]$ is the maximum value that can be achieved with capacity c using only the first i items. 
									The time complexity of the dynamic programming approach is $\mathcal{O}(n \cdot \text{capacity})$, and its space complexity is also $\mathcal{O}(n \cdot \text{capacity})$. 
									There are two approaches to dynamic programming: bottom-up and top-down.  
									Bottom-up dynamic programming algorithms begin computing the entries of the matrix starting with the simple cases, while top-down dynamic programming algorithms implement memoization to avoid duplicate computations by storing intermediate results. <br>
									The following shows a solution using bottom-up dynamic programming with time complexity of $\mathcal{O}(n \cdot \text{capacity})$: <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-bottom-up-dynamic-programming.png" width="700px" alt="Knapsack Bottom-Up Dynamic Programming"> <br>
									The following uses top-down dynamic programming and memorization with time complexity of $\mathcal{O}(\min(2^n,n\cdot \text{capacity}))$: <br>
									<img src="/student/jkupfersc/images/education/eth/5th-sem/knapsack-top-down-dynamic-programming-with-memorization.png" width="550px" alt="Knapsack Top-Down Dynamic Programming with Memorization"> <br>
								</p>

								<h4 class="nomargin">1.5 Linear Programming (when having multiple contraints)</h4>
								<p>
								Linear programming is a method of optimizing a linear function subject to a set of linear constraints. 
								It is a mathematical technique used to determine the best possible outcome from a given set of constraints. 
								The set of feasible points of an LP corresponds to an n-dimensional convex polytope. 
								The simplex algorithm is a popular method used to solve LPs, which starts from a node of the LP polytope and jumps to neighboring nodes having better objectives until the optimal solution is reached. 
								However, the time complexity of the simplex algorithm can be exponential in the size of the input. 
								Other LP algorithms, known as interior point methods, are provably faster. <br>
								The following shows the simplex algorithm alongside the polytope definition: <br>
								<img src="/student/jkupfersc/images/education/eth/5th-sem/linear-programming-polytope.png" width="700px" alt="Linear Programming Polytope Definition"> <br>
								<img src="/student/jkupfersc/images/education/eth/5th-sem/linear-programming-simplex-algorithm.png" width="350px" alt="Linear Programming Simplex Algorithm">
								</p>

								<h4 class="nomargin">1.6 Linear Relaxation (turning ILP into LP problems)</h4>
								<p class="smallmargin">
								Linear relaxation is a common technique used in optimization problems where we replace the integer constraints in an integer linear program (ILP) with relaxed constraints that allow for non-integer values. 
								This results in a linear programming (LP) problem that can be solved using efficient algorithms such as the simplex method. 
								However, the solution obtained from the LP relaxation may not be integer-valued and may need to be rounded to obtain a feasible solution for the original ILP.
								</p>
								<p>
								While there is no guarantee that the solution obtained from the LP relaxation is optimal for the original ILP, 
								there are certain classes of constraint matrices, such as totally unimodular matrices, 
								for which the LP relaxation solution is indeed optimal for the original ILP. 
								Additionally, linear relaxation can be used as a preprocessing step to obtain a good initial solution for other optimization algorithms.
								</p>

								<h4 class="nomargin">1.7 Flows (For Solving Graphs with Nodes and Edges)</h4>
								<p class="smallmargin">
								Flows are algorithmic concepts that are related to linear programming and linear relaxations. 
								Graphs and flows are useful to model transportation networks of goods from source node s to target node t in a company. 
								The formal definition of an s-t flow is a function $f: E → R_{\ge 0}$ such that <br>
								<div class="center">(capacity constraints): $f(u,v) \le  c(u,v)$ for all $(u,v) \in E $ and <br>
								(flow conservation): $\Sigma_{e\in in(u)}f(e)=\Sigma_{e\in out(u)}f(e)$ for all $ u\in V \setminus \left\{s,t\right\}$ </div>
								</p>
								<p>
								The maximum flow that can be established between a source and a target node in a network is the maximum flow problem. 
								The integral flow theorem states that there exists a maximum flow such that every edge has an integral flow. 
								The linear relaxation of the ILP formulation and the simplex algorithm can be used to solve a discrete maximum flow problem. 
								Alternatively, there are more efficient algorithms known as augmenting paths algorithms. 
								The flow f is represented by one variable $x(u,v)$ for every directed edge $(u,v) \in E$ that indicates the value on that edge, 
								and an augmenting path is a path from s to t such that the flow of each edge does not reach its capacity or flow can be pushed back. <br>
								The following shows the Ford Fulkerson algorithm to slove the flow problem: <br>
								<img src="/student/jkupfersc/images/education/eth/5th-sem/max-flow-with-ford-fulkerson.png" width="700px" alt="Max Flow with Ford Fulkerson"> <br>
								</p>

							</div>

							<div class="min-vh-25"></div>

							<div id="Complexity">
								<h3 style="text-align:center">2. Complexity</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB4DfU-bfjd_v9Nc2zACuTWY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>
							</div>

							<div class="min-vh-25"></div>

							<div id="Cryptography">
								<h3 style="text-align:center">3. Cryptography</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB4SojWdYDL7iAao3eLadlvC" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>								
								</div>
							</div>

							<div class="min-vh-25"></div>

							<div id="Databases">
								<h3 style="text-align:center">4. Databases</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB4vrz6GeAjZv6TAeSBwBBeB" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>								
								</div>
							</div>

							<div class="min-vh-25"></div>

							<div id="Machine Learning">
								<h3 style="text-align:center">5. Machine Learning</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB5Zl4GW0-X-iXNrX24ee2XA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>

							<div class="min-vh-25"></div>

							<div id="Neural Networks">
								<h3 style="text-align:center">6. Neural Networks</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB7jnXAKSjNw2UtKjONUPjpb" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>

							<div class="min-vh-25"></div>

							<div id="Computability">
								<h3 style="text-align:center">7. Computability</h3>
								<div class="yt-embedded" style="text-align:center; margin:0 auto">
									<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/videoseries?list=PLVEhhIklNtB6WFD5WVbgd5YHj9zXIsUuG" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>

							<div class="min-vh-25"></div>


						</section>

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