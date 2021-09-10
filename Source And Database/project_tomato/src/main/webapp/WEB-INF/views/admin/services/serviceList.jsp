<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle" scope="request" value="Service management"/>
<%@include file="/WEB-INF/views/layout/admin/header.jsp" %>

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Service management</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a >Home</a></li>
                        <li class="breadcrumb-item active">Service management</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-7">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Service List</h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body ">
                        <table class="table table-striped projects">
                            <thead>
                            <tr>
                                <th style="width: 10px">STT</th>
                                <th>Service name</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${list}" var="service" varStatus="itr">
                                <tr>
                                    <td>${offset+itr.index+1}</td>
                                    <td>${service.service_name }
                                        <br>
                                        <c:if test="${service.status ==1}">
                                            <span class="badge badge-success">Show</span>
                                        </c:if>
                                        <c:if test="${service.status ==2}">
                                            <span class="badge badge-danger">Hidden</span>
                                        </c:if>
                                    </td>
                                    <td><fmt:formatDate value="${service.created}" pattern="dd-MM-yyyy" /></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/service/detailService?id=${service.service_id}" class="btn btn-primary btn-sm"><i class="fas fa-folder"> </i></a>
                                        <a href="${pageContext.request.contextPath}/admin/service/editService?id=${service.service_id}" class="btn  btn-info btn-sm"><i class="fas fa-pencil-alt"> </i></a>
                                        <a href="${pageContext.request.contextPath}/admin/service/deleteService?id=${service.service_id}" class="btn  btn-danger btn-sm"><i class="fas fa-trash"> </i> </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <%-- <mytag:PaginatiomnTaglib steps="10" offset="${offset}" count="${count}" uri="/cateController/getAll.htm" next="&raquo;" previous="&laquo;"/> --%>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer clearfix">
                        <ul class="pagination pagination-sm m-0 float-right">
                            <c:if test="${totalPages > 1}">
                                <c:if test="${currentPage>1}">
                                    <li class="page-item"><a class="page-link" href="/admin/service/page/${currentPage-1}">«</a></li>
                                </c:if>
                                <c:forEach  end="${totalPages}" begin="1" varStatus="loop">
                                    <c:if test="${currentPage != loop.index}">
                                        <li class="page-item "><a class="page-link" href="/admin/service/page/${loop.index}">${loop.index}</a></li>
                                    </c:if>
                                    <c:if test="${currentPage == loop.index}">
                                        <li class="page-item active"><a class="page-link" href="/admin/service/page/${loop.index}">${loop.index}</a></li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${currentPage<totalPages}">
                                    <li class="page-item"><a class="page-link" href="/admin/service/page/${currentPage+1}">»</a></li>
                                </c:if>
                            </c:if>
                        </ul>
                    </div>
                </div>
                <!-- /.card -->
            </div>
            <div class="col-md-5">
                <!-- general form elements -->
                <div class="card card-info">
                    <div class="card-header">
                        <h3 class="card-title">Add Service New!</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                <i class="fas fa-minus"></i></button>
                        </div>
                    </div>
                    <div class="card-body" style="display: block;">
                        <!-- /.card-header -->
                        <!-- form start -->
                        <%--@elvariable id="serviceNew" type=""--%>
                        <f:form action="${pageContext.request.contextPath}/admin/service/saveService" method="POST" modelAttribute="serviceNew">
                            <spring:bind path="service_name">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Service name:</label>
                                    <f:input path="service_name" type="text"  class="form-control  ${status.error ?'border border-danger':''} ${param.errorservicename !=null ?'border border-danger':''}" id="exampleInputEmail1"  placeholder="Enter category name..."/>
                                    <f:errors path="service_name" class="text-danger"  ></f:errors>
                                    <p class="text-danger">${param.errorservicename}</p>
                                </div>
                            </spring:bind>
                            <spring:bind path="description">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Service descriptions:</label>
                                    <f:textarea path="description" type="text"  class="form-control  ${status.error ?'border border-danger':''} " id="exampleInputEmail1"  placeholder="Enter descriptions..."/>
                                    <f:errors path="description" class="text-danger"  ></f:errors>
                                </div>
                            </spring:bind>
                            <spring:bind path="status">
                                <div class="form-group">
                                    <label>Status:</label>
                                    <div class="custom-control custom-radio">
                                        <f:radiobutton class="custom-control-input" path="status" value="1" checked="true"  id="customRadio1" />
                                        <label for="customRadio1" class="custom-control-label">Show</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <f:radiobutton class="custom-control-input" path="status" value="2" id="customRadio2" />
                                        <label for="customRadio2" class="custom-control-label">Hidden</label>
                                    </div>
                                    <f:errors path="status" class="text-danger"  ></f:errors>
                                </div>
                            </spring:bind>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-info">Add New</button>
                            </div>
                        </f:form>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/views/layout/admin/footer.jsp" %>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<%@include file="/WEB-INF/views/layout/admin/infoActionc.jsp" %>

</body>
</html>