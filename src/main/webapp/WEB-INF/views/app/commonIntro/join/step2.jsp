<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {

	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
			$('#memberAgreeForm').submit();
		}
		else {
			<c:if test="${member.langMode ne 'eng'}">
			alert('약관 동의 하지 않았습니다.');
			</c:if>
			<c:if test="${member.langMode eq 'eng'}">
			alert('You must agree to the terms.');
			</c:if>
		}

	});

	$('a#notAgree').on('click', function(e) {
		e.preventDefault();
		alert('회원가입에는 이용약관 및 개인정보 수집·이용 동의가 필요합니다');
		return false;
	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});

	<c:if test="${member.langMode eq 'eng'}">
	$('div.doc-title > h3').text('Membership');
	</c:if>
});
</script>
<c:set var="engMode" value="${member.langMode eq 'eng'}"></c:set>
<c:if test="${engMode}">
<style>
.join-step li { margin: 0% 3%;}
</style>
</c:if>
	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>
		<c:if test="${!engMode}">회원가입 단계</c:if>
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img alt="" src="/resources/common/img/mem_prcs01.png">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Check<br/> member<br/> type</c:if>
					<c:if test="${!engMode}"><span>회원유형확인</span></c:if>
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img alt="" src="/resources/common/img/mem_prcs02_on.png">
				</td>
				<td class="active joinText">
					<c:if test="${engMode}">Consent to <br/>users<br/> agreement</c:if>
					<c:if test="${!engMode}">이용약관동의</c:if>
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img alt="" src="/resources/common/img/mem_prcs03.png">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Identification</c:if>
					<c:if test="${!engMode}">본인확인</c:if>
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img alt="" src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Information<br/> input</c:if>
					<c:if test="${!engMode}">정보입력</c:if>
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
		<ul class="con2">
			<c:if test="${engMode}">
			<li>Member information is integrated and operated through construction of integrated system of public libraries in the Gyeongsangbuk-do Office of Education
			<li>In order to use member services, you must give consent to collection and use of personal information below. </b></li>
			</c:if>
			<c:if test="${!engMode}">
			<li>경상북도교육청 도서관통합정보시스템 구축으로 도서관통합정보시스템 이용 기관(경상북도교육청 소속 공공도서관, 정보센터, 문화원)의 회원정보가 통합 운영됩니다. 따라서, 회원가입시 도서관 통합정보시스템을 이용하는 기관에 동시 가입됩니다.</li>
			<li>회원서비스를 이용하기 위해서는 아래의 <b>이용약관 및 개인정보수집·이용과 제공에 동의</b>하셔야 합니다</b></li>
			</c:if>
		</ul>
	</div>

	<h4>
		<c:if test="${engMode}">
		Guide on integration of public libraries in the Gyeongsangbuk-do Office of Education
		</c:if>
		<c:if test="${!engMode}">
		경상북도교육청 공공도서관 통합안내
		</c:if>
	</h4>

	<p class="txte">
		<c:if test="${engMode}">
		Through construction of integrated information system of libraries in the Gyeongsangbuk-do Office of Education, membership information from 27 institutions affiliated to the Gyeongsangbuk-do Office of Education will be integrated and operated. <br/>
		If you become a member of integrated system, you may use the hompage services and books loan services with a single member information (ID/library card number)
		</c:if>
		<c:if test="${!engMode}">
		통합회원이 되시면 하나의 회원정보로 도서관통합정보시스템 이용 기관(경상북도교육청 소속 공공도서관, 정보센터, 문화원)의  홈페이지 서비스 및 자료대출 서비스 등을 이용할 수 있습니다.
		</c:if>
	<div class="Box">
		<c:if test="${engMode}">
		<ul class="lib-list">
			<c:forEach items="${homepageList}" var="i">
				<c:if test="${i.homepage_id ne 'c0' and i.homepage_id ne 'c1' and i.homepage_id ne 'c1' and i.homepage_id ne 'h1' and i.homepage_id ne 'h30' and i.homepage_id ne 'h32' and i.homepage_id ne 'h29'}">
				<li>${i.homepage_eng_name}</li>
				</c:if>
			</c:forEach>
		</ul>
		</c:if>
		<c:if test="${!engMode}">
		<ul class="lib-list webList">
			
			<li>경상북도교육청 <br class="test"/>문화원</li>
			<li>경상북도교육청 <br class="test"/>영일도서관</li>
			<li>경상북도교육청 <br class="test"/>영덕도서관</li>

			<li>경상북도교육청 <br class="test"/>구미도서관</li>
			<li>경상북도교육청 <br class="test"/>외동도서관</li>
			<li>경상북도교육청 <br class="test"/>청도도서관</li>

			<li>경상북도교육청 <br class="test"/>안동도서관</li>
			<li>경상북도교육청 <br class="test"/>금호도서관</li>
			<li>경상북도교육청 <br class="test"/>고령도서관</li>

			<li>경상북도교육청 <br class="test"/>안동도서관용상분관</li>	
			<li>경상북도교육청 <br class="test"/>점촌도서관</li>
			<li>경상북도교육청 <br class="test"/>성주도서관</li>	

			<li>경상북도교육청 <br class="test"/>안동도서관풍산분관</li>
			<li>경상북도교육청 <br class="test"/>점촌도서관가은분관</li>	
			<li>경상북도교육청 <br class="test"/>칠곡도서관</li>	

			<li>경상북도교육청 <br class="test"/>상주도서관</li>
			<li>경상북도교육청 <br class="test"/>삼국유사군위도서관</li>
			<li>경상북도교육청 <br class="test"/>예천도서관</li>	

			<li>경상북도교육청 <br class="test"/>상주도서관화령분관</li>
			<li>경상북도교육청 <br class="test"/>의성도서관</li>
			<li>경상북도교육청 <br class="test"/>봉화도서관</li>	

			<li>경상북도교육청 <br class="test"/>영주선비도서관</li>	
			<li>경상북도교육청 <br class="test"/>청송도서관</li>
			<li>경상북도교육청 <br class="test"/>울진도서관</li>

			<li>경상북도교육청 <br class="test"/>영주선비도서관풍기분관</li>
			<li>경상북도교육청 <br class="test"/>영양도서관</li>
			<li>경상북도교육청 <br class="test"/>울릉도서관</li>

		</ul>
		
		<ul class="lib-list mobileList">
			
			<li>경상북도교육청<br/>문화원</li><li>경상북도교육청<br/>삼국유사군위도서관</li>
			<li>경상북도교육청<br/>구미도서관</li><li>경상북도교육청<br/>의성도서관</li>
			<li>경상북도교육청<br/>안동도서관</li><li>경상북도교육청<br/>청송도서관</li>
			<li>경상북도교육청<br/>안동도서관용상분관</li><li>경상북도교육청<br/>영양도서관</li>
			<li>경상북도교육청<br/>안동도서관풍산분관</li><li>경상북도교육청<br/>영덕도서관</li>
			<li>경상북도교육청<br/>상주도서관</li><li>경상북도교육청<br/>청도도서관</li>
			<li>경상북도교육청<br/>상주도서관화령분관</li><li>경상북도교육청<br/>고령도서관</li>
			<li>경상북도교육청<br/>영주선비도서관</li><li>경상북도교육청<br/>성주도서관</li>	
			<li>경상북도교육청<br/>영주선비도서관풍기분관</li><li>경상북도교육청<br/>칠곡도서관</li>
			<li>경상북도교육청<br/>영일도서관</li><li>경상북도교육청<br/>예천도서관</li>
			<li>경상북도교육청<br/>외동도서관</li><li>경상북도교육청<br/>봉화도서관</li>
			<li>경상북도교육청<br/>금호도서관</li><li>경상북도교육청<br/>울진도서관</li>
			<li>경상북도교육청<br/>점촌도서관</li><li>경상북도교육청<br/>울릉도서관</li>
			<li>경상북도교육청<br/>점촌도서관가은분관</li>

		</ul>
		</c:if>
	</div>

<form:form modelAttribute="newMember" id="memberAgreeForm" action="step3.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="ageType"/>
<form:hidden path="menu_idx"/>
<form:hidden path="langMode"/>


<c:if test="${engMode}">
	<h4>Consent to Users Agreement </h4>
	<div class="Box" style="height:200px" tabindex="0" >
		<h1 style="font-size:20px; font-weight: bold">Consent to Users Agreement</h1><br>
<font size="2">
<h5>Chapter 1. General Provisions</h5><br>
<h6>Article 1 (Purpose)</h6>
<p>This Users Agreement (the "Agreement") is intended to set forth all the matters including the conditions and procedures of use, rights and obligations for using the library in integrating and operating the member information affiliated to the Gyeongsangbuk-do Office of Education as an integrated information system (the "Integrated System") has been constructed for the libraries of the Gyeongsangbuk-do Office of Education.</p>
<br>
<h6>Article 2 (Effectiveness and Modification)</h6>
<p>2.1 This Agreement is publicly noticed to the users through posting in the service screen or other methods and come into effect when the user consenting thereto joins the service.</p>
<p>2.2 This Agreement may be modified for the reason of enhancement of convenience for the members and revision of applicable laws and regulations such as the Library Act and, in such event, it will be publicly noticed at least 14 days prior to its application through bulletin board of homepage: Provided that any revision which is disadvantageous to the members will be separately noticed through electric means including email and text message of mobile phone.</p>
<p>2.3 Unless the member fails to clearly express its intent to reject to the modification of this Agreement within prior notice period (14 days), such member shall be considered to have consented to such modification. </p>
<p>2.4 Any member not consenting to this Agreement cannot use the services provided by the Library and, if the member continues to use the services after effective date of this Agreement, such member shall be considered to have consented to such modification. </p>
<p>2.5 Any matter which is not set forth herein shall be determined by applicable laws, regulations and customary practices of Republic of Korea including the Library Act, Framework Act on Electric Communication, Electric Communication Business Act, Act on Promotion of Use of Information Communication Network and Information Protection, Regulations on Deliberation of Information Communication Ethics Commission, Code of Ethics for Information Communication, and Program Protection Act. </p>
<br>

