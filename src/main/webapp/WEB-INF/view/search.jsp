<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventify - Search</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        body {
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        /* Main Content Styles */
        .search-section {
            margin: 30px 0;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .search-header {
            background-color: #005744;
            color: white;
            padding: 20px;
        }
        .search-header h1 {
            margin-bottom: 10px;
            font-size: 24px;
        }
        .search-header p {
            font-size: 16px;
        }
        .search-content {
            padding: 30px;
            background-color: #e6e7e9;
            text-align: center;
        }
        .search-content h2 {
            color: #005744;
            margin-bottom: 20px;
            font-size: 22px;
        }
        .search-content p {
            margin-bottom: 30px;
            color: #333;
        }
        .search-form {
            display: flex;
            max-width: 600px;
            margin: 0 auto 30px;
        }
        .search-btn {
            background-color: #005744;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            padding: 10px 20px;
            font-weight: bold;
            cursor: pointer;
        }
        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            font-size: 16px;
        }
        .search-tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-tab {
            padding: 10px 20px;
            margin: 0 5px;
            background-color: #e0e0e0;
            border-radius: 5px;
            cursor: pointer;
            color: #333;
        }
        .search-tab.active {
            background-color: #005744;
            color: white;
        }
        .search-results {
            margin-top: 30px;
            text-align: left;
        }
        .result-item {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .result-image {
            width: 80px;
            height: 80px;
            border-radius: 5px;
            margin-right: 15px;
            background-color: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .result-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .result-icon {
            font-size: 24px;
            color: #005744;
        }
        .result-details h3 {
            margin-bottom: 5px;
            color: #005744;
        }
        .result-details p {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .result-meta {
            font-size: 12px;
            color: #999;
        }
        .no-results {
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            color: #666;
        }
        .result-count {
            margin-bottom: 15px;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/navbar.jsp" />

<main>
    <div class="container">
        <section class="search-section">
            <div class="search-header">
                <h1>Search</h1>
                <p>Find events, venues, and more.</p>
            </div>
            <div class="search-content">
                <h2>Start Your Search</h2>
                <p>Enter keywords to find what you're looking for.</p>

                <form action="${pageContext.request.contextPath}/search" method="get">
                    <div class="search-form">
                        <input type="text" class="search-input" placeholder="Search..." name="query" value="${searchQuery}">
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>

                    <div class="search-tabs">
                        <label class="search-tab ${searchType == 'all' ? 'active' : ''}">
                            <input type="radio" name="type" value="all" ${searchType == 'all' ? 'checked' : ''} style="display:none;">
                            All
                        </label>
                        <label class="search-tab ${searchType == 'events' ? 'active' : ''}">
                            <input type="radio" name="type" value="events" ${searchType == 'events' ? 'checked' : ''} style="display:none;">
                            Events
                        </label>
                        <label class="search-tab ${searchType == 'venues' ? 'active' : ''}">
                            <input type="radio" name="type" value="venues" ${searchType == 'venues' ? 'checked' : ''} style="display:none;">
                            Venues
                        </label>
                    </div>
                </form>

                <c:if test="${not empty searchQuery}">
                    <div class="search-results">
                        <h3>Search Results for "${searchQuery}"</h3>

                        <c:if test="${not empty totalResults}">
                            <p class="result-count">Found ${totalResults} result(s)</p>
                        </c:if>

                        <c:if test="${empty events and empty venues}">
                            <div class="no-results">
                                <i class="fas fa-search" style="font-size: 24px; margin-bottom: 10px;"></i>
                                <p>No results found for "${searchQuery}"</p>
                                <p>Try using different keywords or filters.</p>
                            </div>
                        </c:if>

                        <!-- Display event results -->
                        <c:if test="${not empty events and (searchType == 'all' or searchType == 'events')}">
                            <c:forEach var="event" items="${events}">
                                <div class="result-item">
                                    <div class="result-image">
                                        <i class="fas fa-calendar-alt result-icon"></i>
                                    </div>
                                    <div class="result-details">
                                        <h3>
                                            <a href="${pageContext.request.contextPath}/event-details?id=${event.id}">
                                                    ${event.name}
                                            </a>
                                        </h3>
                                        <p>${event.description}</p>
                                        <div class="result-meta">
                                            <i class="fas fa-map-marker-alt"></i> ${event.venue}
                                            <i class="fas fa-clock" style="margin-left: 10px;"></i>
                                            <fmt:formatDate value="${event.dateTime}" pattern="MMM dd, yyyy" />
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- Display venue results -->
                        <c:if test="${not empty venues and (searchType == 'all' or searchType == 'venues')}">
                            <c:forEach var="venue" items="${venues}">
                                <div class="result-item">
                                    <div class="result-image">
                                        <i class="fas fa-building result-icon"></i>
                                    </div>
                                    <div class="result-details">
                                        <h3>
                                            <a href="${pageContext.request.contextPath}/venue-details?id=${venue.id}">
                                                    ${venue.name}
                                            </a>
                                        </h3>
                                        <p>${venue.address}, ${venue.city}</p>
                                        <div class="result-meta">
                                            <i class="fas fa-phone"></i> ${venue.contactNumber}
                                            <i class="fas fa-users" style="margin-left: 10px;"></i> Capacity: ${venue.capacity}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/view/footer.jsp" />

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<script>
    // Script to handle tab selection
    document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.search-tab');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs
                tabs.forEach(t => t.classList.remove('active'));

                // Add active class to clicked tab
                this.classList.add('active');

                // Check the associated radio button
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                }

                // Submit the form
                this.closest('form').submit();
            });
        });
    });
</script>
</body>
</html>