<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn13="urn:fi:Datahub:mif:common:ACK_Acknowledgement:v1" 
	xmlns:urn14="urn:fi:Datahub:mif:common:ACK_Acknowledgement:elements:v1"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich">

	<!--This parameters will set to enrich the fields-->
	<xsl:param name="TenantCode" select="'FGR'" />
	<xsl:param name="UserName" />
	<xsl:param name="UserIdentifier" />
	<xsl:param name="Channel" />
	<xsl:param name="ConfigVersion" />
	<xsl:param name="ProductVersion" />
	<xsl:param name="PhysicalSenderID" />
	<xsl:param name="JuridicalSenderID" />
	<xsl:param name="PhysicalReceiverID" />
	<xsl:param name="JuridicalReceiverID" />

	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<urn13:AcknowledgementMessage>
			<urn13:Acknowledgement>
				<urn13:Header>
					<xsl:if test="ExternalMessageID">
						<urn2:Identification>
							<xsl:value-of select="ExternalMessageID" />
						</urn2:Identification>
					</xsl:if>
					<xsl:choose>
						<!-- In case of MDM transaction -->	
						<xsl:when test=".//*[_type='TRANSACTION_HEADER']/PayloadType='ACK' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.NDF' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.REJ' ">
							<urn2:DocumentType>ACK</urn2:DocumentType>
							<urn2:Creation>
								<xsl:value-of select="enrich:getReceivedTimestamp()" />
							</urn2:Creation>
							<xsl:variable name="PhysicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalSenderID)"/>
							<urn2:PhysicalSenderEnergyParty>
								<xsl:if test="$PhysicalSenderID">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="$PhysicalSenderID" />
									</urn2:Identification>
								</xsl:if>
							</urn2:PhysicalSenderEnergyParty>
							<xsl:variable name="JuridicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalSenderID)"/>
							<urn2:JuridicalSenderEnergyParty>
								<xsl:if test="$JuridicalSenderID">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="$JuridicalSenderID" />
									</urn2:Identification>
								</xsl:if>
							</urn2:JuridicalSenderEnergyParty>
							<xsl:variable name="JuridicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalReceiverID)"/>
							<urn2:JuridicalRecipientEnergyParty>
								<xsl:if test="$JuridicalReceiverID">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="$JuridicalReceiverID" />
									</urn2:Identification>
								</xsl:if>
							</urn2:JuridicalRecipientEnergyParty>							
							<xsl:variable name="PhysicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalReceiverID)"/>
							<urn2:PhysicalRecipientEnergyParty>
								<xsl:if test="$PhysicalReceiverID">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="$PhysicalReceiverID" />
									</urn2:Identification>
								</xsl:if>				
							</urn2:PhysicalRecipientEnergyParty>
							<xsl:if test="ExternalMessageReference">
								<urn2:SenderRoutingInformation>
									<xsl:value-of select="ExternalMessageReference" />
								</urn2:SenderRoutingInformation>
							</xsl:if>
							<xsl:if test="RelatedExternalMessageID">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select="RelatedExternalMessageID" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>	
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="ExternalMessageType">
								<urn2:DocumentType>
									<xsl:value-of select="ExternalMessageType" />
								</urn2:DocumentType>
							</xsl:if>
							<xsl:if test="MessageTimestamp">
								<urn2:Creation>
									<xsl:value-of select="MessageTimestamp" />
								</urn2:Creation>
							</xsl:if>
							<urn2:PhysicalSenderEnergyParty>
								<xsl:if test="PhysicalSender">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="PhysicalSender" />
									</urn2:Identification>
								</xsl:if>
							</urn2:PhysicalSenderEnergyParty>
							<urn2:JuridicalSenderEnergyParty>
								<xsl:if test="JuridicalSender">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="JuridicalSender" />
									</urn2:Identification>
								</xsl:if>
							</urn2:JuridicalSenderEnergyParty>
							<urn2:JuridicalRecipientEnergyParty>
								<xsl:if test="JuridicalReceiver">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="JuridicalReceiver" />
									</urn2:Identification>
								</xsl:if>
							</urn2:JuridicalRecipientEnergyParty>
							<urn2:PhysicalRecipientEnergyParty>
								<xsl:if test="PhysicalReceiver">
									<urn2:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select="PhysicalReceiver" />
									</urn2:Identification>
								</xsl:if>				
							</urn2:PhysicalRecipientEnergyParty>
							<xsl:if test="ExternalMessageReference">
								<urn2:SenderRoutingInformation>
									<xsl:value-of select="ExternalMessageReference" />
								</urn2:SenderRoutingInformation>
							</xsl:if>			
							<!-- Default value -->										
							<xsl:if test="OriginalBusinessDocumentReference">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select="OriginalBusinessDocumentReference" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>			
							<!-- In case Accept transaction -->										
							<xsl:if test=".//*[_type='ACCEPT_TRANSACTION']/OriginalExternalMessageID">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select=".//*[_type='ACCEPT_TRANSACTION']/OriginalExternalMessageID" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>	
							<!-- In case of reject transaction -->										
							<xsl:if test=".//*[_type='REJECT_TRANSACTION']/OriginalExternalMessageID">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select=".//*[_type='REJECT_TRANSACTION']/OriginalExternalMessageID" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>
							<xsl:if test=".//*[_type='ACCEPT_MUL_TRANSACTION'] or .//*[_type='REJECT_TRANSACTION_ALL'] or .//*[_type='REJECT_TRANSACTION_PAR']">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select="OriginalExternalMessageID" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>							
						</xsl:otherwise>
					</xsl:choose>					
					<xsl:if test="MessageNumber">
						<urn2:MessageNumber>
							<xsl:value-of select="MessageNumber" />
						</urn2:MessageNumber>
					</xsl:if>
					<xsl:if test="MessagesTotal">
						<urn2:MessagesTotal>
							<xsl:value-of select="MessagesTotal" />
						</urn2:MessagesTotal>
					</xsl:if>
					<xsl:if test="RegistrationTimestamp">
						<urn2:RegistrationTimestamp>
							<xsl:value-of select="RegistrationTimestamp" />
						</urn2:RegistrationTimestamp>
					</xsl:if>
				</urn13:Header>

				<urn13:ProcessEnergyContext>
					<!--EnergyBusinessProcess-->
					<xsl:choose>
						<xsl:when test=".//*[_type='TRANSACTION_HEADER']/PayloadType='ACK' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.NDF' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.REJ' ">
							<xsl:if test="BusinessProcess">
								<xsl:choose>
									<xsl:when test="BusinessProcess='7'">
										<urn3:EnergyBusinessProcess>DH-211</urn3:EnergyBusinessProcess>
									</xsl:when>
									<xsl:when test="BusinessProcess='12'">
										<urn3:EnergyBusinessProcess>DH-221</urn3:EnergyBusinessProcess>
									</xsl:when>
									<xsl:when test="BusinessProcess='13'">
										<urn3:EnergyBusinessProcess>DH-222</urn3:EnergyBusinessProcess>
									</xsl:when>
									<xsl:when test="BusinessProcess='14'">
										<urn3:EnergyBusinessProcess>DH-223</urn3:EnergyBusinessProcess>
									</xsl:when>
									<xsl:when test="BusinessProcess='34'">
										<urn3:EnergyBusinessProcess>DH-523</urn3:EnergyBusinessProcess>
									</xsl:when>
									<xsl:otherwise>
										<urn3:EnergyBusinessProcess>
											<xsl:value-of select="BusinessProcess"/>
										</urn3:EnergyBusinessProcess>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:when>
						<xsl:when test=".//*[_type='ACCEPT_MUL_TRANSACTION'] or .//*[_type='REJECT_TRANSACTION_ALL'] or .//*[_type='REJECT_TRANSACTION_PAR']">						
							<urn3:EnergyBusinessProcess>
								<xsl:value-of select="ExternalTransactionType" />
							</urn3:EnergyBusinessProcess>				
						</xsl:when>						
						<xsl:otherwise>
							<xsl:if test=".//*[_type='TRANSACTION']/ExternalTransactionType">
								<urn3:EnergyBusinessProcess>
									<xsl:value-of select="./*/*/ExternalTransactionType" />
								</urn3:EnergyBusinessProcess>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<!--EnergyBusinessProcessRole-->
					<xsl:if test="ProcessRole">
						<xsl:choose>
							<xsl:when test="ProcessRole='1'">
								<urn3:EnergyBusinessProcessRole>EZ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='2'">
								<urn3:EnergyBusinessProcessRole>DDM</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='3'">
								<urn3:EnergyBusinessProcessRole>DDM2</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='4'">
								<urn3:EnergyBusinessProcessRole>DDK</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='5'">
								<urn3:EnergyBusinessProcessRole>DDQ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='6'">
								<urn3:EnergyBusinessProcessRole>DDX</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='7'">
								<urn3:EnergyBusinessProcessRole>DEA</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='8'">
								<urn3:EnergyBusinessProcessRole>MDR</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='9'">
								<urn3:EnergyBusinessProcessRole>SP</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='10'">
								<urn3:EnergyBusinessProcessRole>ESC</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:otherwise>
								<urn3:EnergyBusinessProcessRole>
									<xsl:value-of select="ProcessRole" />
								</urn3:EnergyBusinessProcessRole>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--EnergyIndustryClassification-->
					<xsl:choose>
						<xsl:when test="Industry">
							<xsl:choose>
								<xsl:when test="Industry='1'">
									<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
								</xsl:when>
								<xsl:otherwise>
									<urn3:EnergyIndustryClassification>
										<xsl:value-of select="Industry"/>
									</urn3:EnergyIndustryClassification>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
						</xsl:otherwise>
					</xsl:choose>
				</urn13:ProcessEnergyContext>

				<urn13:Transaction>
					<xsl:choose>
						<!-- CMD ACCEPTANCE ACKNOWLEDGEMENT-->
						<xsl:when test=".//*[_type='ACCEPT_TRANSACTION']">
							<xsl:if test=".//*[_type='ACCEPTANCE']/SuccessCode">
								<urn14:ReasonCode listAgencyIdentifier="NFI">BA01</urn14:ReasonCode>
							</xsl:if>
							<xsl:if test=".//*[_type='TRANSACTION']/BusinessProcess and .//*[_type='ACCEPT_TRANSACTION']/TransactionAcknowledgement !='true'">
								<urn14:EventReason>
									<urn14:EventReasonCode>OK-001</urn14:EventReasonCode>
									<urn14:EventReasonText>Succes</urn14:EventReasonText>
									<urn14:EventDetails>
										<xsl:value-of select=".//*[_type='TRANSACTION']/BusinessProcess" />
									</urn14:EventDetails>
								</urn14:EventReason>
							</xsl:if>
							<xsl:if test=".//*[_type='ACCEPT_TRANSACTION']/TransactionAcknowledgement ='true'">
								<urn14:SeriesDetail>
									<!--							<urn14:SendersSeriesIdentification></urn14:SendersSeriesIdentification>  
								Not filled yet-->
									<urn14:SeriesUniqueIdentification>
										<xsl:value-of select=".//*[_type='ACCEPT_TRANSACTION']/OriginalExternalTransactionID" />
									</urn14:SeriesUniqueIdentification>
									<urn14:SeriesReason>
										<urn14:SeriesReasonCode>OK-001</urn14:SeriesReasonCode>
										<urn14:SeriesReasonText>Succes</urn14:SeriesReasonText>
										<!--								<urn14:SeriesDetails></urn14:SeriesDetails>  
