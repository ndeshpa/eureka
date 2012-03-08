<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/template.tld" prefix="template"%>


<template:insert template="/templates/eureka_main.jsp">

	<template:content name="sidebar">
		    <img src="${pageContext.request.contextPath}/images/clinical_analytics.jpg" />
	</template:content>
	
	<template:content name="content">
    <div class="help">
		<h3>Help</h3>
		<p>This help page provides a basic overview of the functionality of Eureka! Clinical Analytics.<br />
	    click <a href="docs/demo.swf" target="_self">here</a> for a demo of how to use this site </p>
        <h5>Browser Compatibility</h5>
        <p>We have made a great deal of effort to support recent versions of   major browsers (Firefox, Safari, Chrome and Internet Explorer), though   we have not tested every version. We have tested on Mac OS X (Snow   Leopard and Lion), Windows 7 and the Ubuntu and Mint Linux   distributions. Firefox and Internet Explorer have received the most   testing. If you encounter an issue while using your favorite browser, we   encourage you to try Firefox or Internet Explorer instead. Please   report the issue using the email address in the Contact page.</p>
        <h5>First Time</h5>
        <p>The first time that you go to Eureka! in your browser, you will see a   button bar underneath the Eureka! logo. On the left side of the button   bar, there are buttons for getting Help (what you are looking at right   now), requesting an account on Eureka! (Register), learning more about   the Eureka! Clinical Analytics project (About) and getting contact   information for technical support (Contact). On the right-hand-side,   there initially is a single button to login to your account (Login),   which you may use after you have registered with Eureka! Clinical   Analytics and your account has been created.</p>
        <h5>Registration</h5>
      <p>To obtain a user account on the website, click Register in the button   bar. You must provide your first and last name, an organization name,   an email address that will serve as your user id, and a password   (minimum 8 characters). You then will need to click the checkbox next to   &quot;End User Agreement&quot;, which means that you agree to its terms (please   click the &quot;End User Agreement&quot; link to read!). Then, click Submit. You   will receive an email at the entered email address with instructions to   verify that it was you who requested the account.</p>
        <p>After you verify your account request, your account will be created   within 3 business days. You will receive another email when your   account has been created and is ready to use. If you do not receive this   email within the specified timeframe, send an email to the address   listed in the Contact page for help.</p>
        <h5>First Time Login</h5>
        <p>Once your account is ready to use, go to the website and click the   Login button on the right-hand side of the button bar. You will enter   the email address and password that you specified in the Register page.   If you have forgotten which of your email addresses that you used or   your password, please follow the instructions on the Contact page for   getting help.</p>
        <h5>Operation</h5>
        <p>After you have logged in, your email address will be displayed on the   right-hand-side of the button bar. Next to it, you will find buttons   for ending your session (Logout), uploading data to i2b2 (Upload Data),   and going to i2b2 (i2b2). You also will see an additional button on the   left-hand side of the button bar called Account, which if clicked will   show you your account information and allow you to change your password.   After you change your password, you will receive a notification by   email. If you get this notification email and you did not change your   password, please contact us to report the incident.</p>
        <h5>Creating a Spreadsheet</h5>
        <p>Eureka! currently supports uploading data into i2b2 from an Excel   spreadsheet with the xlsx extension. The spreadsheet's contents must   conform to a specific format and the data must be represented in a   certain way for Eureka! to recognize the data and load it into i2b2   properly.</p>
        <p>Eureka! comes with a sample spreadsheet that conforms to the proper   format. To get it, click the Upload Data button in the button bar, and   then click the &quot;Download Sample Spreadsheet&quot; link. This spreadsheet   contains synthetically generated data. Little attempt was made to make   the data look like it came from real patients – it is there purely as an   example. We highly recommend that when creating your own datasets that,   instead of beginning with a blank spreadsheet, you start with this   spreadsheet and replace the data with your own. </p>
        <p>The sample spreadsheet has multiple tabs. The tabs each represents a   kind of database table. Each row is a record and each column represents   an attribute. The tabs are &quot;linked&quot; to each other through primary and   foreign key relationships as described below that link patients to   encounters, encounters to providers, etc. Note that while some tabs   contain columns for storing data that are HIPAA identifiers (e.g.,   patient name), it is YOUR responsibility not to put real patient data in   those fields. For more information on what constitutes a HIPAA   identifier, consult your institution's Institutional Review Board (IRB). </p>
        <p>The tabs are as follows:</p>
        <p><strong>Patient</strong>: contains patient name (name_first and name_last) and   demographics (dob, language, marital_status, race and gender). The   patient_key field represents an unique identifier or key for each   patient. There should be one row or record per patient.</p>
        <p><strong>Provider</strong>: represents healthcare providers in the dataset. It   has columns for each provider's first name (name_first) and last name   (name_last). The provider_key column represents a unique primary key   for each provider. There should be one row or record per provider.</p>
        <p><strong>Encounter</strong>: contains the encounter start and end date/time   (start_ts and end_ts), the type of the encounter (encounter_type) and   the encounter's discharge status (discharge_disp).  The encounter_key   column contains a unique id for each encounter. The patient_key column   contains the key of the patient in the patient tab whose encounter this   was. The provider_key column contains the key of the provider (from the   provider tab) that was the healthcare provider of record for the   encounter. There should be one row or record per encounter in your   dataset. There may be multiple encounters for a given patient.</p>
        <p><strong>eCPT</strong>: contains billing codes for procedures from the Current   Procedural Terminology (CPT). There are columns for the procedure time   (obx_ts) and the procedure code (represented as the code prefixed by   CPT:, e.g., CPT:75505). The event_key column represents a primary key   for each procedure. The encounter_key contains the key of the encounter   in which the procedure occurred. Eureka! knows about the CPT codes   listed in the metadataCPT tab. There may be multiple CPT codes for a   given encounter.</p>
        <p><strong>eICD9D</strong>: contains billing codes for diagnoses from the   International Classification of Diseases (ICD-9-CM). There are columns   for the diagnosis time (obx_ts) and the diagnosis code (represented as   the code prefixed by ICD9:, e.g., ICD9:V44.1). The event_key column   represents a primary key for each diagnosis code. The encounter_key   contains the key of the encounter in which the diagnosis was recorded.   Eureka! knows about the ICD9-CM diagnosis codes listed in the   metadataICD9D tab. There may be multiple ICD-9-CM diagnosis codes for a   given encounter.</p>
        <p><strong>eICD9P</strong>: contains billing codes for procedures from the   Internal Classification of Diseases (ICD-9-CM). There are columns for   the procedure time (obx_ts) and the procedure code (represented as the   code prefixed by ICD9:, e.g., ICD9:55.02). The event_key column   represents a primary key for each procedure. The encounter_key column   contains the key of the encounter in which the procedure occurred.   Eureka! knows about the ICD9-CM procedure codes listed in the   metadataICD9P tab. There may be multiple ICD-9-CM procedure codes for a   given encounter.</p>
        <p><strong>eMEDS</strong>: contains medication orders. The coding system is   non-standard. Available codes, descriptive strings and the classes of   medications that they represent may be found in the metadataMEDS tab.   There are columns for the order time (obx_ts) and the code for the order   (entity_id). The event_key column represents a primary key for each   order. The encounter_key column represents the key for the encounter in   which the order was made. There may be multiple medication orders for a   given encounter.</p>
        <p><strong>eLABS</strong>: contains laboratory test results. The coding system is   non-standard. Available codes, descriptive strings and classes of tests   may be found in the metadataLABS tab. There are columns for the time of   the test (obx_ts), the test code (entity_id), the result in string   (result_str) and numerical (result_num) formats, the units of the result   (units), and a flag (flag, may be blank, high, normal or low). The   event_key column represents a primary key for each test result. The   encounter_key column represents the key for the encounter in which the   laboratory test was performed. There may be multiple laboratory test   results for a given encounter.</p>
        <p><strong>eVITALS</strong>: contains vital signs. The coding system is   non-standard. Available codes, descriptive strings and classes of vital   signs may be found in the metadataVITALS tab. There are columns for the   time of the observation (obx_ts), the vital sign code (entity_id), the   result in string (result_str) and numerical (result_num) formats, the   units (units) and a flag (flag, may be blank, high, normal or low). The   event_key column represents a primary key for each vital sign   observation. The encounter_key column represents the key for the   encounter in which the vital sign was observed. There may be multiple   vital sign observations for a given encounter.</p>
        <p><strong>Metadata Tabs</strong>: contain the coding systems and terminologies   that are supported by Eureka! for representing the various data types.   These tabs all have the same column structure. There is one row per code   in the terminology. The entity_id column represents the code as   represented in Eureka!. They follow a convention of   coding_system_name:code. The description column contains the name of   each code as it will appear in i2b2. The hierarchical_location column   represents the coding system's hierarchy as it will appear in i2b2's   query user interface.</p>
        <p>The spreadsheets must have these tabs and column names, or the upload   will fail and will not be loaded into i2b2. The cells in each column   must have the same value category (e.g. Text, Number) as in the sample   spreadsheet, or the upload may fail. If codes are used that are not in   the appropriate metadata tab, you will be shown a warning on the upload   page but the upload will succeed except with the data with unknown codes   omitted.</p>
        <h5>Uploading a Spreadsheet</h5>
        <p>Once your spreadsheet is created, click the 'Choose File' button on the 'Upload Data' page and select your spreadsheet in the file chooser. The   name of the spreadsheet file should appear on the page. Then click   Upload. Once the spreadsheet has been uploaded to the Eureka! website,   it will be validated. If validation fails, the upload process will stop   and error messages will be displayed. If the spreadsheet validates with   warnings (e.g., there is one or more unknown codes in the spreadsheet),   you will see warnings but the spreadsheet will continue to load. Status   messages on the Upload Data page will tell you where in the upload   process your file is. You may logout of Eureka! while an upload is   taking place and the upload will not be disrupted. The next time you log   in and go to the Upload Data page, the status of your upload will be   displayed. When the status messages indicate that the upload has   completed, it is ready to view in i2b2.</p>
        <h5>Going to i2b2</h5>
        <p>Click the i2b2 button in the button bar to go to your own personal   i2b2 &quot;project&quot; in a separate window. You will need to login to i2b2   using the same email account and password that you used to login to   Eureka! Clinical Analytics as your username and password, respectively.   Leave the i2b2 Host as &quot;localhost&quot;. After you click Login, you will be   taken to your dataset. Click the Help button in the upper right corner   of the i2b2 user interface for directions.</p>
        <h5>Uploading a New Dataset</h5>
        <p>You only can have one dataset loaded into your i2b2 project at a   time. When you upload a new dataset after having uploaded data   previously, the old data will be deleted.</p>
        <h5>Ending Your Eureka! Session</h5>
        <p>Click the Logout button to end your Eureka! Clinical Analytics   session. It is highly recommended that you close your browser to ensure   your account's security. i2b2 has its own Logout link in the upper right   corner of the i2b2 user interface that you should use to end your i2b2   session. You may go back to i2b2 to query your dataset at any time   either by using the i2b2 button in the button bar or going directly to   i2b2 in your web browser with the URL <a href="https://eureka.cci.emory.edu/i2b2/" target="_blank" rel="nofollow">https://eureka.cci.emory.edu/i2b2/</a>.</p>
        <h5>How do I delete my user account?</h5>
        <p>Please send an email to the address on the Contact page with your   request, and we will deactivate your account and delete any data that   you have uploaded to the site.</p>
        <h5>What is your policy on retention of data uploaded to Eureka! Clinical Analytics?</h5>
        <p>Data that has been loaded successfully into i2b2 will remain on our   servers until you replace it with a new data upload or until you request   deactivation of your account. If you wish for us to delete your data at   any time, send an email to the address on the Contact page and we will   honor your request. Datasets that did not load successfully due to an   error will be deleted periodically during an automated cleanup process.   For more information on how your data is processed, stored and deleted,   send an e-mail to the address on the Contact page with your questions.</p>
        <h5>What is your policy on data privacy?</h5>
        <p>Our policy is not to release your personal information or datasets to   anyone. We may disclose to parties outside Eureka! Clinical Analytics   if disclosure is needed to comply with a law, regulation or compulsory   legal request. Keep in mind that this is a beta website, thus it is   possible that a software flaw may cause data to be disclosed   accidentally. You agreed to accept this liability when you accepted the   site's End User Agreement. We may collect summary statistics on the   usage of this site for the purpose of reporting to funding agencies,   Emory University and internal monitoring. No identifying information or   data will be included in those reports.</p>
        <h5>Troubleshooting</h5>
        <p>While we have made every effort to ensure a great experience when   using Eureka! Clinical Analytics, this is a beta product. This means   that some features may not work as expected, or you may encounter   errors. If you encounter such an issue, we encourage you to report it   using the email address on the Contact page so that we can fix it as   soon as possible. When reporting an issue, please include as much as   possible the following information: your operating system (for   example, Mac, Windows, Redhat Linux) and version, your web browser (for   example, Firefox, Chrome, Safari, Internet Explorer) and version, a   detailed description of the behavior you saw that is incorrect, and a   description of the behavior that you expected. If we are unable to   reproduce what you saw, we may contact you via email for more   information.</p>
        <h5>Getting More Help</h5>
        <p>If you did not find the answer to your question or the solution to   your problem here, please go to the Contact page and send an e-mail to   the address provided. We will get back to you shortly!</p>
        <p class="pad_top">&nbsp;</p>
        </div>
	</template:content>
	<template:content name="subcontent">
		<div id="release_notes">
			<h3>
				<img src="${pageContext.request.contextPath}/images/rss.png"
					border="0" /> Related News <a href="xml/rss_news.xml" class="rss"></a>
			</h3>
			<script language="JavaScript"
				src="http://feed2js.org//feed2js.php?src=http%3A%2F%2Fwhsc.emory.edu%2Fhome%2Fnews%2Freleases%2Fresearch.rss&chan=y&num=4&desc=1&utf=y"
				charset="UTF-8" type="text/javascript"></script>

			<noscript>
				<a style="padding-left: 35px"
					href="http://feed2js.org//feed2js.php?src=http%3A%2F%2Fwhsc.emory.edu%2Fhome%2Fnews%2Freleases%2Fresearch.rss&chan=y&num=4&desc=200>1&utf=y&html=y">View
					RSS feed</a>
			</noscript>

		</div>
	</template:content>
</template:insert>