<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F11_MasterDataProductEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F11_MasterDataProductEvent:elements:v1">
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
							<urn18:ProductIdentification>
								<xsl:value-of select=".//*[_type='F11_PRD']/ProductCode" />
							</urn18:ProductIdentification>
							<xsl:if test=".//*[_type='F11_PRD']/ProductDescription">
								<urn18:ProductDescription>
									<xsl:value-of select=".//*[_type='F11_PRD']/ProductDescription" />
								</urn18:ProductDescription>
							</xsl:if>
							<urn18:ProductStatus>
									<xsl:choose>
									   <xsl:when test=".//*[_type='F11_PRD']/ProductStatus='CFD'">1</xsl:when>
									   <xsl:otherwise>0</xsl:otherwise>
								   </xsl:choose>
							</urn18:ProductStatus>
							<urn18:ValidityTime>
								<urn18:Start>
									<xsl:value-of select=".//*[_type='F11_TRP']/StartOfOccurrence" />
								</urn18:Start>
								<xsl:if test=".//*[_type='F11_TRP']/EndOfOccurrence">
									<urn18:End>
										<xsl:value-of select=".//*[_type='F11_TRP']/EndOfOccurrence" />
									</urn18:End>
								</xsl:if>
							</urn18:ValidityTime>
							<xsl:for-each select=".//*[_type='F11_PNM']">
								<urn18:ProductNames>
									<urn18:Language schemeAgencyIdentifier="5">
										<xsl:value-of select="ProductNameLanguage" />
									</urn18:Language>
									<urn18:ProductName>
										<xsl:value-of select="ProductName" />
									</urn18:ProductName>
								</urn18:ProductNames>
							</xsl:for-each>
							<xsl:for-each select=".//*[_type='F11_PCP']">
								<urn18:ProductComponents>
									<urn18:ProductComponentIdentification>
										<xsl:value-of select="ProductComponentCode" />
									</urn18:ProductComponentIdentification>
									<xsl:if test="PriceUnitIdentification">
										<urn18:PriceUnitCode>
											<xsl:value-of select="PriceUnitIdentification" />
										</urn18:PriceUnitCode>
									</xsl:if>
									<urn18:PriceInformationType>
										<xsl:value-of select="PriceInformationType" />
									</urn18:PriceInformationType>								
									<urn18:TaxRate>
										<xsl:value-of select="TaxRate" />
									</urn18:TaxRate>
									<xsl:for-each select=".//*[_type='F11_PCD']">
										<urn18:ProductComponentInformation>
											<urn18:Language schemeAgencyIdentifier="5">
												<xsl:value-of select="ProductComponentDataLanguage" />
											</urn18:Language>
											<urn18:ProductComponentName>
												<xsl:value-of select="ProductComponentName" />
											</urn18:ProductComponentName>
											<urn18:PriceUnit>
												<xsl:value-of select="PriceUnit" />
											</urn18:PriceUnit>
										</urn18:ProductComponentInformation>
									</xsl:for-each>
								</urn18:ProductComponents>
							</xsl:for-each>
						</urn17:Transaction>
					</urn17:MasterDataProductEvent>
				</urn17:MasterDataProductEventMessage>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>