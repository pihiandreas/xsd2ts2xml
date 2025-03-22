<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F01_MasterDataCustomerEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F01_MasterDataCustomerEvent:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />														   
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<xsl:choose>
			<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<urn17:MasterDataCustomerEventMessage>
					<urn17:MasterDataCustomerEvent>
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
							<xsl:if test=".//*[_type='F01_TRP']/StartOfOccurrence">
								<urn18:StartOfOccurrence>
									<xsl:value-of select=".//*[_type='F01_TRP']/StartOfOccurrence" />
								</urn18:StartOfOccurrence>
							</xsl:if>
							<xsl:if test=".//*[_type='F01_TRP']/OriginalMessageID">
								<urn18:OriginalBusinessDocumentReference>
									<xsl:value-of select=".//*[_type='F01_TRP']/OriginalMessageID" />
								</urn18:OriginalBusinessDocumentReference>
							</xsl:if>
							<xsl:if test=".//*[_type='F01_TRP']/Description">
								<urn18:Description>
									<xsl:value-of select=".//*[_type='F01_TRP']/Description" />
								</urn18:Description>
							</xsl:if>					
							<urn18:ConsumerInvolvedCustomerParty>
								<urn18:Identification schemeAgencyIdentifier="260">
									<xsl:value-of select=".//*[_type='F01_CUS']/CustomerIdentification" />
								</urn18:Identification>
								<urn18:IdentificationType  listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F01_CUS']/CustomerIdentificationType" />
								</urn18:IdentificationType>
								<urn18:CustomerType listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F01_CUS']/CustomerType" />
								</urn18:CustomerType>
								<xsl:if test=".//*[_type='F01_CUS']/CustomerSubtype">													
									<urn18:CustomerSubType listAgencyIdentifier="NFI">
										<xsl:value-of select=".//*[_type='F01_CUS']/CustomerSubtype" />
									</urn18:CustomerSubType>
								</xsl:if>								
								<xsl:if test=".//*[_type='F01_CUS']/PartyOwnCustomerIdentification">							
									<urn18:AlternateIdentification>
										<xsl:value-of select=".//*[_type='F01_CUS']/PartyOwnCustomerIdentification" />
									</urn18:AlternateIdentification>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/IsInformationRestricted">	
									<urn18:InformationRestriction>
										<xsl:choose>
											<xsl:when test=".//*[_type='F01_CUS']/IsInformationRestricted='false'">0</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>			
									</urn18:InformationRestriction>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/Language">							
									<urn18:Language schemeAgencyIdentifier="5">
										<xsl:value-of select=".//*[_type='F01_CUS']/Language" />
									</urn18:Language>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/CompanyName">							
									<urn18:Name>
										<xsl:value-of select=".//*[_type='F01_CUS']/CompanyName" />
									</urn18:Name>
								</xsl:if>								
								<xsl:if test=".//*[_type='F01_CUS']/GivenName">							
									<urn18:GivenName>
										<xsl:value-of select=".//*[_type='F01_CUS']/GivenName" />
									</urn18:GivenName>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/MiddleNames">							
									<urn18:MiddleName>
										<xsl:value-of select=".//*[_type='F01_CUS']/MiddleNames" />
									</urn18:MiddleName>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/FamilyName">							
									<urn18:FamilyName>
										<xsl:value-of select=".//*[_type='F01_CUS']/FamilyName" />
									</urn18:FamilyName>
								</xsl:if>
								<xsl:if test=".//*[_type='F01_CUS']/DateOfBirth">							
									<urn18:DateOfBirth>
										<xsl:value-of select=".//*[_type='F01_CUS']/DateOfBirth" />
									</urn18:DateOfBirth>
								</xsl:if>

								<xsl:if test=".//*[_type='F01_CUS']/AdditionalIdentification">							
									<urn18:AdditionalCode>
										<xsl:value-of select=".//*[_type='F01_CUS']/AdditionalIdentification" />
									</urn18:AdditionalCode>
								</xsl:if>

								<xsl:if test=".//*[_type='F01_CUS']/EmailAddress">						
									<urn18:Communication>
										<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD02</urn18:CommunicationChannel>
										<urn18:CompleteNumber>
											<xsl:value-of select=".//*[_type='F01_CUS']/EmailAddress" />
										</urn18:CompleteNumber>
									</urn18:Communication>									
								</xsl:if>									

								<xsl:if test=".//*[_type='F01_CUS']/TelephoneNumber">
									<urn18:Communication>
										<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
										<urn18:CompleteNumber>
											<xsl:value-of select=".//*[_type='F01_CUS']/TelephoneNumber" />
										</urn18:CompleteNumber>
									</urn18:Communication>									
								</xsl:if>									
								<!-- CustomerPostalAddress -->
								<xsl:if test=".//*[_type='F01_CPA']">							
									<urn18:ConsumerInvolvedCustomerAddress>
										<xsl:if test=".//*[_type='F01_CPA']/AddressNote">							
											<urn18:CareOf>
												<xsl:value-of select=".//*[_type='F01_CPA']/AddressNote" />
											</urn18:CareOf>
										</xsl:if>
										<xsl:if test=".//*[_type='F01_CPA']/StreetName">							
											<urn18:StreetName>
												<xsl:value-of select=".//*[_type='F01_CPA']/StreetName" />
											</urn18:StreetName>
										</xsl:if>
										<xsl:if test=".//*[_type='F01_CPA']/BuildingNumber">							
											<urn18:BuildingNumber>
												<xsl:value-of select=".//*[_type='F01_CPA']/BuildingNumber" />
											</urn18:BuildingNumber>
										</xsl:if>
										<xsl:if test=".//*[_type='F01_CPA']/StairwellIdentification">							
											<urn18:FloorIdentification>
												<xsl:value-of select=".//*[_type='F01_CPA']/StairwellIdentification" />
											</urn18:FloorIdentification>
										</xsl:if>
										<xsl:if test=".//*[_type='F01_CPA']/Apartment">							
											<urn18:RoomIdentification>
												<xsl:value-of select=".//*[_type='F01_CPA']/Apartment" />
											</urn18:RoomIdentification>
										</xsl:if>
										<urn18:Postcode>
											<xsl:value-of select=".//*[_type='F01_CPA']/PostalCode" />
										</urn18:Postcode>
										<xsl:if test=".//*[_type='F01_CPA']/POBox">							
											<urn18:Pobox>
												<xsl:value-of select=".//*[_type='F01_CPA']/POBox" />
											</urn18:Pobox>
										</xsl:if>
										<urn18:CityName>
											<xsl:value-of select=".//*[_type='F01_CPA']/PostOffice" />
										</urn18:CityName>
										<urn18:CountryCode schemeAgencyIdentifier="5">
											<xsl:value-of select=".//*[_type='F01_CPA']/CountryCode" />
										</urn18:CountryCode>
									</urn18:ConsumerInvolvedCustomerAddress>		
								</xsl:if>
							</urn18:ConsumerInvolvedCustomerParty>									
						</urn17:Transaction>
					</urn17:MasterDataCustomerEvent>
				</urn17:MasterDataCustomerEventMessage>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>