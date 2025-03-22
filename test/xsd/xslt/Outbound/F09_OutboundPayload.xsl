<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F09_RequestPowerSwitch:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F09_RequestPowerSwitch:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<urn17:RequestPowerSwitchMessage>
			<urn17:RequestPowerSwitch>
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
					<xsl:if test=".//*[_type='TRANSACTION']/ExternalTransactionType">
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
					<xsl:if test=".//*[_type='F09_TRP_DLY']/StartOfOccurrence">
						<urn18:StartOfOccurrence>
							<xsl:value-of select=".//*[_type='F09_TRP_DLY']/StartOfOccurrence" />
						</urn18:StartOfOccurrence>
					</xsl:if>
					<xsl:if test=".//*[_type='OTB_TRP']/StartOfOccurrence">
						<urn18:StartOfOccurrence>
							<xsl:value-of select=".//*[_type='OTB_TRP']/StartOfOccurrence" />
						</urn18:StartOfOccurrence>
					</xsl:if>
				    <xsl:if test=".//*[_type='OTB_TRP']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='OTB_TRP']/OriginalMessageID" />
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
					<xsl:if test=".//*[_type='F09_TRP_DLY']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='F09_TRP_DLY']/OriginalMessageID" />
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
				    <xsl:if test=".//*[_type='OTB_TRP']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='OTB_TRP']/OriginalMessageSender" />
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<xsl:if test=".//*[_type='F09_TRP_DLY']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F09_TRP_DLY']/OriginalMessageSender" />
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<urn18:MeteringPoint schemeAgencyIdentifier="9">
						<xsl:value-of select=".//*[_type='F09_ACP']/MeteringPointEAN" />
					</urn18:MeteringPoint>
					<urn18:ConnectionStatus listAgencyIdentifier="NFI">
						<xsl:value-of select=".//*[_type='F09_ACP']/ConnectionStatus" />
					</urn18:ConnectionStatus>
				    <xsl:if test=".//*[_type='F09_ACP']/Description">
						<urn18:Description>
							<xsl:value-of select=".//*[_type='F09_ACP']/Description" />
						</urn18:Description>
					</xsl:if>

					<!-- Loop for Contact -->							
					<xsl:for-each select=".//*[_type='F09_CCT']">
						<urn18:Contact>
							<urn18:ContactType listAgencyIdentifier="NFI">
								<xsl:value-of select="ContactPersonType" />
							</urn18:ContactType>
							<xsl:if test="GivenName">							
								<urn18:GivenName>
									<xsl:value-of select="GivenName" />
								</urn18:GivenName>
							</xsl:if>
							<xsl:if test="FamilyName">							
								<urn18:FamilyName>
									<xsl:value-of select="FamilyName" />
								</urn18:FamilyName>
							</xsl:if>
							<xsl:if test="OtherName">							
								<urn18:Name>
									<xsl:value-of select="OtherName" />
								</urn18:Name>
							</xsl:if>
							<urn18:Communication>
								<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
								<urn18:CompleteNumber>
									<xsl:value-of select="TelephoneNumber" />
								</urn18:CompleteNumber>
							</urn18:Communication>
						</urn18:Contact>						
					</xsl:for-each>											
				</urn17:Transaction>
			</urn17:RequestPowerSwitch>
		</urn17:RequestPowerSwitchMessage>
	</xsl:template>
</xsl:stylesheet>