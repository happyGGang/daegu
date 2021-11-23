<?xml version="1.0" encoding="utf-8"?>
<%@ page contentType="text/xml;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<response>
    <Contents>
        <c:forEach items="${lendingBookListState}" var="i">
        <ContentDataList>
            <ContentKey>${i.book_code}</ContentKey>
            <UserKey>${i.member_id}</UserKey>
            <ContentTitle>${i.book_name}</ContentTitle>
            <LoanKey>${i.lend_idx}</LoanKey>
            <LoanDate>${i.lend_dt}</LoanDate>
            <ReturnPlanDate>${i.return_due_dt}</ReturnPlanDate>
            <LendingIdx>${i.lend_idx}</LendingIdx>
            <ContentAuthor>${i.author_name}</ContentAuthor>
            <ContentPublisher>${i.book_pubname}</ContentPublisher>
            <ContentPubDate>${i.book_pubdt}</ContentPubDate>
            <OwnerCodeDesc>${i.com_code}</OwnerCodeDesc>
            <OwnerCode>${i.com_code}</OwnerCode>
            <LibraryUserNo>${i.member_id}</LibraryUserNo>
            <LibraryCode>${i.library_code}</LibraryCode>
            <ContentType>${i.type}</ContentType>
            <ContentFileType>${i.format}</ContentFileType>
            <ContentInfo>${fn:escapeXml(i.book_info)}</ContentInfo>
            <ContentCoverUrl>${i.book_image}</ContentCoverUrl>
            <ContentCoverUrlM>${i.book_image}</ContentCoverUrlM>
            <ContentCoverUrlS>${i.book_image}</ContentCoverUrlS>
            <LoanExtendsAvailableYn>${i.loanExtendsAvailableYn}</LoanExtendsAvailableYn>
            <LoanExtendsAbleReason>${i.loanExtendsAbleReason}</LoanExtendsAbleReason>
        </ContentDataList>
        </c:forEach>
        <TotalCount>${TotalCount}</TotalCount>
        <TotalPage>1</TotalPage>
    </Contents>
    <Result>
        <ResultMessage>${ResultMessage}</ResultMessage>
        <ResultCode>${ResultCode}</ResultCode>
    </Result>
</response>