Not filled yet-->
									</urn14:SeriesReason>
								</urn14:SeriesDetail>
							</xsl:if>
						</xsl:when>
						<xsl:when test=".//*[_type='ACCEPT_MUL_TRANSACTION']">
							<xsl:if test=".//*[_type='ACCEPTANCE']/SuccessCode">
								<urn14:ReasonCode listAgencyIdentifier="NFI">BA01</urn14:ReasonCode>
							</xsl:if>
							<xsl:if test=".//*[_type='TRANSACTION']/BusinessProcess and .//*[_type='ACCEPT_TRANSACTION']/TransactionAcknowledgement !='true'">
								<urn14:EventReason>
									<urn14:EventReasonCode>OK-001</urn14:EventReasonCode>
									<urn14:EventReasonText>Succes</urn14:EventReasonText>
									<urn14:EventDetails>
										<xsl:value-of select=".//*[_type='TRANSACTION']/BusinessProcess" />
									</urn14:EventDetails>
								</urn14:EventReason>
							</xsl:if>
							<xsl:for-each select=".//*[_type='ACCEPT_MUL_TRANSACTION']">
								<xsl:if test="TransactionAcknowledgement ='true'">
									<urn14:SeriesDetail>
										<!--							<urn14:SendersSeriesIdentification></urn14:SendersSeriesIdentification>  
									Not filled yet-->
										<urn14:SeriesUniqueIdentification>
											<xsl:value-of select="OriginalExternalTransactionID" />
										</urn14:SeriesUniqueIdentification>
										<urn14:SeriesReason>
											<urn14:SeriesReasonCode>OK-001</urn14:SeriesReasonCode>
											<urn14:SeriesReasonText>Succes</urn14:SeriesReasonText>
											<!--								<urn14:SeriesDetails></urn14:SeriesDetails>  
	Not filled yet-->
										</urn14:SeriesReason>
									</urn14:SeriesDetail>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>

						<!--MDM specific ACKNOWLEDGEMENT -->
						<xsl:when test=".//*[_type='TRANSACTION_HEADER']/PayloadType='ACK' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.NDF' or .//*[_type='TRANSACTION_HEADER']/PayloadType='SMT.ACK.REJ' ">
							<!--Reasoncode-->
							<xsl:if test=".//*[_type='ACK']/AcknowledgementType">
								<xsl:if test=".//*[_type='ACK']/AcknowledgementType='ACK'">
									<urn14:ReasonCode listAgencyIdentifier="NFI">BA01</urn14:ReasonCode>
								</xsl:if>																
								<xsl:if test=".//*[_type='ACK']/AcknowledgementType='NAK'">
									<urn14:ReasonCode listAgencyIdentifier="NFI">BA02</urn14:ReasonCode>
								</xsl:if>
								<xsl:if test=".//*[_type='ACK']/AcknowledgementType='PAK'">
									<urn14:ReasonCode listAgencyIdentifier="NFI">BA03</urn14:ReasonCode>
								</xsl:if>
							</xsl:if>
							<!-- Optional EventReason -->
							<xsl:for-each select=".//*[_type='MRJ']">
								<urn14:EventReason>
									<urn14:EventReasonCode>
										<xsl:value-of select="enrich:getReasonCode(RejectionCode,'FGR')"/>
									</urn14:EventReasonCode>
									<urn14:EventReasonText>
										<xsl:value-of select="enrich:getErrorMessage('FGR',$PhysicalReceiverID,RejectionCode,concat('{',.//*[_type='MRD']/RejectionDetail,'}'))"/>
									</urn14:EventReasonText>
									<xsl:for-each select=".//*[_type='MRD']">
										<urn14:EventDetails>
											<xsl:value-of select="enrich:translateErrorDetails(.//*[_type='MRD']/RejectionDetail,'FGR',$PhysicalReceiverID)" />
										</urn14:EventDetails>
								</xsl:for-each>
								</urn14:EventReason>
							</xsl:for-each>
							<!-- Optional SeriesRejection -->
							<xsl:for-each select=".//*[_type='SRJ']">
								<urn14:SeriesDetail>
									<xsl:if test="RelatedExternalTransactionID">
										<urn14:SeriesUniqueIdentification>
											<xsl:value-of select="RelatedExternalTransactionID" />
										</urn14:SeriesUniqueIdentification>
									</xsl:if>
									<xsl:if test="TimeSeriesID">
										<urn14:SendersSeriesIdentification>
											<xsl:value-of select="TimeSeriesID" />
										</urn14:SendersSeriesIdentification>
									</xsl:if>
									<!-- SeriesReason -->
										<xsl:for-each select=".//*[_type='SRD']">
										<urn14:SeriesReason>
											<urn14:SeriesReasonCode>
												<xsl:value-of select="enrich:getReasonCode(RejectionCode,'FGR')"/>
											</urn14:SeriesReasonCode>
											<urn14:SeriesReasonText>
												<xsl:value-of select="enrich:getErrorMessage('FGR',$PhysicalReceiverID,RejectionCode,concat('{',RejectionDetail,'}'))"/>
											</urn14:SeriesReasonText>
											<xsl:if test="RejectionDetail">
												<urn14:SeriesDetails>
													<xsl:value-of select="enrich:translateErrorDetails(RejectionDetail,'FGR',$PhysicalReceiverID)" />
												</urn14:SeriesDetails>												
											</xsl:if>
										</urn14:SeriesReason>
									</xsl:for-each>
								</urn14:SeriesDetail>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<!-- CMD REJECTION ACKNOWLEDGEMENT -->
							<xsl:variable select="/*/*/*/PhysicalReceiverID" name="PhysicalReceiverID"/>														
							<xsl:if test=".//*[_type='REJECT_TRANSACTION']/AcknowledgementTime">
								<urn14:ReasonCode listAgencyIdentifier="NFI">BA02</urn14:ReasonCode>
							</xsl:if>
							<xsl:if test=".//*[_type='REJECT_TRANSACTION_ALL']/AcknowledgementTime">
								<urn14:ReasonCode listAgencyIdentifier="NFI">BA02</urn14:ReasonCode>
							</xsl:if>
							<xsl:if test=".//*[_type='REJECT_TRANSACTION_PAR']/AcknowledgementTime">
								<urn14:ReasonCode listAgencyIdentifier="NFI">BA03</urn14:ReasonCode>
							</xsl:if>
							<xsl:choose>
								<xsl:when test=".//*[_type='REJECT_TRANSACTION']/TransactionAcknowledgement = 'false'">
									<xsl:for-each select=".//*[_type='REJECTION']">
										<urn14:EventReason>
											<urn14:EventReasonCode>
												<xsl:value-of select="ReasonCode" />
											</urn14:EventReasonCode>
											<urn14:EventReasonText>
												<xsl:value-of select="enrich:getErrorMessage($TenantCode,$PhysicalReceiverID,ErrorCode,concat('{',ErrorDetail1,',',ErrorDetail2,',',ErrorDetail3,',',ErrorDetail4,',',ErrorDetail5,',',ErrorDetail6,',',ErrorDetail7,'}'))"/>
											</urn14:EventReasonText>
											<xsl:if test="ErrorDetail1">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail1,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail2">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail2,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail3">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail3,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail4">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail4,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail5">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail5,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail6">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail6,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
											<xsl:if test="ErrorDetail7">
												<urn14:EventDetails>
													<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail7,$TenantCode,$PhysicalReceiverID)" />
												</urn14:EventDetails>
											</xsl:if>
										</urn14:EventReason>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test=".//*[_type='REJECT_TRANSACTION_PAR']">								
									<xsl:for-each select=".//*[_type='REJECT_TRANSACTION_PAR']">
										<urn14:SeriesDetail>
											<urn14:SeriesUniqueIdentification>
												<xsl:value-of select="OriginalExternalTransactionID" />
											</urn14:SeriesUniqueIdentification>
											<xsl:for-each select=".//*[_type='REJECTION']">
												<urn14:SeriesReason>
													<urn14:SeriesReasonCode>
														<xsl:value-of select="ReasonCode" />
													</urn14:SeriesReasonCode>
													<urn14:SeriesReasonText>
														<xsl:value-of select="enrich:getErrorMessage($TenantCode,$PhysicalReceiverID,ErrorCode,concat('{',ErrorDetail1,',',ErrorDetail2,',',ErrorDetail3,',',ErrorDetail4,',',ErrorDetail5,',',ErrorDetail6,',',ErrorDetail7,'}'))"/>
													</urn14:SeriesReasonText>
													<xsl:if test="ErrorDetail1">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail1,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail2">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail2,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail3">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail3,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail4">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail4,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail5">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail5,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail6">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail6,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail7">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail7,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
												</urn14:SeriesReason>													
											</xsl:for-each>																							
										</urn14:SeriesDetail>											
									</xsl:for-each>
								</xsl:when>		
								<xsl:when test=".//*[_type='REJECT_TRANSACTION_ALL']">								
									<xsl:for-each select=".//*[_type='REJECT_TRANSACTION_ALL']">
										<urn14:SeriesDetail>
											<urn14:SeriesUniqueIdentification>
												<xsl:value-of select="OriginalExternalTransactionID" />
											</urn14:SeriesUniqueIdentification>
											<xsl:for-each select=".//*[_type='REJECTION']">
												<urn14:SeriesReason>
													<urn14:SeriesReasonCode>
														<xsl:value-of select="ReasonCode" />
													</urn14:SeriesReasonCode>	
													<urn14:SeriesReasonText>
														<xsl:value-of select="enrich:getErrorMessage($TenantCode,$PhysicalReceiverID,ErrorCode,concat('{',ErrorDetail1,',',ErrorDetail2,',',ErrorDetail3,',',ErrorDetail4,',',ErrorDetail5,',',ErrorDetail6,',',ErrorDetail7,'}'))"/>
													</urn14:SeriesReasonText>
													<xsl:if test="ErrorDetail1">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail1,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail2">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail2,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail3">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail3,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail4">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail4,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail5">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail5,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail6">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail6,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>
													<xsl:if test="ErrorDetail7">
														<urn14:SeriesDetails>
															<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail7,$TenantCode,$PhysicalReceiverID)" />
														</urn14:SeriesDetails>
													</xsl:if>												
												</urn14:SeriesReason>													
											</xsl:for-each>																							
										</urn14:SeriesDetail>											
									</xsl:for-each>
								</xsl:when>								
								<xsl:otherwise>
									<urn14:SeriesDetail>
										<urn14:SeriesUniqueIdentification>
											<xsl:value-of select=".//*[_type='REJECT_TRANSACTION']/OriginalExternalTransactionID" />
										</urn14:SeriesUniqueIdentification>
										<xsl:for-each select=".//*[_type='REJECTION']">
											<urn14:SeriesReason>
												<urn14:SeriesReasonCode>
													<xsl:value-of select="ReasonCode" />
												</urn14:SeriesReasonCode>
												<urn14:SeriesReasonText>
													<xsl:value-of select="enrich:getErrorMessage($TenantCode,$PhysicalReceiverID,ErrorCode,concat('{',ErrorDetail1,',',ErrorDetail2,',',ErrorDetail3,',',ErrorDetail4,',',ErrorDetail5,',',ErrorDetail6,',',ErrorDetail7,'}'))"/>
												</urn14:SeriesReasonText>
												<xsl:if test="ErrorDetail1">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail1,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail2">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail2,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail3">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail3,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail4">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail4,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail5">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail5,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail6">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail6,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
												<xsl:if test="ErrorDetail7">
													<urn14:SeriesDetails>
														<xsl:value-of select="enrich:translateErrorDetails(ErrorDetail7,$TenantCode,$PhysicalReceiverID)" />
													</urn14:SeriesDetails>
												</xsl:if>
											</urn14:SeriesReason>
										</xsl:for-each>
									</urn14:SeriesDetail>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</urn13:Transaction>
			</urn13:Acknowledgement>
		</urn13:AcknowledgementMessage>
	</xsl:template>
</xsl:stylesheet>