<h6>Article 3 (Definitions)</h6>
<p>3.1 As used herein, the following terms shall have the following meanings: </p>
<ul>
<li>3.1.1 "Service" means the Library related service including life-long education, library events and book borrowing.</li>
<li>3.1.2 "Member" means a customer using the Service after entering into an users agreement under this Agreement</li>
<li>3.1.3 "User" means all the users (including non-member) using the Service of Library. </li>
<li>3.1.4 "Post" means text, picture, video clips and various files in a form of information including text messages, voices, sounds,  image and video which are posted in the Service when the Member uses the Service. </li>
<li>3.1.5 "Associate Member" means the Member the application for membership of which has been completed in the homepage. </li>
<li>3.1.6 "Regular Member" means the Member the issuance of library card of which has been completed after visiting the Library and member authentication is completed by digital library system (the "DLS“)</li>
<li>3.1.7 "ID" means a combination of characters (A-Z) and numbers which are given by selection of User for identifying User and using the Service of Library. </li>
<li>3.1.8 "Password" means a sign consisting of characters (A-Z), numbers and special characters which are set up for information protection by the User itself</li>
</ul>
<p>3.2 Any other terms used herein than those as set forth in the foregoing Paragraph 3.1 mean as set forth in applicable laws, regulations and guides by services </p>
<br>

<h5>Chapter 2. Service Use Agreement</h5>
<br>

<h6>Article 4 (Formation of Use Agreement)</h6>
<p>Use agreement is formed when the User consent to the provisions of this Agreement and  provision of personal information and the Library accepts it. </p>
<br>

<h6>Article 5 (Membership)</h6>
<p>5.1 The User may file a membership application after consenting to entry and provision of personal information in a form on the hompage. </p>
<p>5.2 Except for special circumstance, Library will accept membership application filed by User: Provided that, if the case falls under any of the followings, such application may be suspended or rejected:  </p>
<ul>
<li>5.2.1 when such application is not filed under real name of applicant;</li>
<li>5.2.2 when such application is not filed by using the name of others;</li>
<li>5.2.3 when such application has any fraudulent details;</li>
<li>5.2.4 when such application is filed for the purpose of disturbance on the peace, order or good custom of the public; or</li>
<li>5.2.5 when such application fails to satisfy the requirements thereof designated by Library</li>
</ul>
<br>

<h6>Article 6 (Member Rating and Membership Service)</h6>
<p>6.1 Associate Member is a member desiring to use the Service of Library as the User who completed membership application through the homepage of Library and Library accepts it: Provided that, if such member is under 14, the consent of legal representative is required</p>
<p>6.2 Associate Member may use the following services: </p>
<ul>
<li>6.2.1 registration of posts on the homepage; </li>
<li>6.2.2 receipt of life-long education classes;</li>
<li>6.2.3 application for instructor giving talent donation;</li>
<li>6.2.4 application for facility use;</li>
<li>6.2.5 use of electronic information room (digital data room); and</li>
<li>6.2.6 use of other services for Associate Member designated by Library</li>
</ul>
<p>6.3 Regular Member is Associate Member who satisfies the following membership  requirements and shall visit Library and present ID card or documents proving it in order to check such requirements:  </p>
<ul>
<li>6.3.1 Member the resident registration of whom is made in Gyeongsangbuk-do;</li>
<li>6.4.2 Member who has a job (school) located in Gyeongsangbuk-do;</li>
<li>6.3.3 Foreigner member who resides in Gyeongsangbuk-do and has reported its residence and registered as alien in Korea; or</li>
<li>6.3.4 Other member who is considered as necessary by the director of Library </li>
</ul>
<p>6.4 Regular Member may use the following services: </p>
<ul>
<li>6.4.1 services available to Associate Member</li>
<li>6.4.2 issuance of Library card</li>
<li>6.4.3 borrowing data outside of Library</li>
<li>6.4.4 using Digital Library</li>
<li>6.4.5 application for use the locker </li>
<li>6.4.6 other services for Regular Member designated by Library</li>
</ul>
<p>6.5 If any Associate Member is a  DLS  member, such Associate Member will be transferred to Regular Member through DLS authentication at the time of joining membership or correcting member information</p>
<p>6.6 Library may provide some services only to certain Members, may classify the Service by certain scopes and may designate separate hours available for each scope, and members accessible to the Service: Provided that, in such event, the details thereof will be publicly noticed in advance. </p>
<br>

<h6>Article 7 (Obligations of Member)</h6>
<p>7.1 In the event that any change is made in address, workplace, or contact, the Member shall inform to Library (make correction in member information on the homepage) and shall be fully responsible for failure to inform it. </p>
<p>7.2 The User shall understand well and comply with the followings in using Library:  </p>
<ul>
<li>7.2.1  The quietness, order and cleanness of Library shall be kept ; </li>
<li>7.2.2 Smoking shall be prohibited within the building of Library ; </li>
<li>7.2.3 Any act disturbing others including drinking and chat shall be prohibited in reference room and reading room ;  </li>
<li>7.2.4 Any act taking out Library's data outside without authority ; </li>
<li>7.2.5 Any act damaging and destructing the data, fixture and facilities of Library shall be prohibited ; </li>
<li>7.2.6 Any access to the place designated as protected or restricted area shall be prohibited ; and</li>
<li>7.2.7 Any act bringing in dangerous substances shall be prohibited</li>
</ul>
<p>7.3 Library may restrict on the following User's access and the User shall respond thereto: </p>
<ul>
<li>7.3.1Any User aged 4 and under not accompanied by any guardian;</li>
<li>7.3.2 Any User who may disturb the peace within Library ;</li>
<li>7.3.3 Any User having a disease which may be contagious;</li>
<li>7.3.4 Any User who is liable for the loss or damage of Library's data but fails to perform its obligations; </li>
<li>7.3.5 Any User who possesses deadly weapon, explosive and other dangerous article; </li>
<li>7.3.6 Any User who violates rules of Library as set forth in the foregoing Paragraph 7.1 ; or</li>
<li>7.3.7 Any User who may harm efficient operation and safety of Library as designated by Library</li>
</ul>
<p>7.4 Any Member shall not commit any of following acts in joining homepage and using Service: </p>
<ul>
<li>7.4.1 Any act threatening others (including minority)</li>
<li>7.4.2 Any act stealing ID, password, resident registration number of others and disguising as others </li>
<li>7.4.3 Any act damaging reputation of others by stating the fact or fraudulent fact for the purpose of slander of others</li>
<li>7.4.4 Any act distributing fraudulent information for the purpose of giving proprietary profits or harming himself/herself or others </li>
<li>7.4.5 Any act disturbing ordinary life by making the words, text, sounds, image or video which may cause humiliation, hatred feeling or fear reach others</li>
<li>7.4.6 Any profit seeking act by using the Service without prior approval of Library</li>
<li>7.4.7 Any act stealing and using the name of others for use of information communication service</li>
<li>7.4.8 Any act posting unnecessary or unauthorized advertisement or sales promotion materials, inducing, posting or sending by email 'junk mail', spam, chain letters, writing, multi-level marketing    </li>
<li>7.4.9 Any act posting, sending by e-mail any vulgar, obscene data, text, software, music, photos, graphic, video messages (collectively, the "Contents")</li>
<li>7.4.10 Any act posting, sending by e-mail any Contents to which the User has no right</li>
<li>7.4.11 Any act posting, sending by e-mail any software virus in order to destruct, disturb or restrict on the function of computer S/W, H/W, and electric communication equipments</li>
<li>7.4.12Any act collecting or storing Personal Information of other Users including posting, sending by e-mail any data which contains other computer code, file and program</li>
<li>7.4.13 Any act gambling or meandering for money or valuables </li>
<li>7.4.14 Any act distributing information which finds customers for a prostitute or carries obscene act   </li>
<li>7.4.15 Any act which is unlawful or considered as wrongful by Library</li>
</ul>
<p>7.5 The Member shall be responsible for managing its Personal Information including member ID, and password and shall promptly report to Library in case of problems of unauthorized use of ID and password. In addition, Library will not be liable for any damage and loss arising out of the negligence of the Member in managing its ID and password. </p>
<br>

<h6>Article 8 (Disqualification of Membership and Deletion of Member Information)\</h6>
<p>8.1 Library may terminate membership agreement at its own discretion with any Member who fails to comply with the obligations as set forth in Clause 7 hereof (Obligations of Members) and, in such event, such Member may file an objection thereto within 15 days from the date of such termination. </p>
<p>8.2 If the case falls under any of the followings, the Member will be disqualified and its Personal Information will be deleted in accordance with Article 21 of the Personal Information Protection Act and Article 16 of the Enforcement Ordinance of the same Act:</p>
<ul>
<li>8.2.1 when the Member files an withdrawal ( available to select one out of membership withdrawal on the homepage and filing withdrawal by visiting) ;</li>
<li>8.2.2 when the Member does not use the Service of Library for 2 years and more ; or</li>
<li>8.2.3 when the Member fails to give re-consent to collection of Personal Information on the homepage (2 year cycle): Provided that, if the Member uses the Service of Library including borrowing books, such Member shall be considered to have give a re-consent. </li>
</ul>
<p>8.3 However, if the case falls under any of the followings, the application for membership withdrawal is restricted and Personal Information will not be deleted :</p>
<ul>
<li>8.3.1 when any data to be returned to Library is left (Member borrowing data from Library) ;</li>
<li>8.3.2 when the Member lost or damaged a data of Library but fails to compensate thereto ; or</li>
<li>8.3.3 when the director of Library considers that it is necessary to restrict on membership restriction</li>
</ul>
<br>

<h6>Article 9 (Management of Member Information)</h6>
<p>9.1 Any Member Information of Library is stored, managed in the integrated information system of Library in the Gyeongsangbuk-do Information center of Education (the "Information Center") of the Gyeongsangbuk-do Office of Education, a directly affiliated to such Office  disclosed under Article 30 of the Personal Information Protection Act through information handling guidelines. </p>
<p>9.2 Information Center has conducted an integrated construction of, managed any and all the H/W and S/W necessary for the Service of Library and carries out the data back-up in preparation for security service and contingency situations for safe management of Member Information</p>
<br>

<h6>Article 10 (Personal Information Protection Policy)</h6>
<p>10.1 Library uses any information provided by the Member for joining membership for the purpose of performing use agreement and providing the Services as set forth herein </p>
<p>10.2 Library shall not divulge or distribute any Personal Information to a 3rd party without consent of the Member and shall not use it for commercial purpose: Provided that, if required by laws and regulations, Library may provide Personal Information of the Members. </p>
<br>

<h5>Chapter 3. Provision and Use of Service </h5>
<br>

<h6>Article 11 (Use of Service)</h6>
<p>11.1 The hours for online service use shall be all the year round and 24 hours per day without any extraordinary managerial or technical disturbance of Library, in principle. </p>
<p>11.2 The days or hours including closed day and other day as necessary designated by Library including the one for system inspection will be excluded from such hours for use : Provided that the Library shall publicly notice it through homepage in advance. </p>
<br>

<h6>Article 12 (Provision, Modification and Suspension of Service)</h6>
<p>12.1 If any message and other contents stored or transmitted to the homepage of Library is lost, deleted or not transmitted due to emergency, blackout or services beyond the scope of management of homepage, failure of facilities and other force majeure, Library shall be fully discharge from any responsibility therefor. </p>
<p>12.2 In the event that the Service is required to be suspended temporarily due to difficulties in providing ordinary Service on the homepage, Library may suspend the Service by giving one week notice and shall not be responsible for any cases where the Member does not know the details of such notice during the period of suspension. </p>
<p>12.3 Such notice period as set forth in the foregoing Paragraph 12.3 may be reduced or omitted with reasonable reason. In addition, if any details including messages or other communication messages stored or transmitted to the Service is lost, deleted,not transmitted or have communication data loss due to suspension of Service,  Library shall not be responsible for them. </p>
<p>12.4 If Library needs to make permanent suspension of the Service for the reason of its circumstances, the provision of the foregoing Paragraph 12.2 shall apply mutatis mutandis: Provided that the period of prior notice shall be one month. </p>
<p>12.5 Library may temporarily amend, modify or suspend the Service by giving a prior notice and, in such event, Library shall not be responsible for the Member or a 3rd party</p>
<p>12.6 If the Member commits any act breaching this Agreement, Library may temporarily suspend the Service at its own discretion and, in such event, Library may prohibit the Member from accessing to the Service and may delete the entire or part of the contents posted by the Member. </p>
<br>

<h6>Article 13 (Provision of Information and Posting of Advertisement)</h6>
<p>Library may provide the Members with various information including promotional materials and users guides for the Service of Library through e-mail or text messages: Provided that, any Member desiring not to receive such information may reject to receive such information. </p>
<br>

<h6>Article 14 (Management of Posting)</h6>
<p>14.1 Library may not delete or alter any posting made by the Member on the homepage, in principle: Provided that, if the case falls under any of the followings, Library may delete and alter it without giving a prior notice and shall not be responsible therefor: </p>
<ul>
<li>14.1.1 when the content of such posting slanders or damages reputation of a 3rd party ;</li>
<li>14.1.2 when the content of such posting contains details violating public order or good morals;</li>
<li>14.1.3 when the content of such posting is considered to be engaged in a crime;</li>
<li>14.1.4 when the content of such posting infringes on the rights of a 3rd party including copyright ;</li>
<li>14.1.5 when the content of such posting does not suitable to the nature of the Service; or</li>
<li>14.1.6 when the content of such posting is not compatible to applicable laws and regulations</li>
</ul>
<p>14.2 If necessary for edition, transfer, or deletion of any posting on the homepage or when any posting is considered to have lost its effect as a posting due to lapse of certain period of time, Library may delete or alter such posting by giving one week notice. </p>
<br>

<h6>Article 15 (Copyright to Posting)</h6>
<p>15.1 The copyright to any posting posted by the Member on the homepage shall be owned by such Member and Library may use such posting for the public purpose such as promotion and education of the Service of Library. </p>
<p>15.2 The Member shall be fully responsible , civil or criminal , for any claim arising from infringement on the copyrights of others</p>
<p>15.3 The Member shall not use any data posted in the Service for commercial purposes including processing and sales of the information acquired from using the Service. </p>
<br>

<h6>Article 16 (Ownership of Library)</h6>
<p>16.1 Library shall own any and all the intellectual property right and other right to and over the Service provided on the homepage of Library, S/W, image, mark, logo, design, service name, information and trademark  necessary for the Service. </p>
<p>16.2 Unless otherwise expressly approved by Library, the Member shall not amend, lease, loan, sell, distribute, manufacture, transfer, re-license, establish a security or use for commercial use the entire or part of each property as set forth in the foregoing Paragraph 16.1 and shall not allow a 3rd party to make such acts. </p>
<br>

<h5>Chapter 4. Miscellaneous</h5>
<br>

<h6>Article 17 (Fee and Information At Cost)</h6>
<p>The use of Service of Library is free of charge, in principle and the Service to be provided at cost will be noticed in advance. </p>
<br>

<h6>Article 18 (No Assignment)</h6>
<p>The Member shall not assign, transfer or provide as security its right to use the Service of Library or its other status under use agreement to others </p>
<br>

<h6>Article 19 (Damage)</h6>
<p>Library shall not be responsible or liable for any damage incurred by the Member regarding the Services provided free of charge to the Member except for the cases where such damage arises out of gross negligence of Library. </p>
<br>

<h6>Article 20 (Damage Compensation)</h6>
<p>20.1 Library shall be discharged from its responsibility for providing the Service when the Service cannot be provided for the reason of force majeure including act of God, war and other equivalent incidents</p>
<p>20.2 Library shall not be liable for the damage arising out of suspension or failure to provide ordinarily the internet service by the service provider supplying communication line</p>
<p>20.3 Library shall not be liable for the damage arising out of inevitable causes including repair, replacement, regular inspection or construction of equipments for the Service of Library. </p>
<p>20.4Library shall not be liable for the damage arising out of error of User's computer or deficient entry of personal information and e-mail address by the Member</p>
<p>20.5 Library is not obliged to confirm or represent any opinion or information expressed in the Service and does not approve, oppose or amend such opinion  expressed by the Member or a 3rd party. In any case, Library shall not be liable for any profit or damage incurred by the User from reliance on the information contained in the Service. </p>
<p>20.6 Library shall not be responsible for anything related to deal of goods or monetary deal between the Members or Member and a 3rd party intermediated by the Service and shall not be responsible for any expected profits of the Member regarding to th use of the Service. </p>
<p>20.7 Library shall not be liable for any profits expected by the Member or damage incurred from the data acquired through the Service and shall not be responsible for the credibility of the information, data and facts posted by the Member in the Service. </p>
<p>20.8 Library shall not be liable for the damage incurred by the Member arising out of willful misconduct or negligence of the Member regarding the use of the Service. </p>
<p>20.9 Library does not guarantee the accuracy, completeness and quality of the contents of the services provided by members or other agencies other than the Service of Library. Thus, Library shall not be liable for any type of loss or damage incurred from using such contents by the User. Moreover, Library shall not be liable for compensating the emotional damage incurred by the User from other Users arising out of its use of the Service. </p>
<br>

<h6>Article 21 (Jurisdiction)</h6>
<p>21.1 Any dispute between Library and the User arising out or in connection with the use of Service arises, Library will make its best efforts in resolving such dispute. </p>
<p>21.2 Any suit is filed regarding the use of Service, such suite shall be referred to the courts having jurisdiction over the place where the Gyeongsangbuk-do Office of Education is located. </p>
<br>

<p><strong>&lt;Addenda&gt;</strong><br>
(Execution date)This Agreement shall be applied from Jan. 1, 2017</p>
</font>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			  <input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1" style="opacity: inherit;"><label style="position: static !important;" for="agree_codes1">Consent to Users Agreement</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

	<h4>Consent to Collection and Use of Personal Information</h4>
	<div class="Box" style="height:200px" tabindex="0" >
		<h1 style="font-size:20px; font-weight: bold">Consent to Collection and Use of Personal Information</h1><br>
<font size="2">
<h5>1. Purpose of collection and use of Personal Information</h5>
<br>
<p>A. Any Personal Information is collected or used for the following purposes so that the Users can use the Service provided by the integrated information system of the Library of the Gyeongsangbuk-do Office of Education </p>
  <ul>
    <li>1) Homepage service : Lending and managing of data, application for taking life-long education classes, registration of posting, enhancement of promotion and education  of Library.</li>
    <li>2) Data lending service:  Present condition of data use, reservation, application and borrowing of data, and use of digital library. </li>
  </ul>
