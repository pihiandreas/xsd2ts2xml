<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
	xmlns:urn17="urn:fi:Datahub:mif:query:F16_PartyInfo:v1" 
    xmlns:urn18="urn:fi:Datahub:mif:query:F16_PartyInfo:elements:v1">
	<xsl:import href="AcknowledgementTransaction.xsl" />		
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">

		<!-- In case of reject or Accept transaction import the AcknowledgementTransaction XSLT otherwise perform the F20 XSLT -->
		<xsl:choose>
			<xsl:when test=".//*[_type='REJECT_TRANSACTION'] or .//*[_type='ACCEPT_TRANSACTION']">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<urn17:PartyInfoMessage>
					<urn17:PartyInfo>
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
						<!-- Loop for Transaction -->
						<xsl:for-each select=".//*[_type='F16_ORG']">						
							<urn17:Transaction>
								<urn18:AuthorizationPeriod>
									<urn18:Start>
										<xsl:value-of select="EffectiveFromDate" />
									</urn18:Start>
									<urn18:PartyIdentification schemeAgencyIdentifier="9">
										<xsl:value-of select="OrganisationIdentifier" />
									</urn18:PartyIdentification>
									<urn18:PartyType listAgencyIdentifier="NFI">
										<xsl:choose>
											<xsl:when test="MarketRole='DDQ'">AS01</xsl:when>
											<xsl:when test="MarketRole='DSO'">AS02</xsl:when>
											<xsl:when test="MarketRole='THP'">AS03</xsl:when>
										</xsl:choose>
									</urn18:PartyType>
									<urn18:OrganizationStatus listAgencyIdentifier="NFI">
										<xsl:choose>
											<xsl:when test="Status='NEW'">AW01</xsl:when>
											<xsl:when test="Status='ACT'">AW02</xsl:when>
											<xsl:when test="Status='INA'">AW03</xsl:when>
										</xsl:choose>
									</urn18:OrganizationStatus>								
									<urn18:PartyId>
										<xsl:value-of select="RegistrationCOC" />
									</urn18:PartyId>
									<urn18:PartyName>
										<xsl:value-of select="Name" />
									</urn18:PartyName>
									<urn18:InvoicingChannel listAgencyIdentifier="NFI">
										<xsl:value-of select="InvoicingChannel" />
									</urn18:InvoicingChannel>
									<urn18:CountryCode schemeAgencyIdentifier="5">
										<xsl:value-of select="CountryCode" />
									</urn18:CountryCode>
									<xsl:if test="MarketRole='DSO'">
										<urn18:ConsolidateInvoicing>
											<xsl:choose>
												<xsl:when test="IsCombinedInvoicing='false'">0</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>
										</urn18:ConsolidateInvoicing>
									</xsl:if>
									<!-- Loop for Contact -->
									<xsl:for-each select=".//*[_type='F16_OCT']">
										<urn18:Contact>
											<urn18:ContactType listAgencyIdentifier="NFI">
												<xsl:value-of select="ContactRoleCode" />
											</urn18:ContactType>
											<xsl:if test="FirstName">
												<urn18:GivenName>
													<xsl:value-of select="FirstName" />
												</urn18:GivenName>
											</xsl:if>
											<xsl:if test="LastName">
												<urn18:FamilyName>
													<xsl:value-of select="LastName" />
												</urn18:FamilyName>
											</xsl:if>
											<xsl:if test="FullName">
												<urn18:Name>
													<xsl:value-of select="FullName" />
												</urn18:Name>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="PhoneNumber1">
													<urn18:Communication>
														<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD01</urn18:CommunicationChannel>
														<urn18:CompleteNumber>
															<xsl:value-of select="PhoneNumber1" />
														</urn18:CompleteNumber>
													</urn18:Communication>
												</xsl:when>
												<xsl:when test="EmailAddress">
													<urn18:Communication>
														<urn18:CommunicationChannel listAgencyIdentifier="NFI">AD02</urn18:CommunicationChannel>
														<urn18:CompleteNumber>
															<xsl:value-of select="EmailAddress" />
														</urn18:CompleteNumber>
													</urn18:Communication>
												</xsl:when>
											</xsl:choose>
										</urn18:Contact>
									</xsl:for-each>
									<!-- Loop for InvoicingAddress -->
									<xsl:for-each select=".//*[_type='F16_OAD']">
										<xsl:if test="AddressType='BJ01' or AddressType='BJ02' or AddressType='BJ03'">								
											<urn18:InvoicingAddress>
												<urn18:InvoicingAddressType  listAgencyIdentifier="NFI">
													<xsl:value-of select="AddressType" />
												</urn18:InvoicingAddressType>
												<xsl:if test="AddressDescription">
													<urn18:CareOf>
														<xsl:value-of select="AddressDescription" />
													</urn18:CareOf>
												</xsl:if>
												<xsl:if test="StreetName">
													<urn18:StreetName>
														<xsl:value-of select="StreetName" />
													</urn18:StreetName>
												</xsl:if>
												<xsl:if test="BuildingNumber">
													<urn18:BuildingNumber>
														<xsl:value-of select="BuildingNumber" />
													</urn18:BuildingNumber>
												</xsl:if>
												<xsl:if test="FloorID">
													<urn18:FloorIdentification>
														<xsl:value-of select="FloorID" />
													</urn18:FloorIdentification>
												</xsl:if>
												<xsl:if test="RoomID">
													<urn18:RoomIdentification>
														<xsl:value-of select="RoomID" />
													</urn18:RoomIdentification>
												</xsl:if>
												<urn18:Postcode>
													<xsl:value-of select="Postcode" />
												</urn18:Postcode>
												<xsl:if test="PostOfficeBox">
													<urn18:Pobox>
														<xsl:value-of select="PostOfficeBox" />
													</urn18:Pobox>
												</xsl:if>
												<urn18:CityName>
													<xsl:value-of select="CityName" />
												</urn18:CityName>
												<urn18:CountryCode schemeAgencyIdentifier="5">
													<xsl:value-of select="CountryCode" />
												</urn18:CountryCode>
											</urn18:InvoicingAddress>
										</xsl:if>										
									</xsl:for-each>
									<!-- ElectronicInvoicingAddress -->
									<xsl:if test="ElectronicInvoiceAddress">
										<urn18:ElectronicInvoicingAddress>
											<xsl:if test="InvoicingDirective">
												<urn18:Target>
													<xsl:value-of select="InvoicingDirective" />
												</urn18:Target>
											</xsl:if>
											<urn18:ElectronicInvoicingAddress>
												<xsl:value-of select="ElectronicInvoiceAddress" />
											</urn18:ElectronicInvoicingAddress>
											<urn18:MediatorIdentification>
												<xsl:value-of select="InvoicingMediator" />
											</urn18:MediatorIdentification>
										</urn18:ElectronicInvoicingAddress>
									</xsl:if>
									<!-- BankInfo -->
									<xsl:if test="IBAN">
										<urn18:BankInfo>
											<urn18:IBAN>
												<xsl:value-of select="IBAN" />
											</urn18:IBAN>
											<urn18:BankName>
												<xsl:value-of select="BankName" />
											</urn18:BankName>
											<urn18:SWIFT>
												<xsl:value-of select="BIC" />
											</urn18:SWIFT>
										</urn18:BankInfo>
									</xsl:if>
									<!-- Loop for ConsumerInvolvedCustomerAddress -->
									<xsl:for-each select=".//*[_type='F16_OAD']">
										<xsl:if test="AddressType='PST'">
											<urn18:ConsumerInvolvedCustomerAddress>
												<xsl:if test="AddressDescription">
													<urn18:CareOf>
														<xsl:value-of select="AddressDescription" />
													</urn18:CareOf>
												</xsl:if>
												<xsl:if test="StreetName">
													<urn18:StreetName>
														<xsl:value-of select="StreetName" />
													</urn18:StreetName>
												</xsl:if>
												<xsl:if test="BuildingNumber">
													<urn18:BuildingNumber>
														<xsl:value-of select="BuildingNumber" />
													</urn18:BuildingNumber>
												</xsl:if>
												<xsl:if test="FloorID">
													<urn18:FloorIdentification>
														<xsl:value-of select="FloorID" />
													</urn18:FloorIdentification>
												</xsl:if>
												<xsl:if test="RoomID">
													<urn18:RoomIdentification>
														<xsl:value-of select="RoomID" />
													</urn18:RoomIdentification>
												</xsl:if>
												<urn18:Postcode>
													<xsl:value-of select="Postcode" />
												</urn18:Postcode>
												<xsl:if test="PostOfficeBox">
													<urn18:Pobox>
														<xsl:value-of select="PostOfficeBox" />
													</urn18:Pobox>
												</xsl:if>
												<urn18:CityName>
													<xsl:value-of select="CityName" />
												</urn18:CityName>
												<urn18:CountryCode schemeAgencyIdentifier="5">
													<xsl:value-of select="CountryCode" />
												</urn18:CountryCode>
											</urn18:ConsumerInvolvedCustomerAddress>
										</xsl:if>
									</xsl:for-each>
								</urn18:AuthorizationPeriod>														
							</urn17:Transaction>
						</xsl:for-each>
					</urn17:PartyInfo>
				</urn17:PartyInfoMessage>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
</xsl:stylesheet>