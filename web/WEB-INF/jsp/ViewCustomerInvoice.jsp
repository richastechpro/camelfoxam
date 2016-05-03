<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Email</title>
        <link rel="stylesheet" href="css/tablegrid.css" />
        <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="js/jspdf.debug.js"></script>
        <script type="text/javascript">
            function test_value() {
                var junkVal = document.getElementById('amttotal').value;
                junkVal = Math.floor(junkVal);
                var obStr = new String(junkVal);
                numReversed = obStr.split("");
                actnumber = numReversed.reverse();
                if (Number(junkVal) >= 0) {
                    //do nothing
                }
                else {
                    alert('wrong Number cannot be converted');
                    return false;
                }
                if (Number(junkVal) == 0) {
                    document.getElementById('finalamtwords').innerHTML = obStr + '' + 'Rupees Zero Only';
                    return false;
                }
                if (actnumber.length > 9) {
                    alert('Oops!!!! the Number is too big to covertes');
                    return false;
                }
                var iWords = ["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
                var ePlace = ['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', 'Nineteen'];
                var tensPlace = ['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety'];
                var iWordsLength = numReversed.length;
                var totalWords = "";
                var inWords = new Array();
                var finalWord = "";
                j = 0;
                for (i = 0; i < iWordsLength; i++) {
                    switch (i)
                    {
                        case 0:
                            if (actnumber[i] == 0 || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            inWords[j] = inWords[j];
                            break;
                        case 1:
                            tens_complication();
                            break;
                        case 2:
                            if (actnumber[i] == 0) {
                                inWords[j] = '';
                            }
                            else if (actnumber[i - 1] != 0 && actnumber[i - 2] != 0) {
                                inWords[j] = iWords[actnumber[i]] + ' Hundred and';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]] + ' Hundred';
                            }
                            break;
                        case 3:
                            if (actnumber[i] == 0 || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) { //here
                                inWords[j] = inWords[j] + " Thousand";
                            }
                            break;
                        case 4:
                            tens_complication();
                            break;
                        case 5:
                            if (actnumber[i] == "0" || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) {   //here 
                                inWords[j] = inWords[j] + " Lakh";
                            }
                            break;
                        case 6:
                            tens_complication();
                            break;
                        case 7:
                            if (actnumber[i] == "0" || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) { // changed here
                                inWords[j] = inWords[j] + " Crore";
                            }
                            break;
                        case 8:
                            tens_complication();
                            break;
                        default:
                            break;
                    }
                    j++;
                }
                function tens_complication() {
                    if (actnumber[i] == 0) {
                        inWords[j] = '';
                    }
                    else if (actnumber[i] == 1) {
                        inWords[j] = ePlace[actnumber[i - 1]];
                    }
                    else {
                        inWords[j] = tensPlace[actnumber[i]];
                    }
                }
                inWords.reverse();
                for (i = 0; i < inWords.length; i++) {
                    finalWord += inWords[i];
                }
                return finalWord;
            }
            function convert_amount_into_amttotal_paisa() {

                var finalWord1 = test_value();
                var finalWord2 = "";
                var val = document.getElementById('amttotal').value;
                var actual_val = document.getElementById('amttotal').value;
                document.getElementById('amttotal').value = val;
                if (val.indexOf('.') != -1)
                {
                    val = val.substring(val.indexOf('.') + 1, val.length);
                    if (val == '0' || val == '00') {
                        finalWord2 = "zero paisa only";
                    }
                    else {
                        document.getElementById('amttotal').value = val;
                        finalWord2 = test_value() + " paisa only";
                    }
                    document.getElementById('finalamtwords').innerHTML = finalWord1 + " Rupees and " + finalWord2;
                }
                else {
                    //finalWord2 =  " Zero paisa only";
                    document.getElementById('finalamtwords').innerHTML = finalWord1 + " Rupees Only";
                }
                document.getElementById('amttotal').value = actual_val;
            }
        </script>
        <script>
            //called on ready
            $(document).ready(function () {
                $("#send").hide();
                $("#senturmail").hide();
                $("#sendError").hide();
                convert_amount_into_amttotal_paisa();
            });
            //calls print function
            function CallPrint(strid) {
//                $("#divPrint11").html('');
//                $("#divPrint11").append($("#table_id").eq(0).clone()).html();

                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,width=1500,height=400,toolbar=0,scrollbars=0,sta­tus=0');
                WinPrint.document.write('<link rel="stylesheet" href="css/tablegrid.css" />');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
                prtContent.innerHTML = strOldOne;
            }
            //calls convert to pdf function
            function demoFromHTML() {
                $("#senturmail").hide();
                $("#sendError").hide();
                $("#send").show();
                var mypdfoutputdata;
                var pdf = new jsPDF('p', 'pt', 'letter');
                // source can be HTML-formatted string, or a reference
                // to an actual DOM element from which the text will be scraped.
                source = $('#testcase')[0];

                // we support special element handlers. Register them with jQuery-style 
                // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
                // There is no support for any other type of selectors 
                // (class, of compound) at this time.
                specialElementHandlers = {
                    // element with id of "bypass" - jQuery style selector
                    '#bypassme': function (element, renderer) {
                        // true = "handled elsewhere, bypass text extraction"
                        return true;
                    }
                };
                margins = {
                    top: 80,
                    bottom: 60,
                    left: 40,
                    width: 522
                };
                // all coords and widths are in jsPDF instance's declared units
                // 'inches' in this case
                pdf.fromHTML(
                        source, // HTML string or DOM elem ref.
                        margins.left, // x coord
                        margins.top, {// y coord
                            'width': margins.width, // max width of content on PDF
                            'elementHandlers': specialElementHandlers
                        },
                function (dispose) {
                    // dispose: object with X, Y of the last line add to the PDF 
                    //          this allow the insertion of new lines after html
                    mypdfoutputdata = pdf.output('dataurlstring');
                    

                }, margins);
                    var customerName = $("#customername").val();
                    var customerEmail = $("#customeremail").val();
                    $.ajax({                        
                        type: 'POST',
                        url: "sendmailinfo",
                        data: {
                            customerName: customerName,
                            customerEmail: customerEmail,
                           mypdfbase: mypdfoutputdata
                        },
                        success: function (data) {
                            if(data==='Yes'){
                              $("#send").hide();
                            $("#senturmail").show();  
                            }else{
                                $("#sendError").show();
                            }
                            

                        }, error: function () {
                        }
                    });

            }
        </script>
    </head>
    <body>
        <a href="#" onclick="javascript:demoFromHTML()" class="view button-001">Send Mail</a>  <a href="invoiceMasterLink" class="view button-001">Back</a><a href="#" class="view button-001" onclick="CallPrint('printdiv')">Print</a>
        <c:choose>
            <c:when test="${invoiceDt.isPaid=='No'}">
                <a href="editInvoiceDetailsLink?invoiceid=${invoiceDt.id}" class="view button-001">Edit</a>
            </c:when>
        </c:choose>        
        <label id="send"><h2>Sending mail <img src="images/ajax-loader.gif" alt="loader View"></h2></label><label id="senturmail"><h2>Mail sent successfully <img src="images/MB__mail_icon.png" alt="loader View"></h2></label><label id="sendError"><h2>Please Check Your Connectivity</h2></label>
        <h2>Invoice</h2>
        <div id="testcase">
            <br />
            <div id="printdiv">
                <div align="center">
                    <span>
                        <strong style="font-size:24px">
                            <p align="center">COMPANY LOGO</p>
                            <p> </p>
                        </strong>
                    </span>
                    <p> </p>
                    <span>
                        <strong style="font-size:18px">Karwox &amp; SPA India PVT LTD</strong>
                    </span>
                    <p> </p>
                    <p>Arch No. 25/26, Below Mahalaxmi Bridge, OFF DR. E. Moses RD, Mahalaxmi (W). Mumbai -400 034<br />
                        <strong>Telphone:</strong> 40028004/5&nbsp; <strong>Fax No Email: </strong>customer.first@karworx.com<br /><br />
                    </p>
                    <strong style="font-size:18px">INVOICE</strong>
                </div>
                <div class="box1" align="left" style="display: inline-block;">
                    <strong>${customerinvoiceDt.name}</strong><input type="hidden" id="customername" name="customername" value="${customerinvoiceDt.name}" />
                    <input type="hidden" name="" id="jspdfdata" value="" />
                    <br />
                    <br />
                    <br />
                    ${customerinvoiceDt.address}<br />
                    ${customerinvoiceDt.mobilenumber}<br />                    
                    ${customerinvoiceDt.email}<br /><input type="hidden" name="customeremail" id="customeremail" value="${customerinvoiceDt.email}" />
                </div>
                <div class="box2" align="right" style="display: inline-block; float: right">
                    <strong>Invoice No</strong>&nbsp;:	${param.invoiceid}<br />
                    <strong>Date</strong> :	${invoiceDt.modifydate}<br />
                    <strong>Job No. </strong>:	1179<br />
                    <strong>Vehicle Make:</strong> ${invoiceDt.vehiclemodel}<br />
                </div>
                <br />
                <br />
                <br />
                <div class="CSSTableGenerator"  >
                    <table style="overflow: auto; max-height: 10px;" >
                        <tr>
                            <td width="6%"><strong>Sr. No.</strong></td>
                            <td width="24%" ><strong>Name</strong></td>
                            <td width="29%" ><strong>MFG.</strong></td>
                            <td width="11%" ><strong>QTY</strong></td>
                            <td width="14%" align="center"><strong>Price Rs.</strong></td>
                            <!--<td width="16%"><strong>Total Amount</strong></td>-->
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${labourandpartdt}">
                            <tr>
                                <td align="center" >${count}</td>
                                <td>${ob.itemname}</td>
                                <td>${ob.mfgname}</td>
                                <td align="right">${ob.quantity}</td>
                                <td align="right">${ob.total}</td>
                                <!--<td align="right">120.00</td>-->
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>

                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td align="right"><strong>Spares total</strong></td>
                            <td align="right"><strong>${invoiceDt.sparepartsfinal}</strong></td>
                        </tr>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td align="right">&nbsp;</td>
                            <td align="right">&nbsp;</td>
                        </tr>
                    </table>
                    <table style="overflow: auto; max-height: 10px; border-bottom: thin #f4f4f4 solid">
                        <tr>
                            <td width="6%"><strong>Sr. No.</strong></td>
                            <td width="24%" ><strong>Service Name</strong></td>
                            <td width="29%" ><strong>Description</strong></td>
                            <td width="11%" ><strong>&nbsp;</strong></td>
                            <td width="14%" align="center"><strong>Labour Rs.</strong></td>
                            <!--<td width="16%"><strong>Total Amount</strong></td>-->
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${labourinventorydt}">
                            <tr>
                                <td align="center" >${count}</td>
                                <td>${ob.name}</td>
                                <td>${ob.description}</td>
                                <td align="right">&nbsp;</td>
                                <td align="right">${ob.total}</td>
                                <!--<td align="right">120.00</td>-->
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td align="right"><strong>Labour Charges total</strong></td>
                            <td align="right"><strong>${invoiceDt.labourfinal}</strong></td>
                        </tr>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td align="right">&nbsp;</td>
                            <td align="right">&nbsp;</td>
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="obva" items="${vatDetails}">
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>

                                <c:choose>
                                    <c:when test="${count==1}">
                                        <td align="right"><strong>Add ${obva.name} @ ${obva.percent}%</strong></td>
                                        <td align="right"><strong><div id="${count}"> ${invoiceDt.taxAmount1}</div></strong></td>
                                                </c:when>
                                                <c:otherwise>
                                        <td align="right"><strong>Add ${obva.name} @ ${obva.percent}%</strong></td>
                                        <td align="right"><strong><div id="me2"> ${invoiceDt.taxAmount2}</div></strong></td>
                                                </c:otherwise>

                                </c:choose>
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4"><strong> <label id="finalamtwords"></label> </strong></td>
                            <td align="right" style="background-color:#f4f4f4"><strong style="float:right">Total</strong></td>
                            <td align="right" style="background-color:#f4f4f4"><strong>${invoiceDt.amountTotal}<input type="hidden" name="amttotal" id="amttotal" value="${invoiceDt.amountTotal}" /></strong></td>
                        </tr>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <div style="padding: 7px 7px;">
                        <div class="box3" align="left" style="display: inline-block;">
                            <strong>Invoice verified </strong><br />
                            Received all old parts. I have taken the vehicle and found satisfactory
                        </div>
                        <div class="box4" style="display: inline-block;float: right">
                            <strong style="float:right">KAR WORX & SPA INDIA PVT. LTD.</strong> 
                        </div>
                        <p>
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <strong>Customer's Signature </strong><br />
                            C.E.S.Tax No. AADCB0214DSD001<br />
                            VAT TIN No. 27650980309V wef 26/04/2013 <br />
                            CST TIN No 27650980309C wef 26/04/2013 <br />
                            PAN No. AADCB0214D 
                            <br />
                            <br />
                            <strong>Terms and Conditions</strong><br />
                            1. Disputes if any will be subject to MUMBAI jurisdiction <br />
                            2. Interest @ 18% would be charged on all bills unpaid after 30 days from the date of the bill <br />"I / We hereby certify that my/our R.C. under the Mah. Value Added Tax Act 2002 is in force on the data on which the sale of the goods specified in this Tax Invoice is made by me / us and that the transaction of sale covered by this invoice has been effected by me / us and it shall be accounted for in the turnover of sales while filing of return and the due tax, if any,if any payableon the sale has been paid or shall be paid" 
                        </p>

                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