<p>B. Any collected Personal Information will not be used for other purposes and, if the purpose of use is changed, the Library will take necessary measures including obtaining a separate consent from the Users as prescribed in Article 18 of the Personal Information Protection Act. </p>
<br>

<h5>2. Items of Personal Information to be collected </h5><br>
<table style="boder:1; margin:auto; text-align:center;">
<tbody><tr style="background:#BDBDBD;" class="first">
  <td style="width:15%;" class="first td1">Service items</td>
  <td style="width:35%;" class="td2">Required items</td>
  <td style="width:35%;" class="td3">Optional items</td>
  <td style="width:15%;" class="last td4">Note</td>
</tr>
<tr>
<td class="first td1">Homepage service</td>
<td class="td2">ID, Password, Name, Birthdate, Sex, Address, Mobile phone No. (Tel.) </td>
<td class="last td3">home phone No., Office (Name of company, contact, address), Name and contact of legal representative (if necessary)</td>
</tr>
<tr>
<td class="first td1">Book lending service</td>
<td class="td2">ID, Password, Name, Birthdate, Sex, Address, Mobile phone No. (Tel.)</td>
<td class="td3">home phone No., Office (Name of company, contact, address), Name and contact of legal representative (if necessary)</td>
<td class="last td4">Necessary for visiging Library</td>
</tr>
</tbody></table>
<br>
<h5>3. Period for retention and use of Personal Information</h5><br>
<table style="boder:1; margin:auto; text-align:center;">
<tbody><tr style="background:#BDBDBD;" class="first">
  <td style="width:20%;" class="first td1">Service item</td>
  <td style="width:30%;" class="td2">Retention period</td>
  <td style="width:30%;" class="td3">Use period</td>
  <td style="width:20%;" class="last td4">Note</td>
</tr>
<tr>
<td class="first td1">Homepage service</td>
<td class="td2">2 years (until membership withdrawal)</td>
<td class="td3">2 years (until membership withdrawal)</td>
<td class="last td4">re-consent (2-year cycle)</td>
</tr>
<tr>
<td class="first td1">Book lending service</td>
<td class="td2">2 years (until membership withdrawal)</td>
<td class="td3">2 years (until membership withdrawal)</td>
<td class="last td4">Apply Clause 8 of use agreement first</td>
</tr>
</tbody></table><br>

<h5>4. Disadvantage in case of rejection to give consent</h5>
<p>The User may not consent to collection and use of its Personal Information: Provided that, if any User reject to give such consent to provision of required items, such User cannot become a member of Library and some Services may be restricted. </p>
</font>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2" style="opacity: inherit;"><label style="position: static !important;" for="agree_codes2">Consent to Collection and Use of Personal Information</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
</c:if>
<c:if test="${!engMode}">

	<h4>이용약관 동의</h4>
	<div class="Box" style="height:200px" tabindex="0" >
		<!-- <h1 style="font-size:20px; font-weight: bold">이용약관 동의</h1><br> -->
<font size="2">
<!-- <h5>제1장 총칙</h5><br>
<h6>제1조 목적</h6>
<p> 본 약관은 「경상북도교육청 도서관 통합정보시스템 구축」(이하 ‘통합시스템’이라 함)에 따라 경상북도교육청 소속 도서관 회원정보를 통합 운영함에 있어 이용자와 도서관간의 이용조건 및 절차, 이용에 관한 권리와 의무 등 제반 사항을 규정함을 목적으로 합니다.</p>
<br>
<h6>제2조 (이용약관의 효력 및 변경)</h6>
<p>① 본 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공시되며, 이를 동의한 이용자가 서비스에 가입함으로써 효력이 발생합니다.</p>
<p>② 본 약관은 회원의 이용 편리성 증진, 도서관법 등 관련 법령 개정 등으로 약관이 변경될 수 있으며, 변경 시 홈페이지 공지사항을 통해 적용 14일 전부터 공지합니다. 다만, 회원에게 불리한 약관의 개정은 전자우편, 휴대폰문자 등의 전자적 수단을 통해 별도로 통지하도록 합니다.</p>
<p>③ 약관 변경에 대한 사전공지 기간(14일)내에 명시적으로 거부 의사를 표시하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.</p>
<p>④ 본 약관에 동의하지 않는 회원은 도서관에서 제공하는 서비스를 이용할 수 없으며, 개정된 약관의 효력발생일 이후의 계속적인 서비스 이용은 변경사항에 동의한 것으로 간주합니다.</p>
<p>⑤ 이 약관에 명시되지 않은 사항에 대해서는 도서관법, 전기통신기본법, 전기 통신사업법, 정보통신망이용촉진및정보보호등에관한법률, 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 프로그램 보호법 등 기타 대한민국의 관련법령과 상관습에 의합니다.</p>
<br>

