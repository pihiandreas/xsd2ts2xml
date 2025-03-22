<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F06_MasterDataContractEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F06_MasterDataContractEvent:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<urn17:MasterDataContractEventMessage>
			<urn17:MasterDataContractEvent>
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
					<xsl:if test=".//*[_type='F06_TRP']/EndOfOccurrence">
						<urn18:EndOfOccurrence>
							<xsl:value-of select=".//*[_type='F06_TRP']/EndOfOccurrence" />
						</urn18:EndOfOccurrence>
					</xsl:if>
					<xsl:if test=".//*[_type='F06_TRP']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='F06_TRP']/OriginalMessageID" />
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
					<xsl:if test=".//*[_type='F06_TRP']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F06_TRP']/OriginalMessageSender" />
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<xsl:if test=".//*[_type='F06_TRP']/Description">
						<urn18:Description>
							<xsl:value-of select=".//*[_type='F06_TRP']/Description" />
						</urn18:Description>
					</xsl:if>					
					<xsl:if test=".//*[_type='F06_AGR']/ReasonForAgreementEnd">
						<urn18:Reason listAgencyIdentifier="NFI">
							<xsl:value-of select=".//*[_type='F06_AGR']/ReasonForAgreementEnd" />
						</urn18:Reason>
					</xsl:if>					


					<xsl:if test=".//*[_type='F06_AGR']">
						<urn18:MasterDataContract>
							<xsl:if test=".//*[_type='F06_AGR']/AgreementIdentification">														
								<urn18:Identification>
									<xsl:value-of select=".//*[_type='F06_AGR']/AgreementIdentification" />
								</urn18:Identification>
							</xsl:if>													
							<xsl:if test=".//*[_type='F06_AGR']/AgreementType">														
								<urn18:ContractType>
									<xsl:value-of select=".//*[_type='F06_AGR']/AgreementType" />
								</urn18:ContractType>
							</xsl:if>													

							<xsl:if test=".//*[_type='F06_PIA']">	
								<urn18:InvoicingAddress>
									<xsl:if test=".//*[_type='F06_PIA']/AddressNote">							
										<urn18:CareOf>
											<xsl:value-of select=".//*[_type='F06_PIA']/AddressNote" />
										</urn18:CareOf>
									</xsl:if>
									<xsl:if test=".//*[_type='F06_PIA']/StreetName">							
										<urn18:StreetName>
											<xsl:value-of select=".//*[_type='F06_PIA']/StreetName" />
										</urn18:StreetName>
									</xsl:if>
									<xsl:if test=".//*[_type='F06_PIA']/BuildingNumber">							
										<urn18:BuildingNumber>
											<xsl:value-of select=".//*[_type='F06_PIA']/BuildingNumber" />
										</urn18:BuildingNumber>
									</xsl:if>
									<xsl:if test=".//*[_type='F06_PIA']/StairwellIdentification">							
										<urn18:FloorIdentification>
											<xsl:value-of select=".//*[_type='F06_PIA']/StairwellIdentification" />
										</urn18:FloorIdentification>
									</xsl:if>
									<xsl:if test=".//*[_type='F06_PIA']/Apartment">							
										<urn18:RoomIdentification>
											<xsl:value-of select=".//*[_type='F06_PIA']/Apartment" />
										</urn18:RoomIdentification>
									</xsl:if>
									<urn18:Postcode>
										<xsl:value-of select=".//*[_type='F06_PIA']/PostalCode" />
									</urn18:Postcode>
									<xsl:if test=".//*[_type='F06_PIA']/POBox">							
										<urn18:Pobox>
											<xsl:value-of select=".//*[_type='F06_PIA']/POBox" />
										</urn18:Pobox>
									</xsl:if>
									<urn18:CityName>
										<xsl:value-of select=".//*[_type='F06_PIA']/PostOffice" />
									</urn18:CityName>
									<urn18:CountryCode schemeAgencyIdentifier="5">
										<xsl:value-of select=".//*[_type='F06_PIA']/CountryCode" />
									</urn18:CountryCode>
								</urn18:InvoicingAddress>								
							</xsl:if>

							<urn18:MeteringPointOfContract>							
								<urn18:Identification  schemeAgencyIdentifier="9">
									<xsl:value-of select=".//*[_type='F06_ACP']/MeteringPointEAN" />
								</urn18:Identification>
							</urn18:MeteringPointOfContract>	

							<urn18:MeteringGridAreaUsedDomainLocation>
								<urn18:Identification schemeAgencyIdentifier="305">
									<xsl:value-of select=".//*[_type='F06_ACP']/MeteringGridAreaCode" />
								</urn18:Identification>
							</urn18:MeteringGridAreaUsedDomainLocation>

							<!-- Loop for Agreement Customers -->							
							<xsl:for-each select=".//*[_type='F06_CUS']">
								<urn18:ConsumerInvolvedCustomerParty>
									<urn18:Identification schemeAgencyIdentifier="260">
										<xsl:value-of select="CustomerIdentification" />
									</urn18:Identification>
									<urn18:IdentificationType  listAgencyIdentifier="NFI">
										<xsl:value-of select="CustomerIdentificationType" />
									</urn18:IdentificationType>
									<urn18:CustomerType listAgencyIdentifier="NFI">
										<xsl:value-of select="CustomerType" />
									</urn18:CustomerType>
									<xsl:if test="CompanyName">							
										<urn18:Name>
											<xsl:value-of select="CompanyName" />
										</urn18:Name>
									</xsl:if>								
									<xsl:if test="GivenName">							
										<urn18:GivenName>
											<xsl:value-of select="GivenName" />
										</urn18:GivenName>
									</xsl:if>
									<xsl:if test="MiddleName">							
										<urn18:MiddleName>
											<xsl:value-of select="MiddleName" />
										</urn18:MiddleName>
									</xsl:if>
									<xsl:if test="FamilyName">							
										<urn18:FamilyName>
											<xsl:value-of select="FamilyName" />
										</urn18:FamilyName>
									</xsl:if>

									<xsl:if test="DateOfBirth">							
										<urn18:DateOfBirth>
											<xsl:value-of select="DateOfBirth" />
										</urn18:DateOfBirth>
									</xsl:if>
								</urn18:ConsumerInvolvedCustomerParty>									
							</xsl:for-each>					
						</urn18:MasterDataContract>						
					</xsl:if>
				</urn17:Transaction>
			</urn17:MasterDataContractEvent>
		</urn17:MasterDataContractEventMessage>
	</xsl:template>
</xsl:stylesheet>