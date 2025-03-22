<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:masterdata:F04_MasterDataContractEvent:v1" 
	xmlns:urn18="urn:fi:Datahub:mif:masterdata:F04_MasterDataContractEvent:elements:v1">
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
					<xsl:if test=".//*[_type='F04_TRP']/StartOfOccurrence">
						<urn18:StartOfOccurrence>
							<xsl:value-of select=".//*[_type='F04_TRP']/StartOfOccurrence" />
						</urn18:StartOfOccurrence>
					</xsl:if>
					<xsl:if test=".//*[_type='F04_TRP']/EndOfOccurrence">
						<urn18:EndOfOccurrence>
							<xsl:value-of select=".//*[_type='F04_TRP']/EndOfOccurrence" />
						</urn18:EndOfOccurrence>
					</xsl:if>
					<xsl:if test=".//*[_type='F04_TRP']/OriginalMessageID">
						<urn18:OriginalBusinessDocumentReference>
							<xsl:value-of select=".//*[_type='F04_TRP']/OriginalMessageID" />
						</urn18:OriginalBusinessDocumentReference>
					</xsl:if>
					<xsl:if test=".//*[_type='F04_TRP']/OriginalMessageSender">
						<urn18:OriginalBusinessDocumentSender schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F04_TRP']/OriginalMessageSender" />
						</urn18:OriginalBusinessDocumentSender>
					</xsl:if>
					<xsl:if test=".//*[_type='F04_TRP']/Description">
						<urn18:Description>
							<xsl:value-of select=".//*[_type='F04_TRP']/Description" />
						</urn18:Description>
					</xsl:if>					

					<xsl:if test=".//*[_type='F04_TRP']/IsNewGridAgreementRequired">
						<urn18:TransferContractNeeded>
							<xsl:choose>
								<xsl:when test=".//*[_type='F04_TRP']/IsNewGridAgreementRequired='false'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>			
						</urn18:TransferContractNeeded>
					</xsl:if>					
					<xsl:if test=".//*[_type='F04_AGR']/ReasonForAgreementStart">
						<urn18:ContractReason listAgencyIdentifier="NFI">
							<xsl:value-of select=".//*[_type='F04_AGR']/ReasonForAgreementStart" />
						</urn18:ContractReason>
					</xsl:if>					
					<xsl:if test=".//*[_type='F04_TRP']/IsGridAgreementAccepted">
						<urn18:ContractConfirm>
							<xsl:choose>
								<xsl:when test=".//*[_type='F04_TRP']/IsGridAgreementAccepted='false'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>			
						</urn18:ContractConfirm>
					</xsl:if>			

					<urn18:MeteringPointOfContract>							
						<urn18:Identification  schemeAgencyIdentifier="9">
							<xsl:value-of select=".//*[_type='F04_ACP']/MeteringPointEAN" />
						</urn18:Identification>
					</urn18:MeteringPointOfContract>	

					<urn18:MeteringGridAreaUsedDomainLocation>
						<urn18:Identification schemeAgencyIdentifier="305">
							<xsl:value-of select=".//*[_type='F04_ACP']/MeteringGridAreaCode" />
						</urn18:Identification>
					</urn18:MeteringGridAreaUsedDomainLocation>
					
					<xsl:if test=".//*[_type='F04_AGR']">	
						<urn18:MasterDataContract>
							<xsl:if test=".//*[_type='F04_AGR']/ContactMethod">						
								<urn18:ContactType listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F04_AGR']/ContactMethod" />
								</urn18:ContactType>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/AgreementIdentification">														
								<urn18:Identification>
									<xsl:value-of select=".//*[_type='F04_AGR']/AgreementIdentification" />
								</urn18:Identification>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/AgreementType">														
								<urn18:ContractType>
									<xsl:value-of select=".//*[_type='F04_AGR']/AgreementType" />
								</urn18:ContractType>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/IsDeliveryAgreement">														
								<urn18:DeliveryContract>
									<xsl:choose>
										<xsl:when test=".//*[_type='F04_AGR']/IsDeliveryAgreement='false'">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>			
								</urn18:DeliveryContract>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/IsFixedTermAgreement">														
								<urn18:TimeLimited>
									<xsl:choose>
										<xsl:when test=".//*[_type='F04_AGR']/IsFixedTermAgreement='false'">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>			
								</urn18:TimeLimited>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/FixedTermStartDate">
								<urn18:FixedContractStart>
									<xsl:value-of select=".//*[_type='F04_AGR']/FixedTermStartDate" />
								</urn18:FixedContractStart>
							</xsl:if>											
							<xsl:if test=".//*[_type='F04_AGR']/FixedTermEndDate">
								<urn18:FixedContractEnd>
									<xsl:value-of select=".//*[_type='F04_AGR']/FixedTermEndDate" />
								</urn18:FixedContractEnd>
							</xsl:if>					
							<xsl:if test=".//*[_type='F04_AGR']/InvoicingMethod">							
								<urn18:InvoicingMethod listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F04_AGR']/InvoicingMethod" />
								</urn18:InvoicingMethod>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/IsSpecialTerminationAgreement">								
								<urn18:NoticeBasis>
									<xsl:choose>
										<xsl:when test=".//*[_type='F04_AGR']/IsSpecialTerminationAgreement='false'">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>			
								</urn18:NoticeBasis>
							</xsl:if>													
							<xsl:if test=".//*[_type='F04_AGR']/SpecialTerminationPeriod">
								<urn18:NoticeDays>
									<xsl:value-of select=".//*[_type='F04_AGR']/SpecialTerminationPeriod" />
								</urn18:NoticeDays>
							</xsl:if>					
							<xsl:if test=".//*[_type='F04_AGR']/TerminationPeriodStartDate or .//*[_type='F04_AGR']/TerminationPeriodEndDate">
								<urn18:NoticePeriod>
									<xsl:if test=".//*[_type='F04_AGR']/TerminationPeriodStartDate">
										<urn18:NoticeStart>
											<xsl:value-of select=".//*[_type='F04_AGR']/TerminationPeriodStartDate" />
										</urn18:NoticeStart>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_AGR']/TerminationPeriodEndDate">
										<urn18:NoticeEnd>
											<xsl:value-of select=".//*[_type='F04_AGR']/TerminationPeriodEndDate" />
										</urn18:NoticeEnd>
									</xsl:if>
								</urn18:NoticePeriod>
							</xsl:if>
							<xsl:if test=".//*[_type='F04_AGR']/IsInterruptionCritical">							
								<urn18:Priority>
									<xsl:choose>
										<xsl:when test=".//*[_type='F04_AGR']/IsInterruptionCritical='false'">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>			
								</urn18:Priority>
							</xsl:if>																
							<xsl:if test=".//*[_type='F04_AGR']/InvoicingChannel">								
								<urn18:InvoicingChannel listAgencyIdentifier="NFI">
									<xsl:value-of select=".//*[_type='F04_AGR']/InvoicingChannel" />
								</urn18:InvoicingChannel>
							</xsl:if>								
							<!-- TaxCategory can be situated in transaction payload or in the agreement -->
							<xsl:if test=".//*[_type='F04_TRP']/TaxCategory">								
								<urn18:TaxCategory>
									<xsl:value-of select=".//*[_type='F04_TRP']/TaxCategory" />
								</urn18:TaxCategory>
							</xsl:if>																
							<xsl:if test=".//*[_type='F04_AGR']/TaxCategory">								
								<urn18:TaxCategory>
									<xsl:value-of select=".//*[_type='F04_AGR']/TaxCategory" />
								</urn18:TaxCategory>
							</xsl:if>																							
							<!-- Loop for Product information -->
							<xsl:for-each select=".//*[_type='F04_PRD']">
								<urn18:ProductData>
									<urn18:ProductCode>
										<xsl:value-of select="ProductCode" />
									</urn18:ProductCode>
								</urn18:ProductData>								
							</xsl:for-each>							
							<xsl:if test=".//*[_type='F04_AGR']/CustomerNote">							
								<urn18:CustomerNote>
									<xsl:value-of select=".//*[_type='F04_AGR']/CustomerNote" />
								</urn18:CustomerNote>
							</xsl:if>

							<!-- Loop for Agreement contacts -->							
							<xsl:for-each select=".//*[_type='F04_ACT']">
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
									<xsl:if test="EmailAddress">
										<urn18:ContractCommunication>
											<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD02</urn18:CommunicationChannel>
											<urn18:CompleteNumber>
												<xsl:value-of select="EmailAddress" />
											</urn18:CompleteNumber>
										</urn18:ContractCommunication>
									</xsl:if>
									<xsl:if test="TelephoneNumber">
										<urn18:ContractCommunication>
											<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
											<urn18:CompleteNumber>
												<xsl:value-of select="TelephoneNumber" />
											</urn18:CompleteNumber>
										</urn18:ContractCommunication>
									</xsl:if>
								</urn18:Contact>								
							</xsl:for-each>							
							<xsl:if test=".//*[_type='F04_PIA']">	
								<urn18:InvoicingAddress>
									<xsl:if test=".//*[_type='F04_PIA']/AddressNote">							
										<urn18:CareOf>
											<xsl:value-of select=".//*[_type='F04_PIA']/AddressNote" />
										</urn18:CareOf>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_PIA']/StreetName">							
										<urn18:StreetName>
											<xsl:value-of select=".//*[_type='F04_PIA']/StreetName" />
										</urn18:StreetName>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_PIA']/BuildingNumber">							
										<urn18:BuildingNumber>
											<xsl:value-of select=".//*[_type='F04_PIA']/BuildingNumber" />
										</urn18:BuildingNumber>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_PIA']/StairwellIdentification">							
										<urn18:FloorIdentification>
											<xsl:value-of select=".//*[_type='F04_PIA']/StairwellIdentification" />
										</urn18:FloorIdentification>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_PIA']/Apartment">							
										<urn18:RoomIdentification>
											<xsl:value-of select=".//*[_type='F04_PIA']/Apartment" />
										</urn18:RoomIdentification>
									</xsl:if>
									<urn18:Postcode>
										<xsl:value-of select=".//*[_type='F04_PIA']/PostalCode" />
									</urn18:Postcode>
									<xsl:if test=".//*[_type='F04_PIA']/POBox">							
										<urn18:Pobox>
											<xsl:value-of select=".//*[_type='F04_PIA']/POBox" />
										</urn18:Pobox>
									</xsl:if>
									<urn18:CityName>
										<xsl:value-of select=".//*[_type='F04_PIA']/PostOffice" />
									</urn18:CityName>
									<urn18:CountryCode schemeAgencyIdentifier="5">
										<xsl:value-of select=".//*[_type='F04_PIA']/CountryCode" />
									</urn18:CountryCode>
								</urn18:InvoicingAddress>								
							</xsl:if>
							<xsl:if test=".//*[_type='F04_EIA']">	
								<urn18:ElectronicInvoiceAddressDetails>
									<xsl:if test=".//*[_type='F04_EIA']/BuyerReference">							
										<urn18:ElectronicInvoiceTargetId>
											<xsl:value-of select=".//*[_type='F04_EIA']/BuyerReference" />
										</urn18:ElectronicInvoiceTargetId>
									</xsl:if>
									<urn18:ElectronicInvoiceAddress>
										<xsl:value-of select=".//*[_type='F04_EIA']/ElectronicInvoicingAddress" />
									</urn18:ElectronicInvoiceAddress>
									<urn18:ElectronicInvoiceRouter>
										<xsl:value-of select=".//*[_type='F04_EIA']/OperatorIdentification" />
									</urn18:ElectronicInvoiceRouter>
								</urn18:ElectronicInvoiceAddressDetails>									
							</xsl:if>
							<xsl:if test=".//*[_type='F04_OIA']/EmailAddress or .//*[_type='F04_OIA']/TelephoneNumber">
								<urn18:OtherInvoicingAddresses>
									<xsl:if test=".//*[_type='F04_OIA']/EmailAddress">
										<urn18:AddressType listAgencyIdentifier="NFI">AM01</urn18:AddressType>
										<urn18:Address>
											<xsl:value-of select=".//*[_type='F04_OIA']/EmailAddress" />
										</urn18:Address>
									</xsl:if>
									<xsl:if test=".//*[_type='F04_OIA']/TelephoneNumber">
										<urn18:AddressType listAgencyIdentifier="NFI">AM02</urn18:AddressType>
										<urn18:Address>
											<xsl:value-of select=".//*[_type='F04_OIA']/TelephoneNumber" />
										</urn18:Address>
									</xsl:if>
								</urn18:OtherInvoicingAddresses>
							</xsl:if>

							<xsl:if test=".//*[_type='F04_AGR']/OrganisationIdentifier">							
								<urn18:SupplierOfContract>
									<urn18:Identification schemeAgencyIdentifier="9">
										<xsl:value-of select=".//*[_type='F04_AGR']/OrganisationIdentifier" />
									</urn18:Identification>
								</urn18:SupplierOfContract>
							</xsl:if>

							<!-- Loop for Agreement Customers -->							
							<xsl:for-each select=".//*[_type='F04_CUS']">
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
									<urn18:CustomerSubType listAgencyIdentifier="NFI">
										<xsl:value-of select="CustomerSubtype" />
									</urn18:CustomerSubType>
									<urn18:InformationRestriction>
										<xsl:choose>
											<xsl:when test="IsInformationRestricted='false'">0</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>			
									</urn18:InformationRestriction>
									<urn18:Language schemeAgencyIdentifier="5">
										<xsl:value-of select="Language" />
									</urn18:Language>
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
									<xsl:if test="MiddleNames">							
										<urn18:MiddleName>
											<xsl:value-of select="MiddleNames" />
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

									<xsl:if test="AdditionalIdentification">							
										<urn18:AdditionalCode>
											<xsl:value-of select="AdditionalIdentification" />
										</urn18:AdditionalCode>
									</xsl:if>

									<xsl:if test="EmailAddress">
										<urn18:CustomerCommunication>
											<xsl:if test="EmailAddress">
												<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD02</urn18:CommunicationChannel>
												<urn18:CompleteNumber>
													<xsl:value-of select="EmailAddress" />
												</urn18:CompleteNumber>
											</xsl:if>
										</urn18:CustomerCommunication>
									</xsl:if>
									<xsl:if test="TelephoneNumber">
										<urn18:CustomerCommunication>
											<xsl:if test="TelephoneNumber">
												<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
												<urn18:CompleteNumber>
													<xsl:value-of select="TelephoneNumber" />
												</urn18:CompleteNumber>
											</xsl:if>
										</urn18:CustomerCommunication>
									</xsl:if>

									<xsl:if test=".//*[_type='F04_CPA']">	
										<urn18:ConsumerInvolvedCustomerAddress>
											<xsl:if test=".//*[_type='F04_CPA']/AddressNote">							
												<urn18:CareOf>
													<xsl:value-of select=".//*[_type='F04_CPA']/AddressNote" />
												</urn18:CareOf>
											</xsl:if>
											<xsl:if test=".//*[_type='F04_CPA']/StreetName">							
												<urn18:StreetName>
													<xsl:value-of select=".//*[_type='F04_CPA']/StreetName" />
												</urn18:StreetName>
											</xsl:if>
											<xsl:if test=".//*[_type='F04_CPA']/BuildingNumber">							
												<urn18:BuildingNumber>
													<xsl:value-of select=".//*[_type='F04_CPA']/BuildingNumber" />
												</urn18:BuildingNumber>
											</xsl:if>
											<xsl:if test=".//*[_type='F04_CPA']/StairwellIdentification">							
												<urn18:FloorIdentification>
													<xsl:value-of select=".//*[_type='F04_CPA']/StairwellIdentification" />
												</urn18:FloorIdentification>
											</xsl:if>
											<xsl:if test=".//*[_type='F04_CPA']/Apartment">							
												<urn18:RoomIdentification>
													<xsl:value-of select=".//*[_type='F04_CPA']/Apartment" />
												</urn18:RoomIdentification>
											</xsl:if>
											<urn18:Postcode>
												<xsl:value-of select=".//*[_type='F04_CPA']/PostalCode" />
											</urn18:Postcode>
											<xsl:if test=".//*[_type='F04_CPA']/POBox">							
												<urn18:Pobox>
													<xsl:value-of select=".//*[_type='F04_CPA']/POBox" />
												</urn18:Pobox>
											</xsl:if>
											<urn18:CityName>
												<xsl:value-of select=".//*[_type='F04_CPA']/PostOffice" />
											</urn18:CityName>
											<urn18:CountryCode schemeAgencyIdentifier="5">
												<xsl:value-of select=".//*[_type='F04_CPA']/CountryCode" />
											</urn18:CountryCode>
										</urn18:ConsumerInvolvedCustomerAddress>								
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