<h6>제3조 (용어의 정의)</h6>
<p>①  본 약관에서 사용하는 용어의 정의는 다음과 같습니다. </p>
<ul>
<li>   1. “서비스”라 함은 “회원”이 이용할 수 있는 평생학습, 독서행사 및 도서대출 등 도서관 관련 서비스를 위미합니다.</li>
<li>   2. “회원”이라 함은 도서관 이용약관에 따라 이용계약을 체결하고, 서비스를 이용하는 고객을 말합니다.</li>
<li>   3. “이용자”라 함은 도서관 서비스를 이용하는 모든 사용자(비회원 포함)를 말합니다.</li>
<li>   4. “게시물”이라 함은 회원이 서비스를 이용함에 있어 서비스상에 게시한 문자, 음성, 음향, 화상, 동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일 등을 의미합니다.</li>
<li>   5. “준회원”이라 함은 홈페이지에서 회원 가입신청이 완료된 회원을 의미합니다.</li>
<li>   6. “정회원”이라 함은 준회원이 도서관에 방문하여 회원증 발급이 완료된 회원 및 독서교육종합지원시스템(이하 ‘DLS’라 함)의 회원 인증이 완료된 회원을 의미합니다.</li>
<li>   7. “아이디(ID)”라 함은 이용자 식별과 도서관 서비스 이용을 위하여 이용자의 선택에 의하여 부여되는 영문자와 숫자의 조합을 위미합니다.</li>
<li>   8. “비밀번호(PW)”라 함은 이용자가 자신이 정보 보호를 위해 설정한 영문자와 숫자, 특수문자 등으로 조합된 부호</li>
</ul>
<p>② 본 약관에서 사용하는 용의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스별 안내에서 정하는 바에 의합니다.</p>
<br>

<h5>제 2 장 서비스 이용계약</h5>
<br>

<h6>제4조 (이용계약의 성립)</h6>
<p>이용계약은 이용자가 약관내용 및 개인정보 제공에 대한 동의와 이용자의 이용신청에 대한 도서관의 승낙으로 성립합니다.</p>
<br>

<h6>제5조 (회원 가입)</h6>
<p>① 이용자는 홈페이지를 통해 회원가입신청 양식에 개인의 정보 입력 및 정보 제공을 동의한 후 회원가입을 신청할 수 있습니다.</p>
<p>② 도서관은 이용자가 회원가입 신청을 하였을 경우 특별한 사정이 없는 한 이를 승낙합니다. 단, 다음의 경우 그 신청이 유보 또는 거절될 수 있습니다.</p>
<ul>
<li>   1. 본인의 실명으로 신청하지 않았을 경우</li>
<li>   2. 다름 사람의 명의를 사용하여 신청하였을 경우</li>
<li>   3. 신청서의 내용을 허위로 기재하였을 경우</li>
<li>   4. 사회의 안녕, 질서 또는 미풍양속을 저해할 목적으로 신청하였을 경우</li>
<li>   5. 기타 도서관이 정한 신청 요건이 미비 되었을 경우</li>
</ul>
<br>

<h6>제6조 (회원 등급 및 회원 서비스)</h6>
<p>① 준회원은 도서관 서비스를 이용하고자 하는 이용자가 도서관 홈페이지를 통해 회원가입 신청을 완료하여 도서관이 이를 승낙한 상태의 회원입니다. 단 만 14세 미만인 경우 법정대리인의 동의를 구하여야 합니다.</p>
<p>② 준회원은 다음과 같은 서비스를 이용할 수 있습니다.</p>
<ul>
<li>   1. 홈페이지 게시물 등록 </li>
<li>   2. 평생교육 강좌 수강</li>
<li>   3. 재능기부 강사 신청</li>
<li>   4. 시설 이용 신청</li>
<li>   5. 전자정보실(디지털자료실) 이용</li>
<li>   6. 기타 도서관이 정하는 준회원 서비스</li>
</ul>
<p>③ 정회원은 다음의 가입 조건을 갖춘 준회원으로, 도서관에 방문하여 가입 조건을 확인할 수 있는 신분증 또는 증빙서류를 제시하여야 합니다.</p>
<ul>
<li>   1. 경상북도에 주민등록이 되어있는 회원</li>
<li>   2. 경상북도 소재 직장(학교)에 재직(재학)중인 회원</li>
<li>   3. 경상북도에 거주하는 재외동포 국내거소 신고 및 외국인 등록된 회원</li>
<li>   4. 그 밖에 도서관장이 필요하다고 인정하는 회원</li>
</ul>
<p>④ 정회원은 다음과 같은 서비스를 이용할 수 있습니다.</p>
<ul>
<li>   1. 준회원이 이용할 수 있는 서비스</li>
<li>   2. 도서관 회원증 발급</li>
<li>   3. 자료 관외 대출</li>
<li>   4. 전자도서관 이용</li>
<li>   5. 사물함 신청   </li>
<li>   6. 기타 도서관이 정하는 정회원 서비스</li>
</ul>
<p>⑤ 준회원 중 DLS 회원인 경우 회원가입 시 혹은 회원정보수정에서 DLS 인증을 통해 정회원으로 전환 됩니다.</p>
<p>⑥ 도서관은 일부 서비스에 대해 특정회원에게만 제공할 수도 있으며, 서비스를 일정범위로 분할하여 각 범위별 이용 가능 시간, 이용 가능 회원 등을 별도로 정할 수 있습니다. 단, 이럴 경우 그 내용을 사전에 공지하겠습니다</p>
<br>

<h6>제7조 (회원의 준수사항)</h6>
<p>① 회원은 주소, 근무지, 연락처 등의 변동이 있을 경우 도서관에 통보(홈페이지 회원정보수정)하여야 하며, 통보하지 않음으로 발생되는 모든 책임은 회원에게 있습니다.</p>
<p>② 이용자는 도서관 이용에 있어 다음의 사항을 숙지하고 준수하여야 합니다.</p>
<ul>
<li>   1. 관내 정숙 및 질서, 청결 유지</li>
<li>   2. 도서관 건물 전체 금연</li>
<li>   3. 자료실 및 열람실 내에서는 음주, 잡담 등 타인에게 방해가 되는 행위 금지</li>
<li>   4. 자료의 무단 외부 반출 금지</li>
<li>   5. 도서관 자료, 비품 등 시설에 파손 및 훼손 금지</li>
<li>   6. 보호 및 제한 구역으로 설정된 장소의 출입 금지</li>
<li>   7. 위험물 반입 금지</li>
</ul>
<p>③ 도서관은 다음의 이용자에 대해 출입을 통제 할 수 있으며, 이용자는 이에 응하여야 합니다.</p>
<ul>
<li>   1. 보호자를 대동하지 않은 5세 미만의 이용자</li>
<li>   2. 주취자 또는 관내의 질서를 해할 우려가 있는 이용자</li>
<li>   3. 전염의 우려가 있는 질병에 걸린 이용자</li>
<li>   4. 도서관 자료의 분실 혹은 훼손 등으로 변상의 의무가 있는 자로서, 그 의무를 이행하지 않은 이용자</li>
<li>   5. 흉기나 폭발물, 기타 위험물을 소지한 이용자</li>
<li>   6. 제1항의 도서관 준수사항을 위반한 이용자</li>
<li>   7. 기타 도서관장이 정한 도서관의 효율적 운영 및 안전을 해할 수 있는 이용자</li>
</ul>
<p>④ 회원은 홈페이지 가입 및 서비스 이용에 있어 다음과 같은 행위를 하지 않아야 합니다.</p>
<ul>
<li>   1. 타인(소수를 포함)에게 위해를 가하는 행위</li>
<li>   2. 타인의 ID, PASSWORD, 주민등록번호 도용 및 타인으로 가장하는 행위</li>
<li>   3. 타인을 비방할 목적으로 사실 또는 허위의 사실을 명시하여 명예를 훼손하는 행위</li>
<li>   4. 본인 또는 타인에게 재산상의 이익을 주거나 타인에게 손해를 가할 목적으로 허위의 정보를 유통시키는 행위</li>
<li>   5. 수치심이나 혐오감 또는 공포심을 일으키는 말이나 글, 음향, 화상 또는 영상을 상대방에게 도달하게 하여 일상적 생활을 방해하는 행위</li>
<li>   6. 도서관의 사전 승낙 없이 서비스를 이용한 영리행위</li>
<li>   7. 타인의 정보통신서비스 이용명의를 도용하여 사용하는 행위</li>
<li>   8. 불필요하거나 승인되지 않은 광고, 판촉물을 게재하거나, "정크 메일(junk mail)", "스팸(spam)", "행운의 편지(chain letters)", "도배글", "피라미드 조직" 등을 권유하거나 게시, 게재 또는 전자우편으로 보내는 행위</li>
<li>   9. 저속 또는 음란한 데이터, 텍스트, 소프트웨어, 음악, 사진, 그래픽, 비디오 메시지 등(이하 ""콘텐츠"")을 게시, 게재 또는 전자 우편으로 보내는 행위</li>
<li>  10. 권리(지적재산권을 포함한 모든 권리)가 없는 콘텐츠를 게시, 게재 또는 전자우편으로 보내는 행위</li>
<li>  11. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비를 파괴, 방해 또는 기능을 제한하기 위한 소프트웨어 바이러스를 게시, 게재 또는 전자우편으로 보내는 행위</li>
<li>  12. 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시, 게재, 전자우편으로 보내는 행위 등 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
<li>  13. 재물을 걸고 도박하거나 사행행위를 하는 행위</li>
<li>  14. 윤락행위를 알선하거나 음행을 매개하는 내용의 정보를 유통시키는 행위</li>
<li>  15. 기타 불법적이거나 도서관에서 부당하다고 판단되는 행위</li>
</ul>
<p>⑤ 회원은 회원ID, 비밀번호 등 개인정보 관리에 대한 책임이 있으며, 본인의 승인 없이 아이디, 비밀번호가 사용되는 문제가 발생하면 즉시 도서관에 신고하여야 합니다. 또한 회원의 관리 과실로 인해 발생한 손해 및 손실은 도서관에서 책임지지 않습니다. </p>
<br>

