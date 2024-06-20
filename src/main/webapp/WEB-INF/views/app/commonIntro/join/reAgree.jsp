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
			doAjaxPost($('#memberAgreeForm'));	
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
	
	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});
	
	<c:if test="${member.langMode eq 'eng'}">
	$('div.doc-title > h3').text('Membership');
	</c:if>
});
</script>
<style>
b {font-size: 105%; color: #0f509f; }
</style>
<c:set var="engMode" value="${member.langMode eq 'eng'}"></c:set>
<c:if test="${engMode}">
<style>
.join-step li { margin: 0% 3%;}
</style>
</c:if>
<div class="join-step" style="position: inherit;">
	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>	
		<c:if test="${!engMode}">회원가입 단계</c:if>	
	</p>
	<ul>
		<li class="step2 active"><span>2</span> 
			<c:if test="${engMode}"><em style="letter-spacing: 0px;">Consent to users agreement</em></c:if>	
			<c:if test="${!engMode}"><em style="letter-spacing: 0px;">이용약관 및 개인정보 수집&middot;이용 재동의</em></c:if>
		</li>
	</ul>
</div>

<div class="join-wrap" style="padding:20px 0 0 0;">

<!--
	<h4 style="padding-top: 25px;">
		<c:if test="${engMode}">
		Guide on integration of public libraries in the Gyeongsangbuk-do Office of Education 
		</c:if>
		<c:if test="${!engMode}">
		이용약관 및 개인정보 수집&middot;이용 재동의 안내
		</c:if>
	</h4>

	<p class="txte" style="padding-bottom: 25px;">
		<c:if test="${engMode}">
		- Member information is integrated and operated through construction of integrated system of public libraries in the Gyeongsangbuk-do Office of Education<br/>
		- In order to use member services, you must give consent to collection and use of personal information below. </b><br/> 
		</c:if>
		<c:if test="${!engMode}">
		- 회원님의 개인정보 동의 기간은 <b>${sessionScope.member.agree_date_str}</b>입니다. <br/>
		- <b>${sessionScope.member.agree_date_str}</b> 이후에는 약관에 의거 <b>개인정보가 삭제</b>됩니다. <br/>
		- 회원서비스를 이용하기 위해서는 <b>아래의 이용약관 및 개인정보수집&middot;이용에 재동의하셔야 합니다.</b><br/>
		</c:if>
	</p>
-->
<form:form modelAttribute="newMember" id="memberAgreeForm" action="reAgreeA.do" method="post">
<form:hidden path="menu_idx"/>
<form:hidden path="langMode"/>
	
	
<c:if test="${engMode}">
	<h4>Consent to Users Agreement </h4>
	<div class="Box" style="height:200px">
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
			
			<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1"><label for="agree_codes1">Consent to Users Agreement</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
	
	<h4>Consent to Collection and Use of Personal Information</h4>
	<div class="Box" style="height:200px">
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
			<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes2">Consent to Collection and Use of Personal Information</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
</c:if>
<c:if test="${!engMode}">

	<h4>대구광역시 도서관 통합회원 이용약관</h4>
	<div class="Box" style="height:200px">
		  <p><strong>제1장 총칙<br><br>
		  제1조 (목적)</strong><br />
		  본 약관은 『대구광역시 도서관 통합 허브시스템』을 구축(이하 ‘통합시스템’이라 함)에 따라 대구광역시 공립 공공도서관 및 공립 작은도서관(이하 ‘도서관’ 이라 한다.) 회원 정보를 통합 운영함에 있어 이용자와 도서관간의 이용조건 및 절차, 이용에 관한 권리와 의무 등 제반사항을 규정함을 목적으로 한다.<br>
		  <br>
		  <strong>제2조 (용어의 정의)</strong><br />
		  ① 본 약관에서 사용하는 용어의 정의는 다음과 같다.<br />
		  <span class="siz12"> 1. 서비스 : 온라인사이트 이용 및 오프라인도서관 이용 모두를 의미<br />
		  2. 사이트 : 도서관에서 운영하는 홈페이지<br />
		  3. 통합회원 : 도서관 회원 가입에 동의하고 본인확인절차를 통해 회원번호 부여 및 회원카드가 발급된 회원으로 자료의 관외대출이 가능한 회원 또는 통합인증을 통해 통합회원으로 자격이 부여된 회원이며 책이음 이용정보제공이용약관에 동의하면 책이음회원으로 자격을 부여 한다.<br />
		  4. 통합인증 : 통합회원, 책이음회원으로의 자격을 부여받는 절차를 의미하며 통합인증을 받지 않으면 일부 서비스의 제약을 받을 수 있다.<br />
		  5. 아이디(ID) : 회원 식별과 서비스 이용을 위하여 이용자가 생성한 영문자 또는 기타 문자로 조합된 부호<br />
		  6. 비밀번호(PASSWORD) : 회원의 정보 보호를 위해 이용자 자신이 설정한 문자와 숫자, 특수문자 등으로 조합된 부호<br />
		  </span>② 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스 별 안내에서 정하는 바에 의한다.<br>
		  <br>
		  <strong>제3조 (약관의 효력 및 변경)</strong><br />
		  ① 본 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공시되며, 이를 동의한 이용자가 서비스에 가입함으로써 효력이 발생한다.<br />
		  ② 합리적인 사유가 발생할 경우 도서관은 관련 법령에 위배되지 않는 범위 안에서 개정할 수 있다. 개정된 약관은 사이트 등을 통해 공지함으로써 효력이 발생한다.<br />
		  ③ 회원은 정기적으로 사이트를 방문하여 약관의 변경사항을 확인하여야 하며 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있다. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원의 피해는 도서관에서 책임지지 않는다. <br />
		  ④ 도서관의 자료대출 및 좌석예약 실적이 2년 이상 없고 계속 사용에 대한 동의를 하지 않은 경우 회원 효력이 상실된다.<br />
		  ⑤ 도서관은 필요한 경우 개별 서비스에 대하여 이용규정을 정할 수 있으며, 본 약관과 서로 상충되는 경우에는 서비스별 이용규정의 내용을 우선하여 적용한다.<br />
		  ⑥ 본 약관에 명시되지 않은 사항에 대해서는 관련 법령의 규정에 의한다.<br>
		  <br>
		  <br>
		  </span>

		  <strong>제2장 서비스 이용계약<br>
		  <br>
		  제4조 (이용계약의 성립)</strong><br />
		  ① 이용계약은 이용자의 약관내용 및 개인정보 제공에 대한 동의와 이용자의 이용신청에 대한 도서관 관리자의 승낙으로 성립한다.<br>
		  ② 이용계약에 대한 동의는 이용 신청 당시 사이트의 ‘동의함’ 버튼을 누름으로써 의사표시를 한다. <br>
		  <br>

		  <strong>제5조 (회원 자격) 회원은 다음 각 호의 어느 하나에 해당하는 경우 그 자격을 가진다.</strong><br />
		  <span class="siz12">
		  &nbsp;&nbsp;1. 대구광역시(경산시, 칠곡군 포함)에 주민등록이 되어 있는 자<br>
		  &nbsp;&nbsp;2. 대구광역시 소재 직장에 재직하는 자<br>
		  &nbsp;&nbsp;3. 대구광역시(경산시, 칠곡군 포함)소재 학교에 재학하는 자<br>
		  &nbsp;&nbsp;4. 대구광역시에 거주하는 재외동포 국내거소 신고자 및 외국인 등록자<br>
		  &nbsp;&nbsp;5. 그밖에 관장이 필요하다고 인정하는 자<br>
		  </span><br>
		  <br>

		  <strong>제6조 (회원 가입 및 탈퇴)</strong><br />
		  ① 이용자는 도서관에서 제공하는 홈페이지에서 개인정보 수집 및 정보 제공을 동의한 후 회원가입을 신청할 수 있다.<br><br/>
		  <div>
		<div style="text-align:center;">
			<도서관 통합회원 개인정보 수집 정보, 목적 및 보유기간>
		</div>
		<table>
		  <tr>
			<th style="text-align:Center">구분</th>
			<th colspan="2" style="text-align:Center">항목</th>
			<th style="text-align:Center">수집목적</th>
			<th style="text-align:Center">보유기간</th>
		  </tr>
		  <tr>
			<td rowspan="3" style="width:10%">필수</td>
			<td style="width:15%">14세 이상</td>
			<td style="width:35%">아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호 또는 전화번호(자택), 주소, 도서회원번호, CI값, 도서대출내역, SMS수신여부</td>
			<td rowspan="2" style="width:20%">도서대출 및
				 반납 등
			  도서관 서비스</td>
			<td rowspan="5" style="width:20%">2년
				(회원 탈퇴시
			  까지)</td>
		  </tr>
		  <tr>
			<td>14세 미만</td>
			<td>아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호 또는 전화번호(자택), 주소, 도서회원번호, CI값, 도서대출내역 법정대리인 성명 및 연락처, SMS수신여부</td>
		  </tr>
		  <tr>
			<td colspan="2">법정대리인 성명, 연락처</td>
			<td>만 14세 미만
				신청자</td>
		  </tr>
		  <tr>
			<td rowspan="2">선택</td>
			<td colspan="2">근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
			<td>타지역 거주 도서 회원 가입</td>
		  </tr>
		  <tr>
			<td colspan="2">이메일, 이메일수신여부</td>
			<td>서비스 안내</td>
		  </tr>
		</table>
		  </div>
		  <p>※ 휴대폰 번호는 나이스평가정보에서 인증 받은 휴대폰 번호를 사용 하고 있습니다.(단, 핸드폰 인증만 국한)</p>
		  <br/>

		  ② 회원 가입과 동시에 공공도서관 책이음 회원으로 가입된다.<br>
		  ③ 도서관 관리자는 제6조 ①항에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙하여야 한다. 단, 다음의 경우 회원 가입을 취소할 수 있다.<br>
		  <span class="siz12">
		  &nbsp;&nbsp;1. 본인의 실명으로 신청하지 않았을 때<br>
		  &nbsp;&nbsp;2. 다른 사람의 명의를 사용하여 신청하였을 때<br>
		  &nbsp;&nbsp;3. 신청서의 내용을 허위로 기재하였을 때<br>
		  &nbsp;&nbsp;4. 14세 미만 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 경우<br>
		  &nbsp;&nbsp;5. 사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때  <br>
		  &nbsp;&nbsp;6. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 경우<br>
		  &nbsp;&nbsp;7. 서비스를 이용함에 법령과 본 약관이 금지하는 행위를 하는 경우<br>
		  &nbsp;&nbsp;8. 기타 도서관이 정한 신청 요건이 미비 되었을 때<br>
		  </span><br>
		  ④ 회원이 이용계약을 해지하고자 할 때에는 홈페이지 또는 도서관을 직접 방문하여 본인확인절차를 거친 후 탈퇴 신청을 하여야 한다.<br />
		  ⑤ 회원탈퇴 시 해당 회원과 관련된 모든 개인정보는 보유기간이 만료되므로 삭제된다.<br />
		  <br>


		  <strong>제7조 (회원 정보 관리)</strong><br />
		  ① 회원은 홈페이지 회원정보관리 및 도서관에 직접 방문하여 정보를 열람하고 수정할 수 있다. <br />
		  ② 회원의 개인정보에 대한 관리책임은 회원에게 있다. 이를 소홀히 관리하여 발생하는 서비스 이용상의 손해 또는 제3자에 의한 부정 이용 등에 대한 책임은 모두 회원에게 있으며 도서관은 그에 대해 책임지지 않는다.<br>
		  ③ 도서관은 보안 및 아이디 정책, 서비스의 원활한 제공 등과 같은 이유로 회원 아이디 및 비밀번호 변경을 요구할 수 있다.<br>
		  <br>

		  <strong>제8조 (회원 자격 상실 및 회원정보 삭제)</strong><br />
		  ① 회원은 개인정보보호법 제21조 및 동법 시행령 제16조에 의거하여 다음의 경우 회원 자격을 상실하며, 개인정보도 삭제된다.<br />
		  &nbsp;&nbsp;1. 본인이 탈퇴를 원하는 경우<br />
		  &nbsp;&nbsp;2. 회원의 법령 또는 약관의 위반을 포함하여 부정행위 확인 등의 정보보호 업무를 위해 필요한 경우<br />
		  ② 다음의 경우 탈퇴 신청은 제한되며, 개인정보 또한 삭제되지 않는다. 단, 제한사유가 소멸되면 즉시 탈퇴할 수 있다. <br />
		  &nbsp;&nbsp;1. 도서관으로 반납할 자료가 있거나 대출정지 중인 경우<br />
		  &nbsp;&nbsp;2. 대출 자료를 분실 혹은 훼손하고 변상하지 않은 경우<br />
		  &nbsp;&nbsp;3. 기타 회원탈퇴 제한이 필요하다고 도서관장이 인정하는 경우<br />
		  <br>

		  <strong>제9조 (개인정보의 보호 및 사용)</strong><br />
			① 도서관은 회원정보를『개인정보보호법』에 의해 보호한다.<br>
			② 회원의 개인정보는 오직 본인만이 열람/수정/삭제 하는 것을 원칙으로 하되,  비밀번호 등이 타인에게 노출되지 않도록 철저히 관리해야한다.<br>
			③ 도서관은 서비스 제공과 관련해서 수집된 회원의 개인정보를 본인의 동의 없이 제3자에게 제공되지 않는다. 다만, 개인정보보호법 제18조에 의거 제3자에게 제공할 수 있다.<br>
			  &nbsp;&nbsp;1. 수사기관이나 기타 다른 정부기관으로부터 정보제공을 요청 받은 경우<br>
			  &nbsp;&nbsp;2. 회원의 법령 또는 약관의 위반을 포함하여 부정행위 확인 등의 정보보호 업무를 위해 필요한 경우<br>
			  &nbsp;&nbsp;3. 기타 법률에 의해 요구되는 경우<br>
		  <br>

		  <strong>제3장 서비스 제공 및 이용<br>
		  <br>
		  제10조 (서비스의 제공)</strong><br />
			① 도서관 관리자는 회원의 이용신청을 승낙한 때부터 서비스를 개시한다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시할 수 있다.<br>
			② 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공지하거나 회원에게 이를 통지한다.<br>
			③ 도서관은 긴급한 시스템 점검, 교체, 설비의 장애, 서비스 이용의 폭주, 국가비상사태, 정전 등 부득이한 사유가 발생한 경우 사전 예고없이 일시적으로 서비스의 전부 또는 일부를 중단할 수 있다.<br>
			④ 도서관은 서비스 개편 등 서비스 운영 상 필요한 경우 회원에게 사전 예고 후 서비스의 전부 또는 일부의 제공을 중단 할 수 있다.<br>
		  <br>

		  <strong>제11조 (서비스의 변경)</strong><br />
		  ① 도서관은 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 서비스를 변경할 수 있다.<br>
		  ② 도서관은 정책 및 운영의 필요에 따라 사전공지를 통해 무료로 제공되는 서비스의 일부 또는 전부를 수정, 중단, 변경할 수 있으며, 이용회원에게는 별도의 보상을 하지 않는다.<br>
		  <br>

		  <strong>제11조 (정보의 제공)</strong><br />
		  회원에게 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편 및 휴대폰 문자메시지 등의 방법으로 제공할 수 있다. 다만, 회원은 정보수신을 원치 않을 경우에는 거부할 수 있다.<br>
		  <br>


		  <strong>제12조 (정보의 제공)</strong><br />
		  회원에게 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편 및 휴대폰 문자메시지 등의 방법으로 제공할 수 있다. 다만, 회원은 정보수신을 원치 않을 경우에는 거부할 수 있다.<br><br>
		  <br>

		  <strong>제4장 계약 당사자의 의무<br>
		  <br>

		  제13조 (도서관의 의무)</strong><br />
			① 도서관은 회원이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 한다.<br>
			② 도서관은 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구해야 한다.<br>
			③ 도서관은 회원이 안전하게 서비스를 이용할 수 있도록 개인정보보호를 위한 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수하여야 한다.<br>
			④ 도서관은 회원으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 한다. 다만, 즉시 처리가 곤란한 경우는 회원에게 그 사유와 처리일정을 통보하여야 한다.<br>
		  <br>


		  <strong>제14조 (회원의 의무)</strong><br />
			① 회원은 회원가입 신청 또는 회원정보 변경 시 모든 사항을 사실에 근거하여 본인의 정확한 정보로 작성하여야 하며, 허위 또는 타인의 정보를 등록할 경우 이와 관련된 모든 권리를 주장할 수 없다.<br>
			② 회원은 관계 법령, 본 약관의 규정, 이용 안내 및 도서관이 공지한 주의사항, 도서관이 통지하는 사항 등을 준수하여야 한다.<br>
			③ 회원은 본인의 회원ID와 비밀번호를 제3자에게 이용하게 해서는 안 되며, 이용계약사항이 변경된 경우에 해당 절차를 거쳐 이를 도서관에 즉시 알려야 한다.<br>
			④ 회원은 도서관의 명시적 동의가 없는 한 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없다.<br>
			⑤ 회원은 도서관 서비스를 이용하여 얻은 정보를 도서관의 사전승낙 없이 복사, 복제, 변경, 번역, 출판·방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.<br>
			⑥ 회원은 도서관 및 제 3자의 지적 재산권을 포함한 제반 권리를 침해하거나 다음 각 호의 행위를 하여서는 안 됩니다.<br>
			   &nbsp;&nbsp;1. 다른 회원의 ID를 부정 사용하는 행위<br>
			   &nbsp;&nbsp;2. 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위<br>
			   &nbsp;&nbsp;3. 선량한 풍속, 기타 사회질서를 해하는 행위<br>
			   &nbsp;&nbsp;4. 타인의 명예를 훼손하거나 모욕하는 행위<br>
			   &nbsp;&nbsp;5. 타인의 지적재산권 등의 권리를 침해하는 행위<br>
			   &nbsp;&nbsp;6. 해킹행위 또는 컴퓨터바이러스의 유포행위<br>
			   &nbsp;&nbsp;7. 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위<br>
			   &nbsp;&nbsp;8. 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위<br>
		  <br>
		  <br>

		  <strong>제5장 손해배상 및 기타<br>
		  <br>
		  제15조 (양도금지)</strong><br />
		  회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없다.<br>
		  <br>

		  <strong>제16조 (손해배상)</strong><br />
		  도서관은 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 이에 대하여 책임을 지지 않는다. 다만, 중대한 과실에 의한 경우에는 그러하지 아니한다.<br>
		  <br>

		  <strong>제17조 (면책조항)</strong><br />
			① 도서관은 천재지변, 전쟁, 기간통신사업자의 서비스 중지 및 기타 이에 준하는 불가항력으로 인하여 서 비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제된다..<br>
			② 도서관은 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제된다..<br>
			③ 도서관은 회원의 컴퓨터 오류 등 회원의 귀책사유로 인한 서비스 이용 장애에 대해서는 책임을 지지 않는다..<br>
			④ 도서관은 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통해 얻은 자료로 인한 손해는 책임을 지지 않는다. .<br>
			⑤ 도서관은 회원이 서비스에 게재한 각종 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 대하여 책임을 지지 않으며, 회원 상호간 및 회원과 제 3자 상호 간에 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없고, 이로 인한 손해를 배상할 책임도 없다..<br>
			⑥ 도서관은 회원의 게시물을 등록 전에 사전심사 하거나 상시적으로 게시물의 내용을 확인 또는 검토하여야 할 의무가 없으며, 그 결과에 대한 책임을 지지 않는다.<br>
		  <br>

		  <strong>제18조 (관할법원)</strong><br />
			본 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 대구지방법원을 관할 법원으로 한다.<br>
		  <br>

		  <br>
		  <strong>&lt;부 칙&gt;</strong> <br>
		  본 약관은 2019년 12월 19일부터 적용한다. </p><br><br>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1"><label for="agree_codes1">이용약관 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
	
	<h4>개인정보 공동이용(제공) 내역</h4>
	<div class="Box" style="height:200px">

			<br>

			<table class="t_list tac" summary="개인정보 처리 및 위탁에 관한 안내표">
			  <caption class="disnone">
			  개인정보 처리 및 위탁에 관한 안내
			  </caption>
			  <colgroup>
			  <col width="15%"/>
			  <col width="30%"/>
			  <col width=""/>
			  <col width="15%"/>
			  </colgroup>
			  <thead>
			  <tr>
				<td>공동이용 기관</td>
				<td>공동이용 목적</td>
				<td>공동이용 항목</td>
				<td>공동이용 기간</td>
			  </tr>
			  </thead>
			  <tbody>
			  <tr>
				<td>대구광역시 공립 도서관</td>
				<td>하나의 회원번호로 대구광역시 모든 공립 도서관 이용</td>
				<td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역, 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
				<td>회원<br/>탈퇴시까지</td>
			  </tr>
			  <tr>
				<td colspan="4">개인정보 제3자 제공에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 책이음서비스 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.</td>
			  </tr>
			  </tbody>
			</table>

			<br/>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes2">개인정보의 수집·이용 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
	
	<h4>개인정보 제3자 제공 내역</h4>
	<div class="Box" style="height:200px" tabindex="0" >
		<br>

		<table class="t_list tac" summary="개인정보 처리 및 위탁에 관한 안내표">
		<caption class="disnone">개인정보 처리 및 위탁에 관한 안내</caption>
		<colgroup>
			<col width="15%"/>
			<col width="30%"/>
			<col width=""/>
			<col width="15%"/>
		</colgroup>
		<thead>
		<tr>
		<td>제공받는 기관</td>
		<td>제공목적</td>
		<td>제공항목</td>
		<td>보유기간</td>
		</tr>
		</thead>
		<tbody>
		<tr>
		<td>국립중앙도서관 및 지역센터</td>
		<td>책이음서비스 이용</td>
		<td>도서회원번호,성명,출생년도,성별, 휴대폰번호,CI값,도서대출내역</td>
		<td>회원 탈퇴시까지</td>
		</tr>
		<tr>
		<td>책이음서비스
			 참여 도서관</td>
		<td>책이음서비스를 통한 회원가입</td>
		<td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
		<td>회원 탈퇴시까지</td>
		</tr>
		<tr>
		<td colspan="4">개인정보 제3자 제공에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 책이음서비스 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.</td>
		</tr>
		</tbody>
		</table>

		<br>
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="agree_codes3" name="agree_codes" req="0001" type="checkbox" value="6"><label for="agree_codes3">개인정보 제3자 제공에 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>
</c:if>
</form:form>

	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">
			<c:if test="${engMode}">I agree</c:if>
			<c:if test="${!engMode}">재동의합니다</c:if>
		</a>
		<a href="/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=${param.menu_idx}" class="btn">
			<c:if test="${engMode}">I don't agree</c:if>
			<c:if test="${!engMode}">동의하지 않습니다</c:if>
		</a>
	</div>
	
</div>
	
