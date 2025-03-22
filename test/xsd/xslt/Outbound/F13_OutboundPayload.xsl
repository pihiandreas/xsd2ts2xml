<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:invoicing:F13_InvoicingDataInfo:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:invoicing:F13_InvoicingDataInfo:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />														   
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<xsl:choose>
			<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<urn17:InvoicingDataInfoMessage>
					<urn17:InvoicingDataInfo>
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
							<!--No information on what to add to this senderRouting information yet
					<urn2:SenderRoutingInformation>?</urn2:SenderRoutingInformation>
					-->
						</urn17:Header>
						<urn17:ProcessEnergyContext>
							<xsl:if test="ExternalTransactionType">
								<urn3:EnergyBusinessProcess>
									<xsl:value-of select="ExternalTransactionType" />
								</urn3:EnergyBusinessProcess>
							</xsl:if>
							<xsl:if test="ProcessRole">
								<urn3:EnergyBusinessProcessRole>
									<xsl:value-of select="ProcessRole" />
								</urn3:EnergyBusinessProcessRole>
							</xsl:if>
							<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
						</urn17:ProcessEnergyContext>
						<xsl:for-each select=".//*[_type='F13_IVD']">	
							<urn17:Transaction>
								<urn18:TransactionIdentification>
									<xsl:value-of select="TransactionIdentification" /> 
								</urn18:TransactionIdentification>
								<urn18:MeteringPoint schemeAgencyIdentifier="9">
									<xsl:value-of select="MeteringPointEAN" />
								</urn18:MeteringPoint>
								<urn18:AuthorContract>
									<xsl:value-of select="AuthorAgreementIdentification" /> 
								</urn18:AuthorContract>
								<xsl:if test="RecipientAgreementIdentification">
									<urn18:RecipientContract>
										<xsl:value-of select="RecipientAgreementIdentification" />
									</urn18:RecipientContract>
								</xsl:if>
								<urn18:AuthorPartyIdentification schemeAgencyIdentifier="9">
									<xsl:value-of select="AuthorPartyIdentification" />
								</urn18:AuthorPartyIdentification>
								<urn18:RecipientPartyIdentification schemeAgencyIdentifier="9">
									<xsl:value-of select="RecipientPartyIdentification" />
								</urn18:RecipientPartyIdentification>
								<urn18:InvoicingPeriod>
									<xsl:if test="InvoiceIdentifier" >
										<urn18:InvoiceIdentification>
											<xsl:value-of select="InvoiceIdentifier" />
										</urn18:InvoiceIdentification>
									</xsl:if>
									<urn18:InvoiceCreationDate>
										<xsl:value-of select="InvoiceCreationDate" />
									</urn18:InvoiceCreationDate>
									<urn18:Start>
										<xsl:value-of select="InvoicingPeriodStartTime" />
									</urn18:Start>
									<urn18:End>
										<xsl:value-of select="InvoicingPeriodEndTime" />
									</urn18:End>
								</urn18:InvoicingPeriod>
								<xsl:for-each select=".//*[_type='F13_NTF']">
									<urn18:InvoicingRow>
										<xsl:if test="InvoiceRowIdentifier" >
											<urn18:RowIdentification>
												<xsl:value-of select="InvoiceRowIdentifier" />
											</urn18:RowIdentification>
										</xsl:if>
										<urn18:ProductIdentification>
											<xsl:value-of select="ProductCode" />
										</urn18:ProductIdentification>
										<urn18:ProductComponentIdentification>
											<xsl:value-of select="ProductComponentCode" />
										</urn18:ProductComponentIdentification>
										<urn18:Price>
											<xsl:value-of select="Price" />
										</urn18:Price>
										<urn18:PriceUnit>
											<xsl:value-of select="PriceUnit" />
										</urn18:PriceUnit>
										<xsl:if test="PriceUnitIdentification" >
											<urn18:PriceUnitCode>
												<xsl:value-of select="PriceUnitIdentification" />
											</urn18:PriceUnitCode>
										</xsl:if>
										<urn18:Currency>
											<xsl:value-of select="Currency" />
										</urn18:Currency>
										<urn18:TaxIncluded>
											<xsl:choose>
												<xsl:when test="IsPriceTaxIncluded='false'">0</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>			
										</urn18:TaxIncluded>
										<urn18:Volume>
											<xsl:value-of select="Quantity" />
										</urn18:Volume>
										<urn18:VolumeUnit>
											<xsl:value-of select="QuantityUnit" />
										</urn18:VolumeUnit>
										<xsl:if test="QuantityUnitIdentification" >
											<urn18:VolumeUnitCode>
												<xsl:value-of select="QuantityUnitIdentification" />
											</urn18:VolumeUnitCode>
										</xsl:if>
										<urn18:Amount>
											<xsl:value-of select="InvoiceRowTotal" />
										</urn18:Amount>
										<xsl:if test="Description" >
											<urn18:Description>
												<xsl:value-of select="Description" />
											</urn18:Description>
										</xsl:if>
										<urn18:Tax>
											<xsl:value-of select="VATPercentage" />
										</urn18:Tax>
										<urn18:Start>
											<xsl:value-of select="InvoiceRowStartTime" />
										</urn18:Start>
										<urn18:End>
											<xsl:value-of select="InvoiceRowEndTime" />
										</urn18:End>
									</urn18:InvoicingRow>
								</xsl:for-each>
							</urn17:Transaction>
						</xsl:for-each>
					</urn17:InvoicingDataInfo>
				</urn17:InvoicingDataInfoMessage>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>