<h6>제8조 (회원 자격 상실 및 회원정보 삭제)</h6>
<p>① 도서관은 제7조(회원의 준수사항)를 준수하지 않는 회원에 대해 회원 계약을 일방적으로 해지할 수 있습니다. 회원은 해지일로부터 15일 이내에 이에 대한 이의 신청을 할 수 있습니다.</p>
<p>② 회원은 개인정보보호법 제21조 및 동법 시행령 제16조에 의거하여 다음의 경우 회원 자격을 상실하며, 개인정보는 삭제됩니다.</p>
<ul>
<li>   1. 회원의 탈퇴 신청 시(홈페이지 회원탈퇴, 방문 탈퇴 신청 중 선택 가능)</li>
<li>   2. 2년 동안 도서관 서비스를 이용하지 않은 경우</li>
<li>   3. 홈페이지 개인정보 수집 재 동의를 하지 않은 경우(2년 주기). 단, 도서 대출 등 도서관 서비스를 이용하는 경우 재 동의를 한 것으로 간주 합니다.</li>
</ul>
<p>③ 단, 다음의 경우 회원 탈퇴 신청이 제한되며, 개인정보 또한 삭제되지 않습니다.</p>
<ul>
<li>   1. 도서관으로 반납할 자료가 있는 경우(자료 대출 중인 회원)</li>
<li>   2. 대출 자료를 분실 혹은 훼손하고 변상하지 않은 경우</li>
<li>   3. 기타 회원탈퇴 제한이 필요하다고 도서관장이 인정하는 경우</li>
</ul>
<br>

<h6>제9조 (회원 정보 관리)</h6>
<p>① 도서관의 회원 정보는 경상북도교육청 직속기관인 경상북도교육청정보센터(이하 ‘정보센터’라 함)의 도서관 통합정보시스템에 저장·관리되며, 개인정보보호법 제30조에 의거하여 개인정보처리방침을 통해 공개하고 있습니다.</p>
<p>② 정보센터는 도서관 서비스에 필요한 일체의 하드웨어 및 소프트웨어를 통합 구축하여 관리하고 있으며, 회원정보의 안전한 관리를 위한 보안서비스, 만일의 사태를 대비한 데이터 백업 등을 수행하고 있습니다.</p>
<br>

<h6>제10조 (개인정보보호 정책)</h6>
<p>① 도서관은 회원 가입시 제공받은 정보는 이용계약의 이행과 본 이용약관상의 서비스 제공을 위해 이용합니다.</p>
<p>② 도서관은 회원의 승낙 없이 제3자에게 개인정보를 누설 또는 배포할 수 없으며, 상업적 목적으로 사용할 수 없습니다. 다만, 법령에 근거하여 요구가 있는 경우 회원의 개인정보를 제공할 수 있습니다.</p>
<br>

<h5>제3장 서비스 제공 및 이용</h5>
<br>

<h6>제11조 (서비스 이용)</h6>
<p>① 온라인 서비스 이용시간은 도서관의 업무상 또는 기술상 특별한 지장이 없는 한 연중 무휴, 1일 24시간을 원칙으로 합니다.</p>
<p>② 제1항의 이용시간 중 휴관일, 시스템점검 등의 업무상 필요로 인하여 도서관이 정한 날 또는 시간은 예외로 합니다. 단, 도서관은 이를 사전에 홈페이지를 통해 공지하도록 하겠습니다.</p>
<br>

<h6>제12조 (서비스 제공, 변경, 중지)</h6>
<p>① 회원은 홈페이지에 보관되거나 전송된 메시지 및 기타 내용이 국가의 비상사태, 정전, 홈페이지 관리범위 외의 서비스, 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실에 대해 도서관은 아무런 책임을 지지 않습니다.</p>
<p>② 홈페이지의 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야할 경우 서비스 중지 1주일 전에 고지 후 서비스를 중지할 수 있으며, 이 기간 동안 회원이 고지내용을 인지하지 못한 경우 도서관은 책임을 부담하지 않습니다.</p>
<p>③ 상당한 이유가 있을 시 위 사전 고지기간은 감축되거나 생략될 수 있습니다. 또한 서비스 중지로 인하여 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 도서관은 책임을 부담하지 않습니다.</p>
<p>④ 도서관의 사정으로 서비스를 영구적으로 중단하여야 할 경우 제2항을 준용합니다. 다만, 사전 공지기간은 1개월로 하겠습니다.</p>
<p>⑤ 도서관은 사전 고지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 회원 또는 제3자에게 어떠한 책임도 부담하지 않습니다.</p>
<p>⑥ 회원이 이 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 중지할 수 있습니다. 이 경우 도서관은 회원의 접속을 금할 수 있으며, 회원이 게시한 내용의 전부 또는 일부를 임의로 삭제할 수 있습니다.</p>
<br>

<h6>제13조 (정보의 제공 및 광고의 게재)</h6>
<p>도서관은 회원에게 도서관 서비스 홍보 및 이용 안내 등 다양한 정보를 전자우편, 문자메시지 등의 방법으로 회원에게 제공 할 수 있습니다. 단, 이를 원치 않는 회원은 수신을 거부 할 수 있습니다.</p>
<br>

<h6>제14조 (게시물 관리)</h6>
<p>① 도서관은 회원의 홈페이지 게시물을 원칙적으로 삭제하거나 변경 할 수 없습니다. 단, 다음의 경우 사전 통지 없이 삭제 및 변경 될 수 있으며, 이에 대해 어떠한 책임도지지 않습니다. </p>
<ul>
<li>   1. 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용일 경우</li>
<li>   2. 공공질서 및 미풍약속에 위반되는 내용일 경우</li>
<li>   3. 범죄적 행위에 결부된다고 인정되는 내용일 경우</li>
<li>   4. 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
<li>   5. 서비스 성격에 부합하지 않는 정보의 경우</li>
<li>   6. 기타 관계 법령 및 규정 등에 위배되는 경우</li>
</ul>
<p>② 도서관은 홈페이지 게시물이 편집, 이동, 삭제가 필요할 경우 및 일정기간 이상 경과되어 게시물로서의 효력을 상실 하였다고 판단될 경우, 1주일간 공지기간을 거쳐 이를 삭제 및 변경할 수 있습니다.</p>
<br>

<h6>제15조 (게시물의 저작권)</h6>
<p>① 회원이 게시한 홈페이지 게시물의 저작권은 회원에게 있으며, 도서관은 이를 도서관 서비스 홍보 및 교육 등 공공의 목적으로 사용할 수 있습니다.</p>
<p>② 회원의 게시물이 타인의 저작권 등을 침해함으로써 발생하는 민·형사상의 책임은 전적으로 회원이 부담하여야 합니다.</p>
<p>③ 회원은 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.</p>
<br>

<h6>제16조 (도서관의 소유권)</h6>
<p>① 도서관은 홈페이지에서 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타권리를 소유합니다.</p>
<p>② 회원은 도서관이 명시적으로 승인한 경우를 제외하고는 제1항 소정의 각 재산에 대해 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이선스, 담보권 설정행위, 상업적 이용행위를 할수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</p>
<br>

<h5>제4장 기타</h5>
<br>

<h6>제17조 (요금 및 유료정보)</h6>
<p>도서관 서비스 이용은 기본적으로 무료이며, 유료서비스는 사전 공지를 통해 서비스 하겠습니다.</p>
<br>

<h6>제18조 (양도금지)</h6>
<p>회원은 도서관 서비스 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</p>
<br>

<h6>제19조 (손해배상)</h6>
<p>도서관은 회원에게 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동 손해가 도서관의 중대한 과실에 의한 경우를 제외하고 이에 대한 책임을 부담하지 않습니다.</p>
<br>

<h6>제20조 손해배상</h6>
<p>① 도서관은 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.</p>
<p>② 도서관은 통신회선제공사업자가 인터넷 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제됩니다.</p>
<p>③ 도서관은 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다..</p>
<p>④ 도서관은 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않습니다.</p>
<p>⑤ 도서관은 서비스에 표출된 어떠한 의견이나 정보에 대해 확신이나 대표할 의무가 없으며 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다. 도서관은 어떠한 경우라도 이용자가 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다. </p>
<p>⑥ 도서관은 회원 간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 지지 않고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 지지 않습니다. </p>
<p>⑦ 도서관은 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도 등의 내용에 관하여는 책임을 지지 않습니다.</p>
<p>⑧ 도서관은 서비스 이용과 관련하여 귀하에게 발생한 손해 중 귀하의 고의, 과실에 의한 손해에 대하여 책임을 지지 않습니다. </p>
<p>⑨ 도서관은 당 사이트가 제공한 서비스가 아닌 가입자 또는 기타 유관기관이 제공하는 서비스의 내용상의 정확성, 완전성 및 질에 대하여 보장하지 않습니다. 따라서 도서관은 이용자가 위의 내용을 이용함으로 인하여 입게 된 모든 종류의 손실이나 손해에 대하여 책임을 지지 않습니다. 또한 도서관은 이용자가 서비스를 이용하며 타 이용자로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않는다.</p>
<br>

<h6>제21조 (관할법원)</h6>
<p>① 서비스 이용과 관련하여 도서관과 이용자 사이에 분쟁이 발생할 경우, 도서관은 이를 원만하게 해결하기 위하여 필요한 모든 노력을 기울일 것입니다.</p>
<p>② 시비스 이용과 관련하여 소송이 제기될 경우 경상북도교육청 소재지를 관할하는 법원을 관할법원으로 합니다.</p>
<br>

<p><strong>&lt;부칙&gt;</strong><br>
 (시행일) 이 약관은 2017년 1월 1일부터 적용한다.</p> -->
<h4>이용약관 동의</h4>
<br/><h6>제 1 조 (목적)</h6>


<p class="mB20 mL10">본 약관은
<c:choose>
	<c:when test="${homepage.context_path eq 'geic'}">
	경상북도교육청정보센터
	</c:when>
	<c:when test="${homepage.context_path eq 'gm'}">
	경상북도교육청 구미도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ad'}">
	경상북도교육청 안동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'adys'}">
	경상북도교육청 안동도서관용상분관
	</c:when>
	<c:when test="${homepage.context_path eq 'adps'}">
	경상북도교육청 안동도서관풍산분관
	</c:when>
	<c:when test="${homepage.context_path eq 'sj'}">
	경상북도교육청 상주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjhr'}">
	경상북도교육청 상주도서관화령분관
	</c:when>
	<c:when test="${homepage.context_path eq 'yj'}">
	경상북도교육청 영주선비도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yjpg'}">
	경상북도교육청 영주선비도서관풍기분관
	</c:when>
	<c:when test="${homepage.context_path eq 'gbccs'}">
	경상북도교육청문화원
	</c:when>
	<c:when test="${homepage.context_path eq 'yd'}">
	경상북도교육청 영덕도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjl'}">
	경상북도교육청 성주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yy'}">
	경상북도교육청 영양도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'us'}">
	경상북도교육청 의성도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'uj'}">
	경상북도교육청 울진도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ul'}">
	경상북도교육청 울릉도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gw'}">
	경상북도교육청 삼국유사군위도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cd'}">
	경상북도교육청 청도도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cg'}">
	경상북도교육청 칠곡도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'od'}">
	경상북도교육청 외동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cs'}">
	경상북도교육청 청송도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yc'}">
	경상북도교육청 예천도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gr'}">
	경상북도교육청 고령도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'jc'}">
	경상북도교육청 점촌도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yi'}">
	경상북도교육청 영일도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'bh'}">
	경상북도교육청 봉화도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ycgh'}">
	경상북도교육청 금호도서관
	</c:when>
	<c:otherwise>
	경상북도교육청 통합도서관
	</c:otherwise>
