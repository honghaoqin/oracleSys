<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title><ssi:p value="SYS_NAME" /></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- basic styles -->

<link href="${csspath}/assets/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${csspath}/assets/css/font-awesome.min.css" />

<!--[if IE 7]>
		  <link rel="stylesheet" href="${csspath}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

<!-- page specific plugin styles -->

<!-- ace styles -->

<link rel="stylesheet" href="${csspath}/assets/css/ace.min.css" />
<link rel="stylesheet" href="${csspath}/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${csspath}/assets/css/ace-skins.min.css" />

<!--[if lte IE 8]>
		  <link rel="stylesheet" href="${csspath}/assets/css/ace-ie.min.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="${csspath}/assets/js/ace-extra.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
		<script src="${csspath}/assets/js/html5shiv.js"></script>
		<script src="${csspath}/assets/js/respond.min.js"></script>
		<![endif]-->
</head>

<body>
<div class="breadcrumbs" id="breadcrumbs">
	<script type="text/javascript">
	alert();
		try {
			ace.settings.check('breadcrumbs', 'fixed')
		} catch (e) {
		}
	</script>

	<ul class="breadcrumb">
		<li><i class="icon-home home-icon"></i> <a href="#">Home</a></li>

		<li><a href="#">Tables</a></li>
		<li class="active">Simple &amp; Dynamic</li>
	</ul>
	<!-- .breadcrumb -->

	<div class="nav-search" id="nav-search">
		<form class="form-search">
			<span class="input-icon"> <input type="text"
				placeholder="Search ..." class="nav-search-input"
				id="nav-search-input" autocomplete="off" /> <i
				class="icon-search nav-search-icon"></i>
			</span>
		</form>
	</div>
	<!-- #nav-search -->
</div>

<div class="page-content">
	<div class="page-header">
		<h1>
			Tables <small> <i class="icon-double-angle-right"></i> Static
				&amp; Dynamic Tables
			</small>
		</h1>
	</div>
	<!-- /.page-header -->

	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->

			<div class="row">
				<div class="col-xs-12">
					<h3 class="header smaller lighter blue">jQuery dataTables</h3>
					<div class="table-header">Results for "Latest Registered
						Domains"</div>

					<div class="table-responsive">
						<table id="sample-table-2"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th class="center"><label> <input type="checkbox"
											class="ace" /> <span class="lbl"></span>
									</label></th>
									<th>Domain</th>
									<th>Price</th>
									<th class="hidden-480">Clicks</th>

									<th><i class="icon-time bigger-110 hidden-480"></i> Update</th>
									<th class="hidden-480">Status</th>

									<th></th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td class="center"><label> <input type="checkbox"
											class="ace" /> <span class="lbl"></span>
									</label></td>

									<td><a href="#">app.com</a></td>
									<td>$45</td>
									<td class="hidden-480">3,330</td>
									<td>Feb 12</td>

									<td class="hidden-480"><span
										class="label label-sm label-warning">Expiring</span></td>

									<td>
										<div
											class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<a class="blue" href="#"> <i
												class="icon-zoom-in bigger-130"></i>
											</a> <a class="green" href="#"> <i
												class="icon-pencil bigger-130"></i>
											</a> <a class="red" href="#"> <i
												class="icon-trash bigger-130"></i>
											</a>
										</div>

										<div class="visible-xs visible-sm hidden-md hidden-lg">
											<div class="inline position-relative">
												<button class="btn btn-minier btn-yellow dropdown-toggle"
													data-toggle="dropdown">
													<i class="icon-caret-down icon-only bigger-120"></i>
												</button>

												<ul
													class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
													<li><a href="#" class="tooltip-info"
														data-rel="tooltip" title="View"> <span class="blue">
																<i class="icon-zoom-in bigger-120"></i>
														</span>
													</a></li>

													<li><a href="#" class="tooltip-success"
														data-rel="tooltip" title="Edit"> <span class="green">
																<i class="icon-edit bigger-120"></i>
														</span>
													</a></li>

													<li><a href="#" class="tooltip-error"
														data-rel="tooltip" title="Delete"> <span class="red">
																<i class="icon-trash bigger-120"></i>
														</span>
													</a></li>
												</ul>
											</div>
										</div>
									</td>
								</tr>



								<tr>
									<td class="center"><label> <input type="checkbox"
											class="ace" /> <span class="lbl"></span>
									</label></td>

									<td><a href="#">once.com</a></td>
									<td>$20</td>
									<td class="hidden-480">1,400</td>
									<td>Apr 04</td>

									<td class="hidden-480"><span
										class="label label-sm label-info arrowed arrowed-righ">Sold</span>
									</td>

									<td>
										<div
											class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<a class="blue" href="#"> <i
												class="icon-zoom-in bigger-130"></i>
											</a> <a class="green" href="#"> <i
												class="icon-pencil bigger-130"></i>
											</a> <a class="red" href="#"> <i
												class="icon-trash bigger-130"></i>
											</a>
										</div>

										<div class="visible-xs visible-sm hidden-md hidden-lg">
											<div class="inline position-relative">
												<button class="btn btn-minier btn-yellow dropdown-toggle"
													data-toggle="dropdown">
													<i class="icon-caret-down icon-only bigger-120"></i>
												</button>

												<ul
													class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
													<li><a href="#" class="tooltip-info"
														data-rel="tooltip" title="View"> <span class="blue">
																<i class="icon-zoom-in bigger-120"></i>
														</span>
													</a></li>

													<li><a href="#" class="tooltip-success"
														data-rel="tooltip" title="Edit"> <span class="green">
																<i class="icon-edit bigger-120"></i>
														</span>
													</a></li>

													<li><a href="#" class="tooltip-error"
														data-rel="tooltip" title="Delete"> <span class="red">
																<i class="icon-trash bigger-120"></i>
														</span>
													</a></li>
												</ul>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- PAGE CONTENT ENDS -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->
</div>
<!-- /.page-content -->
</body>
</html>
