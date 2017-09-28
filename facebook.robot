# -*- coding: robot -*-
*** Settings ***
Library          Selenium2Library
Library          verifycode.py 
Suite Setup      open browser      ${HOMEPAGE}     ${BROWSER}
Suite Teardown   close all browsers

*** Variables ***
${HOMEPAGE}          http://www.facebook.com
${BROWSER}           chrome
${firstname} 	     name=firstname
${surname}           name=lastname	
${regEmail}          name=reg_email__ 
${regEmailConfirm}   name=reg_email_confirmation__
${regpassword}       name=reg_passwd__
${year}              id=year
${sex}               sex
${female}            1
${male}              2
${createAccount}     name=websubmit
${emailUsername}     msdtest003@gmail.com
${emailPassword}     user1234
${securityID}        id=recovery_code_entry
${submit}            name=reset_action
${userNavi}          id=userNavigationLabel
${logout}            xpath=//li[contains(.,'menu_logout')]
${loginEmail}        id=email
${loginPassword}     id=pass
${loginButton}       xpath=//input[@value="Log In"]


*** Test Cases ***
Register gmail
	Set Browser Implicit Wait  10s
	Maximize Browser Window
	Page should contain  Facebook
	Input Text  ${firstname}  Spencer
	Input Text  ${surname}  zhao
	Input Text  ${regEmail}  ${emailUsername}
	Input Text  ${regEmailConfirm}  ${emailUsername}
	Input Text  ${regPassword}  ${emailPassword}
	Select From List  ${year}  1985
	Select Radio Button  ${sex}  ${male}

Get Verify Code From Gmail
	Login Gmail  ${emailUsername}  ${emailPassword}
	Click Button  ${createAccount}
	${code} =  Get Security Code  
	Input Text  ${securityID}  ${code}
	Click Button  ${submit}
	Sleep  10s
