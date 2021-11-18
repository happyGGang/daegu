<?xml version="1.0" encoding="utf-8"?>
<%@ page contentType="text/xml;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<response>
    <Contents>
        <c:forEach var="i" begin="1" end="10">
        <ContentDataList>
            <ContentKey>1</ContentKey>
            <UserKey>2</UserKey>
            <ContentTitle>aa</ContentTitle>
            <LoanKey></LoanKey>
            <LoanDate></LoanDate>
            <ReturnPlanDate></ReturnPlanDate>
            <LendingIdx></LendingIdx>
            <ContentAuthor></ContentAuthor>
            <ContentPublisher></ContentPublisher>
            <ContentPubDate></ContentPubDate>
            <OwnerCodeDesc></OwnerCodeDesc>
            <OwnerCode></OwnerCode>
            <LibraryUserNo></LibraryUserNo>
            <LibraryCode></LibraryCode>
            <ContentType></ContentType>
            <ContentFileType></ContentFileType>
            <ContentInfo></ContentInfo>
            <ContentCoverUrl></ContentCoverUrl>
            <ContentCoverUrlM></ContentCoverUrlM>
            <ContentCoverUrlS></ContentCoverUrlS>
            <LoanExtendsAvailableYn></LoanExtendsAvailableYn>
            <LoanExtendsAbleReason></LoanExtendsAbleReason>
        </ContentDataList>
        </c:forEach>
    </Contents>
    <Result>
        <ResultMessage>OK</ResultMessage>
        <ResultCode>Y</ResultCode>
    </Result>
</response>