</c:choose>
(이하 "당 사이트"라 함)가 제공하는 모든 서비스의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 기본적인 사항을 정함을 목적으로 한다.</p>
<br/><h6>제 2 조 (이용약관의 효력 및 변경)</h6>
<ul class="mB20 mL10">
  <li>① 본 약관은 당 사이트에 게시하여 공시함으로써 효력을 발생한다.</li>
  <li>② 당 사이트는 합리적인 사유가 발생할 경우에 이 약관을 변경할 수 있으며, 약관을 변경한 경우에는 지체 없이 이를 공시한다. </li>
  <li>③ 당 사이트에서 제공하는 모든 서비스가 무료서비스이며 회원 혹은 일반이용자는 변경된 약관에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주한다.</li>
</ul>
<br/><h6>제 3 조 (약관의 적용)</h6>
<ul class="mB20 mL10">
  <li>① 이 약관은 정보센터가 제공하는 개별서비스에 관한 이용안내와 함께 적용한다.</li>
  <li>② 이 약관에 명시되지 아니한 사항에 대해서는 정보통신 관계법령 및 서비스별 안내의 취지에 따라 적용할 수 있다.</li>
</ul>
<br/><h6>제 4 조 (용어의 정의)</h6>
<p class="mB10">본 약관에서 사용하는 용어의 정의는 다음과 같다.</p>
<ul class="mB20 mL10">
  <li>1. 회원 : 본 약관에 동의하고 필요한 개인정보를 제공하여 회원등록을 한 자로서, 당 사이트의 정보 및 서비스를 이용할 수 있는 자</li>
  <li>2. 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 받는 자</li>
  <li>3. 이용계약 : 서비스 이용과 관련하여 당 사이트와 이용자 간에 체결하는 계약</li>
  <li>4. 회원ID : 회원의 식별과 회원의 서비스 이용을 위하여 이용자가 선정하고 당 사이트가 부여하는 문자와 숫자의 조합</li>
  <li>5. 비밀번호 : 회원이 부여 받은 회원ID와 일치된 회원임을 확인하고 회원의 권익보호를 위하여 회원이 선정한 문자와 숫자의 조합</li>
  <li>6. 본 약관에서 정의하지 않은 용어는 관계법령 및 서비스별 안내에서 정하는 바에 의한다.</li>
</ul>
<h2 class="center">제 2 장 이용계약의 성립 및 해지</h2>
<br/><h6>제 5 조 (이용 계약의 성립)</h6>
<ul class="mB20 mL10">
  <li>① 이용계약은 이용자가 본 이용약관 내용에 대한 동의와 가입신청 서식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립된다.</li>
  <li>② 본 이용약관에 대한 동의는 이용신청 당시 당 사이트의 약관에 ‘동의함' 버튼을 누름으로써 의사표시를 한다.</li>
</ul>
<br/><h6>제 6 조 (회원가입 및 탈퇴)</h6>
<ul class="mB20 mL10">
  <li>① 회원가입자격</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 대한민국 국민</li>
      <li>2. 만14세 미만 아동 중 법정대리인의 승낙을 득한 자</li>
    </ul>
  </li>
  <li>② 회원가입은 신청자가 온라인으로 당 사이트에서 제공하는 소정의 가입신청 서식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립된다.</li>
  <li>③ 당 사이트는 다음 각 호에 해당하는 경우에 가입을 취소할 수 있다. </li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 타인의 주민등록번호 또는 정보로 가입한 경우</li>
      <li>2. 회원가입 신청서의 내용을 허위로 기재하였거나 허위서류를 첨부하여 신청하였을 경우</li>
      <li>3. 사회의 안보, 질서 또는 미풍양속을 저해할 목적으로 신청하였거나 그러한 행위를 하였을 경우</li>
      <li>4. 다른 이용자의 당 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 경우</li>
      <li>5. 당 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우</li>
      <li>6. 회원으로서의 부적절한 행위를 할 우려가 있다고 인정되는 경우</li>
      <li>7. 기타 당 사이트가 정한 회원가입요건이 미비할 경우</li>
    </ul>
  </li>
  <li>④ 당 사이트는 다음 각 항에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 서비스 관련 제반 용량이 부족한 경우</li>
      <li>2. 기술상 장애 사유가 있는 경우</li>
      <li>3. 기타 당 사이트가 필요하다고 인정한 경우</li>
      <li>4. 기존 회원의 서비스 이용에 장애가 되는 경우</li>
    </ul>
  </li>
  <li>⑤ 회원은 당 사이트에서 제공하는 서비스를 제공받을 의사가 없는 경우 언제든지 회원탈퇴(해지)를 할 수 있다.</li>
  <li>⑥ 회원은 2년을 주기로 재동의 절차를 거치지 않은 경우 회원의 자격을 상실할 수 있다.</li>
</ul>
<br/><h6>제 7 조 (회원ID 부여 및 변경 등)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 회원에 대하여 약관에 정하는 바에 따라 회원ID를 부여한다.</li>
  <li>② 회원ID는 원칙적으로 변경이 불가하며, 부득이한 사유로 인하여 변경 하고자 하는 경우에는 해당 회원ID를 해지하고 재가입해야 한다.</li>
  <li>③ 회원ID는 다음 각 호에 해당하는 경우에는 이용자 또는 정보센터의 요청으로 변경할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 회원ID가 이용자의 전화번호 또는 주민등록번호 등으로 등록되어 사생활침해가 우려되는 경우</li>
      <li>2. 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우</li>
      <li>3. 한글 ID, 대문자 사용 ID, 첫 글자가 영소문자가 아닌 ID, 특수문자 포함 ID, 5글자미만, 15글자 초과 ID</li>
      <li>4. 기타 합리적인 사유가 있는 경우</li>
    </ul>
  </li>
  <li>④ 회원ID 및 비밀번호의 관리책임은 이용자에게 있다. 관리소홀로 인하여 발생하는 서비스 이용 상의 손해 또는 제3자에 의한 부정이용 등에 대한 책임은 이용자에게 있으며, 당 사이트는 그에 대한 책임을 일체 지지 않는다.</li>
  <li>⑤ 기타 이용자 개인정보 관리 및 변경 등에 관한 사항은 당 사이트가 정하는 바에 의한다.</li>
</ul>
<br/><h6>제 8 조 (회원정보 사용에 대한 동의)</h6>
<ul class="mB20 mL10">
  <li>① 회원의 개인정보에 대해서는 당 사이트의 개인정보보호정책이 적용된다. </li>
  <li>② 당 사이트의 회원 정보는 다음과 같이 수집, 사용, 관리, 보호된다. </li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 개인정보의 수집 : 당 사이트 서비스 가입 시 이용자가 제공하는 정보를 통하여 회원의 정보를 수집한다.</li>
      <li>
        <ul class="mB20 mL20">
          <li>- 필수항목 : 이름, 집주소, 휴대폰 번호, 생년월일, 아이디, 비밀번호, 성별, 본인확인코드, 소속도서관<br/>
 ※휴대폰 번호(나이스평가정보에서 인증 받은 휴대폰 번호)</li>
          <li>- 선택항목 : 집전화번호, 이메일</li>
        </ul>
      </li>
      <li>2. 개인정보의 사용 : 당 사이트는 당 사이트 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않는다. 단, 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우, 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 이용자가 당 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그렇지 않다.</li>
      <li>3. 개인정보의 관리 : 회원은 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 회원의 개인정보를 수정/삭제할 수 있다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경/조정할 수 있다.</li>
      <li>4. 개인정보의 보호 : 회원의 개인정보는 오직 본인만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 회원ID와 비밀번호에 의해 관리되고 있다. 따라서 타인에게 회원ID와 비밀번호를 알려주어서는 안 되며, 작업 종료 시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 한다.</li>
      <li>5. 서비스 이용과정에서 자동 생성되어 수집되는 정보</li>
      <li>
        <ul class="mB20 mL20">
          <li>- IP 주소, 쿠키, 방문 일시, 서비스 이용 기록</li>
        </ul>
      </li>
    </ul>
  </li>
  <li>③ 회원이 당 사이트의 본 약관에 따라 이용신청을 하는 것은 당 사이트가 본 약관에 따라 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주한다.</li>
</ul>
<br/><h6>제 9 조 (사용자의 정보 보안)</h6>
<ul class="mB20 mL10">
  <li>① 가입 신청자가 당 사이트 서비스 가입 절차를 완료하는 순간부터 가입 신청자는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있다.</li>
  <li>② 회원ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 회원ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 당 사이트에 신고하여야 한다. 신고를 하지 않음으로 인해 발생하는 모든 책임은 회원 본인에게 있다. </li>
  <li>③ 이용자는 당 사이트 서비스의 사용 종료 시마다 정확히 로그아웃(Log-out)해야 하며, 로그아웃하지 아니하여 제3자가 회원에 관한 정보를 도용하는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 당 사이트는 책임지지 않는다.</li>
</ul>
<h2 class="center">제 3 장 서비스의 이용</h2>
<br/><h6>제 10 조 (서비스 이용시간)</h6>
<ul class="mB20 mL10">
  <li>① 서비스 이용시간은 당 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 한다. </li>
  <li>② 제1항의 이용시간 중 정기점검 등의 필요로 인하여 당 사이트가 정한 날 또는 시간은 예외로 한다. </li>
</ul>
<br/><h6>제 11 조 (서비스의 중지 및 중지에 대한 공지)</h6>
<ul class="mB20 mL10">
  <li>① 회원은 당 사이트 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 사이트의 관리 범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 당 사이트는 관련 책임을 지지 않는다.</li>
  <li>② 당 사이트가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 당 사이트는 책임을 지지 않는다. 부득이한 사정이 있을 경우 위 사전 공지기간은 감축되거나 생략될 수 있다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 당 사이트는 책임을 지지 않는다.</li>
  <li>③ 당 사이트의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 제 2 항에 의거한다. 다만, 이 경우 사전 공지기간은 1개월로 한다. </li>
  <li>④ 당 사이트는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 귀하 또는 제3자에게 어떠한 책임도 지지 않는다.</li>
  <li>⑤ 당 사이트는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 사이트가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있다.</li>
  <li>⑥ 당 사이트는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있다. 다만 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지한다.</li>
  <li>⑦ 당 사이트는 당 사이트가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의·과실 없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하며, 타인(통신회선제공사업자 등)의 고의·과실로 인한 시스템중단 등의 경우에는 통지하지 않는다.</li>
  <li>⑧ 당 사이트는 서비스를 특정범위로 분할하여 각 범위별로 이용가능시간을 별도로 지정할 수 있다.</li>
  <li>⑨ 당 사이트는 회원이 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지하거나 회원의 동의 없이 이용계약을 해지할 수 있다.  이 경우 당 사이트는 위 이용자의 접속을 금지할 수 있다. </li>
</ul>
<br/><h6>제 12 조 (정보 제공 및 홍보물 게재)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 서비스를 운영함에 있어서 각종 정보를 홈페이지에 게재하는 방법, 전자우편이나 서신우편 발송, 필요하다고 인정되는 다양한 정보를 제공할 수 있다. </li>
  <li>② 당 사이트는 서비스에 적절하다고 판단되거나 공익성이 있는 홍보물을 게재할 수 있다.</li>
