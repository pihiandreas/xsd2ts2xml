<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" xmlns:urn17="urn:fi:Datahub:mif:masterdata:F27_MasterDataContractEvent:v1" xmlns:urn18="urn:fi:Datahub:mif:masterdata:F27_MasterDataContractEvent:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template match="entity">
		<urn17:MasterDataContractEventMessage>
			<urn17:MasterDataContractEvent>
				<urn17:Header>
					<xsl:if test="ExternalMessageID">
						<urn2:Identification>
							<xsl:value-of select="ExternalMessageID"/>
						</urn2:Identification>
					</xsl:if>
					<xsl:if test="ExternalMessageType">
						<urn2:DocumentType>
							<xsl:value-of select="ExternalMessageType"/>
						</urn2:DocumentType>
					</xsl:if>
					<xsl:if test="MessageTimestamp">
						<urn2:Creation>
							<xsl:value-of select="MessageTimestamp"/>
						</urn2:Creation>
					</xsl:if>
					<urn2:PhysicalSenderEnergyParty>
						<xsl:if test="PhysicalSender">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="PhysicalSender"/>
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalSenderEnergyParty>
					<urn2:JuridicalSenderEnergyParty>
						<xsl:if test="JuridicalSender">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="JuridicalSender"/>
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalSenderEnergyParty>
					<urn2:JuridicalRecipientEnergyParty>
						<xsl:if test="JuridicalReceiver">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="JuridicalReceiver"/>
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalRecipientEnergyParty>
					<urn2:PhysicalRecipientEnergyParty>
						<xsl:if test="PhysicalReceiver">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="PhysicalReceiver"/>
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalRecipientEnergyParty>
				</urn17:Header>
				<urn17:ProcessEnergyContext>
					<xsl:if test="./*/*/ExternalTransactionType">
						<urn3:EnergyBusinessProcess>
							<xsl:value-of select="./*/*/ExternalTransactionType"/>
						</urn3:EnergyBusinessProcess>
					</xsl:if>
					<xsl:if test="ProcessRole">
						<urn3:EnergyBusinessProcessRole>
							<xsl:value-of select="ProcessRole"/>
						</urn3:EnergyBusinessProcessRole>
					</xsl:if>
					<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
				</urn17:ProcessEnergyContext>
				<urn17:Transaction>
					<xsl:if test=".//*[_type='F27_TRP']/StartOfOccurrence">
						<urn18:StartOfOccurrence>
							<xsl:value-of select=".//*[_type='F27_TRP']/StartOfOccurrence"/>
						</urn18:StartOfOccurrence>
					</xsl:if>
					<xsl:if test=".//*[_type='F27_TRP']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='F27_TRP']/OriginalMessageID"/>
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
					<xsl:if test=".//*[_type='F27_TRP']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F27_TRP']/OriginalMessageSender"/>
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<urn18:MeteringPointOfContract>
						<urn18:Identification schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F27_ACP']/MeteringPointEAN"/>
						</urn18:Identification>
					</urn18:MeteringPointOfContract>
					<urn18:MeteringGridAreaUsedDomainLocation>
						<urn18:Identification schemeAgencyIdentifier="305">
							<xsl:value-of select=".//*[_type='F27_ACP']/MeteringGridAreaCode"/>
						</urn18:Identification>
					</urn18:MeteringGridAreaUsedDomainLocation>
					<urn18:MasterDataContract>
						<urn18:Identification>
							<xsl:value-of select=".//*[_type='F27_AGR']/AgreementIdentification"/>
						</urn18:Identification>
					</urn18:MasterDataContract>
				</urn17:Transaction>
			</urn17:MasterDataContractEvent>
		</urn17:MasterDataContractEventMessage>
	</xsl:template>
</xsl:stylesheet>