<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F23_MasterDataProductEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F23_MasterDataProductEvent:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />														   
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<xsl:choose>
			<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<urn17:MasterDataProductEventMessage>
					<urn17:MasterDataProductEvent>
						<urn17:Header>
							<xsl:if test="ExternalMessageID">
								<urn2:Identification>
									<xsl:value-of select="ExternalMessageID" />
								</urn2:Identification>
							</xsl:if>			
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
							<xsl:if test="OriginalMessageID">
								<urn2:OriginalBusinessDocumentReference>
									<xsl:value-of select="OriginalMessageID" />
								</urn2:OriginalBusinessDocumentReference>
							</xsl:if>
							<!--No information on what to add to this senderRouting information yet
					<urn2:SenderRoutingInformation>?</urn2:SenderRoutingInformation>
					-->
						</urn17:Header>
						<urn17:ProcessEnergyContext>
							<xsl:if test="./*/*/ExternalTransactionType">
								<urn3:EnergyBusinessProcess>
									<xsl:value-of select="./*/*/ExternalTransactionType" />
								</urn3:EnergyBusinessProcess>
							</xsl:if>
							<xsl:if test="ProcessRole">
								<urn3:EnergyBusinessProcessRole>
									<xsl:value-of select="ProcessRole" />
								</urn3:EnergyBusinessProcessRole>
							</xsl:if>
							<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
						</urn17:ProcessEnergyContext>
						<urn17:Transaction>
							<urn18:ProductOwner schemeAgencyIdentifier="9">
								<xsl:value-of select=".//*[_type='F23_PCP']/OrganisationIdentifier" />
							</urn18:ProductOwner>
							<urn18:ProductIdentification>
								<xsl:value-of select=".//*[_type='F23_PCP']/ProductCode" />
							</urn18:ProductIdentification>
							<urn18:ProductComponentIdentification>
								<xsl:value-of select=".//*[_type='F23_PCP']/ProductComponentCode" />
							</urn18:ProductComponentIdentification>
							<urn18:Start>
								<xsl:value-of select=".//*[_type='F23_TRP']/StartOfOccurrence" />
							</urn18:Start>
							<xsl:if test=".//*[_type='F23_TRP']/EndOfOccurrence">
								<urn18:End>
									<xsl:value-of select=".//*[_type='F23_TRP']/EndOfOccurrence" />
								</urn18:End>
							</xsl:if>
							<xsl:for-each select=".//*[_type='F23_CTS']">
								<urn18:CalendarTimeSeries>
									<urn18:ReportingPeriod>
										<urn18:ResolutionDuration>
											<xsl:value-of select="ResolutionDuration" />
										</urn18:ResolutionDuration>
									</urn18:ReportingPeriod>
									<xsl:for-each select=".//*[_type='F23_CTV']">
										<urn18:CalendarTimeSeriesValues>
											<urn18:Sequence>
												<xsl:value-of select="Sequence" />
											</urn18:Sequence>
											<urn18:Value>
												<xsl:value-of select="Value" />
											</urn18:Value>
										</urn18:CalendarTimeSeriesValues>
									</xsl:for-each>
								</urn18:CalendarTimeSeries>
							</xsl:for-each>	
							<xsl:for-each select=".//*[_type='F23_PTS']">
								<urn18:PriceTimeSeries>
									<urn18:PriceReportingPeriod>
										<urn18:ResolutionDuration>
											<xsl:value-of select="ResolutionDuration" />
										</urn18:ResolutionDuration>
									</urn18:PriceReportingPeriod>
									<xsl:for-each select=".//*[_type='F23_PTV']">
										<urn18:PriceTimeSeriesValues>
											<urn18:Sequence>
												<xsl:value-of select="Sequence" />
											</urn18:Sequence>
											<urn18:Price>
												<xsl:value-of select="Price" />
											</urn18:Price>
											<urn18:PriceWithTax>
												<xsl:value-of select="PriceWithTax" />
											</urn18:PriceWithTax>
										</urn18:PriceTimeSeriesValues>
									</xsl:for-each>	
								</urn18:PriceTimeSeries>
							</xsl:for-each>	
						</urn17:Transaction>
					</urn17:MasterDataProductEvent>
				</urn17:MasterDataProductEventMessage>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>