</ul>
<br/><h6>제 13 조 (당 사이트 게시물의 관리,운영)</h6>
<ul class="mB20 mL10">
  <li>① 회원이 게시한 게시물의 내용에 대한 권리는 회원에게 있다.</li>
  <li>② 당 사이트는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 다음의 경우 사전 통지 없이 삭제할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 게시물을 게시한 경우</li>
      <li>2. 다른 회원 또는 제 3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우</li>
      <li>3. 공공질서 및 미풍양속에 위반되는 내용인 경우</li>
      <li>4. 범죄적 행위에 결부된다고 인정되는 내용일 경우</li>
      <li>5. 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
      <li>6. 기타 관계 법령에 위배되는 경우.</li>
    </ul>
  </li>
  <li>③ 회원의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 회원이 부담해야 한다.</li>
</ul>
<br/><h6>제 14 조 (서비스 이용제한)</h6>
<ul class="mB20 mL10">
  <li>① 회원이 제공하는 정보의 내용이 허위인 것으로 판명되거나, 허위가 있다고 의심할 만한 합리적인 사유가 발생할 경우 당 사이트는 회원의 본 서비스 사용을 일부 또는 전부 중지할 수 있으며, 이로 인해 발생하는 불이익에 대해 책임을 지지 아니한다. </li>
  <li>② 당 사이트는 회원이 본 약관 제16조(회원의 의무)등 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있다. 이 경우 당 사이트는 귀하의 접속을 금지할 수 있다.</li>
</ul>
<h2 class="center">제 4 장 의무 및 책임</h2>
<br/><h6>제 15 조 (당 사이트의 의무)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 지속적 안정적으로 서비스를 제공하기 위해 노력할 의무가 있다.</li>
  <li>② 당 사이트는 회원의 개인신상정보를 본인의 승낙 없이 타인에게 누설, 배포하지 않는다. 다만, 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그렇지 않다.</li>
  <li>③ 당 사이트는 이용자의 귀책사유로 인한 서비스 이용 장애에 대하여 책임을 지지 않는다. </li>
</ul>
<br/><h6>제 16 조 (회원의 의무)</h6>
<ul class="mB05 mL10">
  <li>① 회원 가입시에 요구되는 정보는 정확하게 기입해야 한다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 회원ID 및 비밀번호를 제3자가 이용하게 해서는 안된다.</li>
  <li>② 회원은 당 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없다. </li>
  <li>③ 회원은 당 사이트 서비스를 이용하여 얻은 정보를 당 사이트의 사전승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다. </li>
  <li>④ 회원은 당 사이트 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안 된다. </li>
</ul>
<ul class="mB20 mL20">
  <li>1. 다른 회원의 회원ID와 비밀번호를 도용하여 부정 사용하는 행위</li>
  <li>2. 저속, 음란, 모욕적, 위협적이거나 타인의 사생활을 침해할 수 있는 내용을 전송, 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>3. 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</li>
  <li>4. 법률, 계약에 의해 이용할 수 없는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>5. 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>6. 당 사이트의 승인을 받지 아니한 광고, 판촉물, 스팸메일, 행운의 편지, 피라미드 조직 기타 다른 형태의 권유를 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>7. 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
  <li>8. 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위</li>
  <li>9. 선량한 풍속, 기타 사회질서를 해하는 행위</li>
  <li>10. 타인의 명예를 훼손하거나 모욕하는 행위</li>
  <li>11. 타인의 지적재산권 등의 권리를 침해하는 행위</li>
  <li>12. 해킹행위 또는 컴퓨터바이러스의 유포행위</li>
  <li>13. 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위</li>
  <li>14. 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위</li>
  <li>15. 당 사이트에 게시된 정보의 변경</li>
  <li>16. 기타 관계법령에 위배되는 행위</li>
</ul>
<h2 class="center">제 5 장 기 타</h2>
<br/><h6>제 17 조 (당 사이트의 소유권)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 당 사이트에 소유권이 있다.</li>
  <li>② 이용자는 당 사이트가 명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정 행위, 상업적 이용행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없다.</li>
</ul>
<br/><h6>제 18 조 (양도금지)</h6>
<p class="mB20 mL10">회원이 서비스의 이용권한, 기타 이용계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없다.</p>
<br/><h6>제 19 조 (손해배상)</h6>
<p class="mB20 mL10">당 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 당 사이트가 고의로 행한 범죄행위를 제외하고는 이에 대하여 책임을 부담하지 않는다.</p>
<br/><h6>제 20 조 (면책조항)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제된다.</li>
  <li>② 당 사이트는 통신회선제공사업자가 인터넷 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제된다.</li>
  <li>③ 당 사이트는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제된다.</li>
  <li>④ 당 사이트는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않는다.</li>
  <li>⑤ 당 사이트는 서비스에 표출된 어떠한 의견이나 정보에 대해 확신이나 대표할 의무가 없으며 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않는다. 당 사이트는 어떠한 경우라도 귀하가 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없다. </li>
  <li>⑥ 당 사이트는 회원 간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 지지 않고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 지지 않는다. </li>
  <li>⑦ 당 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도 등의 내용에 관하여는 책임을 지지 않는다.</li>
  <li>⑧ 당 사이트는 서비스 이용과 관련하여 귀하에게 발생한 손해 중 귀하의 고의, 과실에 의한 손해에 대하여 책임을 지지 않는다. </li>
  <li>⑨ 당 사이트는 당 사이트가 제공한 서비스가 아닌 가입자 또는 기타 유관기관이 제공하는 서비스의 내용상의 정확성, 완전성 및 질에 대하여 보장하지 않는다. 따라서 당 사이트는 이용자가 위의 내용을 이용함으로  인하여 입게 된 모든 종류의 손실이나 손해에 대하여 책임을 지지 않는다. 또한 당 사이트는 이용자가 서비스를 이용하며 타 이용자로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않는다.</li>
</ul>
<br/><h6>제 21 조 (관할법원)</h6>
<p class="mB20 mL10">본 서비스 이용과 관련하여 발생한 분쟁에 대해 소송이 제기될 경우 대구지방법원을 관할 법원으로 한다.</p>
<br/><h6>부 칙</h6>
<p class="mB20 mL10">① (시행일) 이 약관은 2005년 3월 14일부터 시행한다.</p>
<br/><h6>부 칙</h6>
<p class="mB20 mL10"> ① (시행일) 이 약관은 2009년 3월 13일부터 시행한다.</p>
<p class="mB10 mL10">* 본 약관에 대한 저작권은 
<c:choose>
	<c:when test="${homepage.context_path eq 'geic'}">
	경상북도교육청정보센터
	</c:when>
	<c:when test="${homepage.context_path eq 'gm'}">
	경상북도교육청 구미도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ad'}">
	경상북도교육청 안동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'adys'}">
	경상북도교육청 안동도서관용상분관
	</c:when>
	<c:when test="${homepage.context_path eq 'adps'}">
	경상북도교육청 안동도서관풍산분관
	</c:when>
	<c:when test="${homepage.context_path eq 'sj'}">
	경상북도교육청 상주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjhr'}">
	경상북도교육청 상주도서관화령분관
	</c:when>
	<c:when test="${homepage.context_path eq 'yj'}">
	경상북도교육청 영주선비도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yjpg'}">
	경상북도교육청 영주선비도서관풍기분관
	</c:when>
	<c:when test="${homepage.context_path eq 'gbccs'}">
	경상북도교육청문화원
	</c:when>
	<c:when test="${homepage.context_path eq 'yd'}">
	경상북도교육청 영덕도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjl'}">
	경상북도교육청 성주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yy'}">
	경상북도교육청 영양도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'us'}">
	경상북도교육청 의성도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'uj'}">
	경상북도교육청 울진도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ul'}">
	경상북도교육청 울릉도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gw'}">
	경상북도교육청 삼국유사군위도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cd'}">
	경상북도교육청 청도도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cg'}">
	경상북도교육청 칠곡도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'od'}">
	경상북도교육청 외동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cs'}">
	경상북도교육청 청송도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yc'}">
	경상북도교육청 예천도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gr'}">
	경상북도교육청 고령도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'jc'}">
	경상북도교육청 점촌도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yi'}">
	경상북도교육청 영일도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'bh'}">
	경상북도교육청 봉화도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ycgh'}">
	경상북도교육청 금호도서관
	</c:when>
	<c:otherwise>
	경상북도교육청 통합도서관
	</c:otherwise>
</c:choose>
에 귀속되며 무단복제, 배포, 전송, 기타 저작권 침해행위를 엄금한다.</p>


</font>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1" style="opacity: inherit;" ><label style="position: static !important;" for="agree_codes1">이용약관 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

	<h4>개인정보의 수집·이용 동의</h4>
	<div class="Box" style="height:200px" tabindex="0" >

<font size="2">
<h5>1.개인정보의 수집·이용 목적</h5>
<!--
<p>가. 경상북도교육청 도서관 통합정보시스템이 제공하는 서비스 이용을 위해 다음의 목적으로 개인정보를 수집·이용합니다.</p>
  <ul>
    <li>  1) 홈페이지 서비스 : 자료대출관리, 평생학습 수강신청, 게시물 등록, 도서관 홍보 및 교육 활성화 등</li>
    <li>  2) 독서문화/평생교육 서비스: 도서관 행사, 체험 학습, 평생학습 신청 및 수강 등</li>
    <li>  3) 자료대출 서비스 : 자료이용현황, 자료의 예약·신청·대출, 전자도서관 이용 등</li>
  </ul>
<p>나. 수집된 개인정보는 목적 이외의 용도로 이용되지 않으며, 이용 목적이 변경되는 경우 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</p>
-->
<p>&nbsp;&nbsp;&nbsp;· 경상북도교육청 통합도서관 홈페이지의 회원제 서비스 운영</p>
<p>&nbsp;&nbsp;&nbsp;· 자료대출 서비스 제공</p>
<br>

<h5>2.수집하는 개인정보 항목</h5>
<p>&nbsp;&nbsp;&nbsp;가. 정보주체<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 필수: 아이디, 비밀번호, 이름, 생년월일, 성별, 본인확인인증정보, 소속도서관, 휴대전화번호, 주소<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 선택: 집전화번호, 이메일, 대출회원증번호, 대출회원증비밀번호, 직장명, 직장연락처, 직장주소
</p>
<p>&nbsp;&nbsp;&nbsp;나. 법정대리인<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 필수: 이름, 연락처, 본인확인인증정보<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 선택: 없음
</p>
<!--
<table style="boder:1; margin:auto; text-align:center;">
<tbody><tr style="background:#BDBDBD;" class="first">
  <td style="width:15%;" class="first td1">서비스항목</td>
  <td style="width:35%;" class="td2">필수항목</td>
  <td style="width:35%;" class="td3">선택항목</td>
  <td style="width:15%;" class="last td4">비고</td>
</tr>
<tr>
	<td class="first td1"> 홈페이지<br/>서비스</td>
	<td class="td2 left"> 아이디, 비밀번호, 성명, 생년월일, 성별, 주소, 핸드폰 번호(전화번호), 소속도서관, 본인확인코드</td>
	<td class="last td3 left"> 집전화번호, 직장(직장명, 연락처, 주소), 법정대리인 성명 및 연락처(필요시)</td>
</tr>
<tr>
	<td class="first td1"> 독서문화/평생교육<br/>서비스</td>
	<td class="td2 left"> 아이디, 비밀번호, 성명, 생년월일, 성별, 주소, 핸드폰 번호(전화번호), 학교/학년(필요시), 법정대리인 성명 및 연락처(필요시), 활동사진</td>
	<td class="td3"> </td>
	<td class="last left td4"> 독서문화 행사 및 체험, 평생교육 수강시 활동사진 게시</td>
</tr>
<tr>
	<td class="first td1"> 도서대출<br/>서비스</td>
	<td class="td2 left"> 아이디, 비밀번호, 성명, 생년월일, 성별, 주소, 핸드폰 번호(전화번호), 대출회원증번호, 대출회원증비밀번호</td>
	<td class="td3 left"> 집전화번호, 직장(직장명, 연락처, 주소), 법정대리인 성명 및 연락처(필요시)</td>
	<td class="last left td4"> 도서관 방문필요</td>
</tr>
</tbody></table>
-->
<br>
<h5>3.개인정보의 보유 및 이용 기간</h5>
<p>&nbsp;&nbsp;&nbsp;· 회원탈퇴시까지(2년 주기 재동의)</p>
<!--
<br>
<table style="boder:1; margin:auto; text-align:center;">
<tbody><tr style="background:#BDBDBD;" class="first">
  <td style="width:20%;" class="first td1">서비스항목</td>
  <td style="width:30%;" class="td2">보유기간</td>
  <td style="width:30%;" class="td3">이용기간</td>
  <td style="width:20%;" class="last td4">비고</td>
</tr>
<tr>
<td class="first td1"> 홈페이지 서비스</td>
<td class="td2"> 2년(회원 탈퇴시까지)</td>
<td class="td3"> 2년(회원 탈퇴시까지)</td>
<td class="last td4"> 2년 주기 재동의 </td>
</tr>
<tr>
<td class="first td1"> 독서문화/평생교육 서비스 </td>
<td class="td2"> 2년(회원 탈퇴시까지)</td>
<td class="td3"> 2년(회원 탈퇴시까지)</td>
<td class="last td4"> 2년 주기 재동의 </td>
</tr>
<tr>
<td class="first td1"> 도서대출 서비스</td>
<td class="td2"> 2년(회원 탈퇴시까지)</td>
<td class="td3"> 2년(회원 탈퇴시까지)</td>
<td class="last td4"> 이용약관 제8조 우선 적용 </td>
</tr>
</tbody></table>
-->
<br>

<h5>4.개인정보 수집·이용에 대한 동의를 거부할 권리</h5>
<p>&nbsp;&nbsp;&nbsp;· 개인정보 수집‧이용을 거부할 수 있으며, 미동의 시 도서관통합정보시스템 회원가입이 제한됩니다.</p>
<!--<p>이용자는 개인정보 수집·이용에 동의하지 않으실 수 있습니다. 다만, 필수항목 제공의 동의 거부 시 회원가입이 불가능하며, 선택항목 거부 시 서비스가 일부 제한 될 수 있습니다.</p>-->
</font>
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2" style="opacity: inherit;"><label  style="position: static !important;" for="agree_codes2">개인정보의 수집·이용 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>


<!-- 
<h4>개인정보 제 3자 제공 동의</h4>
<div class="Box" style="height:200px" tabindex="0" >

<font size="2">
<h5>1. 개인정보를 제공받는 자</h5>
<p>&nbsp;&nbsp;&nbsp;· 국립중앙도서관, 지역대표도서관, 책이음서비스참여도서관</p>

<br>
<div class="Box">
		<ul class="lib-list webList">

			<li>경상북도교육청<br/>문화원<br class="test"/>(054-245-7715)</li>
			<li>경상북도교육청<br/>영일도서관<br class="test"/>(054-261-8856)</li>	
			<li>경상북도교육청<br/>영덕도서관<br class="test"/>(054-734-3106)</li>

			<li>경상북도교육청<br/>구미도서관<br class="test"/>(054-450-7000)</li>
			<li>경상북도교육청<br/>외동도서관<br class="test"/>(054-776-6960)</li>
			<li>경상북도교육청<br/>청도도서관<br class="test"/>(054-370-7600)</li>
			
			<li>경상북도교육청<br/>안동도서관<br class="test"/>(054-840-8414)</li>
			<li>경상북도교육청<br/>금호도서관<br class="test"/>(054-335-2124)</li>
			<li>경상북도교육청<br/>고령도서관<br class="test"/>(054-955-2510)</li>

			<li>경상북도교육청<br/>안동도서관용상분관<br class="test"/>(054-821-5491)</li>	
			<li>경상북도교육청<br/>점촌도서관<br class="test"/>(054-550-3600)</li>
			<li>경상북도교육청<br/>성주도서관<br class="test"/>(054-933-2095)</li>	

			<li>경상북도교육청<br/>안동도서관풍산분관<br class="test"/>(054-858-7603)</li>
			<li>경상북도교육청<br/>점촌도서관가은분관<br class="test"/>(054-572-0309)</li>
			<li>경상북도교육청<br/>칠곡도서관<br class="test"/>(054-971-1507)</li>

			<li>경상북도교육청<br/>상주도서관<br class="test"/>(054-530-6300)</li>
			<li>경상북도교육청<br/>삼국유사군위도서관<br class="test"/>(054-382-0528)</li>
			<li>경상북도교육청<br/>예천도서관<br class="test"/>(054-654-9666)</li>	

			<li>경상북도교육청<br/>상주도서관화령분관<br class="test"/>(054-532-4754)</li>	
			<li>경상북도교육청<br/>의성도서관<br class="test"/>(054-834-7911)</li>	
			<li>경상북도교육청<br/>봉화도서관<br class="test"/>(054-673-0973)</li>	

			<li>경상북도교육청<br/>영주선비도서관<br class="test"/>(054-630-3800)</li>
			<li>경상북도교육청<br/>청송도서관<br class="test"/>(054-872-4905)</li>
			<li>경상북도교육청<br/>울진도서관<br class="test"/>(054-783-2375)</li>	

			<li>경상북도교육청<br/>영주선비도서관풍기분관<br class="test"/>(054-637-9811)</li>	
			<li>경상북도교육청<br/>영양도서관<br class="test"/>(054-683-2829)</li>	
			<li>경상북도교육청<br/>울릉도서관<br class="test"/>(054-791-2294)</li>

		</ul>

		<ul class="lib-list mobileList">
			<li>경상북도교육청<br/>문화원<br class="test"/>(054-245-7715)</li>
			<li>경상북도교육청<br/>삼국유사군위도서관<br class="test"/>(054-382-0528)</li>
			<li>경상북도교육청<br/>구미도서관<br class="test"/>(054-450-7000)</li>
			<li>경상북도교육청<br/>의성도서관<br class="test"/>(054-834-7911)</li>
			<li>경상북도교육청<br/>안동도서관<br class="test"/>(054-840-8414)</li>
			<li>경상북도교육청<br/>청송도서관<br class="test"/>(054-872-4905)</li>
			<li>경상북도교육청<br/>안동도서관용상분관<br class="test"/>(054-821-5491)</li>	
			<li>경상북도교육청<br/>영양도서관<br class="test"/>(054-683-2829)</li>	
			<li>경상북도교육청<br/>안동도서관풍산분관<br class="test"/>(054-858-7603)</li>	
			<li>경상북도교육청<br/>영덕도서관<br class="test"/>(054-734-3106)</li>
			<li>경상북도교육청<br/>상주도서관<br class="test"/>(054-530-6300)</li>
			<li>경상북도교육청<br/>청도도서관<br class="test"/>(054-370-7600)</li>
			<li>경상북도교육청<br/>상주도서관화령분관<br class="test"/>(054-532-4754)</li>	
			<li>경상북도교육청<br/>고령도서관<br class="test"/>(054-955-2510)</li>
			<li>경상북도교육청<br/>영주선비도서관<br class="test"/>(054-630-3800)</li>
			<li>경상북도교육청<br/>성주도서관<br class="test"/>(054-933-2095)</li>	
			<li>경상북도교육청<br/>영주선비도서관풍기분관<br class="test"/>(054-637-9811)</li>	
			<li>경상북도교육청<br/>칠곡도서관<br class="test"/>(054-971-1507)</li>
			<li>경상북도교육청<br/>영일도서관<br class="test"/>(054-261-8856)</li>	
			<li>경상북도교육청<br/>예천도서관<br class="test"/>(054-654-9666)</li>	
			<li>경상북도교육청<br/>외동도서관<br class="test"/>(054-776-6960)</li>
			<li>경상북도교육청<br/>봉화도서관<br class="test"/>(054-673-0973)</li>	
			<li>경상북도교육청<br/>금호도서관<br class="test"/>(054-335-2124)</li>
			<li>경상북도교육청<br/>울진도서관<br class="test"/>(054-783-2375)</li>	
			<li>경상북도교육청<br/>점촌도서관<br class="test"/>(054-550-3600)</li>
			<li>경상북도교육청<br/>울릉도서관<br class="test"/>(054-791-2294)</li>
			<li>경상북도교육청<br/>점촌도서관가은분관<br class="test"/>(054-572-0309)</li>
		</ul>
	</div>

<br>

<h5>2. 제공받는 자의 개인정보 이용 목적</h5>
<p>&nbsp;&nbsp;&nbsp;· 책이음 서비스 제공을 위한 회원 식별 및 관리, 기타 정보 전달</p>
<br>

<h5>3. 제공하는 개인정보 항목</h5>
<p>&nbsp;&nbsp;&nbsp;· 이름, 생년월일, 성별, 본인확인인증정보, 주소, 휴대전화번호, 집전화번호, 이메일, 직장명, 직장전화번호, 직장주소, 대출회원증번호</p>
<br>

<h5>4. 제공받는 자의 개인정보 보유 및 이용기간</h5>
<p>&nbsp;&nbsp;&nbsp;· 회원탈퇴시까지</p>
<br>

<h5>5. 동의거부 권 및 불이익: 개인정보 제3자 제공에 대한 동의를 거부 할 권리가 있으며 거부할 경우에는 회원가입을 할 수 없습니다.</h5><br>
</font>
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="agree_codes3" name="agree_codes" req="0001" type="checkbox" value="6" style="opacity: inherit;"><label  style="position: static !important;" for="agree_codes3">개인정보 제3자 제공에 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
	 -->
</c:if>
</form:form>

	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">
			<c:if test="${engMode}">I agree</c:if>
			<c:if test="${!engMode}">동의합니다</c:if>
		</a>
		<a href="#" id="notAgree" class="btn">
			<c:if test="${engMode}">I don't agree</c:if>
			<c:if test="${!engMode}">동의하지 않습니다</c:if>
		</a>
	</div>

</div>

