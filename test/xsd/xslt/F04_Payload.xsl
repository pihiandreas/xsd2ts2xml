<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />

	<xsl:variable name="ProcesType" select="//*[local-name()='EnergyBusinessProcess']"/>				

	<xsl:template name="AccountingPointTemplate" match="//*[local-name()='Transaction']">
		<_entities_element>
			<_name>AccountingPoint</_name>
				<_type>F04_ACP</_type>
				<xsl:element name="MeteringPointEAN">
					<xsl:value-of select="./*[local-name()='MeteringPointOfContract']/*[local-name()='Identification']" />
				</xsl:element>
				<xsl:element name="MeteringGridAreaCode">
					<xsl:value-of select="./*[local-name()='MeteringGridAreaUsedDomainLocation']/*[local-name()='Identification']" />
				</xsl:element>
		</_entities_element>

		<xsl:if test="./*[local-name()='MasterDataContract']">					
		<_entities_element>
		<entity>	
		<_name>Agreement</_name>
		<xsl:choose>
			<xsl:when test="$ProcesType='DH-312-1'">			
				<_type>F04_AGR_CNF</_type>
		   </xsl:when>
		   <xsl:otherwise>
				<_type>F04_AGR</_type>
		   </xsl:otherwise>
		</xsl:choose>		
		<xsl:element name="AgreementIdentification">
			<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='Identification']" />
		</xsl:element>
		<xsl:element name="AgreementType">
			<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='ContractType']" />
		</xsl:element>

		<!-- Only for New Sales Agreement the OrganisationIdentifier is filled from the SupplierOfContract -->		
		<xsl:choose>
			<xsl:when test="$ProcesType='DH-311-1'">			
				<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='SupplierOfContract']/*[local-name()='Identification']">
					<xsl:element name="OrganisationIdentifier">
						<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='SupplierOfContract']/*[local-name()='Identification']" />
					</xsl:element>
				</xsl:if>		
		   </xsl:when>
		   <xsl:otherwise>					
				<xsl:variable name="JuridicalSender" select="//*[local-name()='Header']/*[local-name()='JuridicalSenderEnergyParty']/*[local-name()='Identification']" />			
					<xsl:if test="$JuridicalSender">
						<xsl:element name="OrganisationIdentifier">
							<xsl:value-of select="$JuridicalSender" />
						</xsl:element>
					</xsl:if>			
		   </xsl:otherwise>
		</xsl:choose>				
			<xsl:if test="./*[local-name()='ContractReason']">
				<xsl:element name="ReasonForAgreementStart">
					<xsl:value-of select="./*[local-name()='ContractReason']" />
				</xsl:element>
			</xsl:if>
			<xsl:element name="ContactMethod">
				<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='ContactType']" />
			</xsl:element>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='DeliveryContract']">								
				<xsl:element name="IsDeliveryAgreement">
					<xsl:choose>
						<xsl:when test="./*[local-name()='MasterDataContract']/*[local-name()='DeliveryContract']='0' or ./*[local-name()='MasterDataContract']/*[local-name()='DeliveryContract']='false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>										
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='TimeLimited']">					
				<xsl:element name="IsFixedTermAgreement">
					<xsl:choose>
						<xsl:when test="./*[local-name()='MasterDataContract']/*[local-name()='TimeLimited']='0' or ./*[local-name()='MasterDataContract']/*[local-name()='TimeLimited']='false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>						
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='FixedContractStart']">
				<xsl:element name="FixedTermStartDate">
					<xsl:value-of select="replace(..//*[local-name()='MasterDataContract']/*[local-name()='FixedContractStart'], '\+00:00', 'Z')"/> 
				</xsl:element>
			</xsl:if>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='FixedContractEnd']">
				<xsl:element name="FixedTermEndDate">	
					<xsl:value-of select="replace(./*[local-name()='MasterDataContract']/*[local-name()='FixedContractEnd'], '\+00:00', 'Z')"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="InvoicingMethod">
				<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='InvoicingMethod']" />
			</xsl:element>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='NoticeBasis']">					
				<xsl:element name="IsSpecialTerminationAgreement">
					<xsl:choose>
						<xsl:when test="./*[local-name()='MasterDataContract']/*[local-name()='NoticeBasis']='0' or ./*[local-name()='MasterDataContract']/*[local-name()='NoticeBasis']='false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>						
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='NoticeDays']">
				<xsl:element name="SpecialTerminationPeriod">
					<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='NoticeDays']" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='NoticePeriod']/*[local-name()='NoticeStart']">
				<xsl:element name="TerminationPeriodStartDate">			
					<xsl:value-of select="replace(./*[local-name()='MasterDataContract']/*[local-name()='NoticePeriod']/*[local-name()='NoticeStart'], '\+00:00', 'Z')"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='NoticePeriod']/*[local-name()='NoticeEnd']">
				<xsl:element name="TerminationPeriodEndDate">
					<xsl:value-of select="replace(./*[local-name()='MasterDataContract']/*[local-name()='NoticePeriod']/*[local-name()='NoticeEnd'], '\+00:00', 'Z')" />
				</xsl:element>
			</xsl:if>
			<xsl:element name="IsInterruptionCritical">
				<xsl:choose>
					<xsl:when test="./*[local-name()='MasterDataContract']/*[local-name()='Priority']='0' or ./*[local-name()='MasterDataContract']/*[local-name()='Priority']='false'">false</xsl:when>
					<xsl:otherwise>true</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:element name="InvoicingChannel">
				<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='InvoicingChannel']" />
			</xsl:element>
			<xsl:element name="TaxCategory">
				<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='TaxCategory']" />
			</xsl:element>
			<xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='CustomerNote']">
				<xsl:element name="CustomerNote">
					<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='CustomerNote']" />
				</xsl:element>
			</xsl:if>
		<_entities>			
			<xsl:apply-templates />
		</_entities>
		</entity>		
		</_entities_element>   
		</xsl:if>		
	</xsl:template>
	<xsl:template name="ProductTemplate" match="//*[local-name()='ProductData']">
		<_entities_element>
			<entity>
				<_name>Product</_name>
				<_type>F04_PRD</_type>
				<xsl:element name="ProductCode">
					<xsl:value-of select="./*[local-name()='ProductCode']" />
				</xsl:element>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="AgreementContactTemplate" match="//*[local-name()='Contact']">
		<_entities_element>
			<entity>
				<_name>AgreementContact</_name>
				<_type>F04_ACT</_type>
				<xsl:element name="ContactPersonType">
					<xsl:value-of select="./*[local-name()='ContactType']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='GivenName']">
					<xsl:element name="GivenName">
						<xsl:value-of select="./*[local-name()='GivenName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='FamilyName']">
					<xsl:element name="FamilyName">
						<xsl:value-of select="./*[local-name()='FamilyName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='Name']">
					<xsl:element name="OtherName">
						<xsl:value-of select="./*[local-name()='Name']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='ContractCommunication']/*[local-name()='CommunicationChannel'][text()='AD01']">
					<xsl:element name="TelephoneNumber">
						<xsl:value-of select="./*[local-name()='ContractCommunication']/*[local-name()='CommunicationChannel'][text()='AD01']/../*[local-name()='CompleteNumber']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='ContractCommunication']/*[local-name()='CommunicationChannel'][text()='AD02']">
					<xsl:element name="EmailAddress">
						<xsl:value-of select="./*[local-name()='ContractCommunication']/*[local-name()='CommunicationChannel'][text()='AD02']/../*[local-name()='CompleteNumber']" />
					</xsl:element>
				</xsl:if>				
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="PostalInvoicingAddressTemplate" match="//*[local-name()='InvoicingAddress']">
		<_entities_element>
			<entity>
				<_name>PostalInvoicingAddress</_name>
				<_type>F04_PIA</_type>
				<xsl:if test="./*[local-name()='CareOf']">
					<xsl:element name="AddressNote">
						<xsl:value-of select="./*[local-name()='CareOf']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='StreetName']">
					<xsl:element name="StreetName">
						<xsl:value-of select="./*[local-name()='StreetName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='BuildingNumber']">
					<xsl:element name="BuildingNumber">
						<xsl:value-of select="./*[local-name()='BuildingNumber']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='FloorIdentification']">
					<xsl:element name="StairwellIdentification">
						<xsl:value-of select="./*[local-name()='FloorIdentification']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='RoomIdentification']">
					<xsl:element name="Apartment">
						<xsl:value-of select="./*[local-name()='RoomIdentification']" />
					</xsl:element>
				</xsl:if>
				<xsl:element name="PostalCode">
					<xsl:value-of select="./*[local-name()='Postcode']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='Pobox']">
					<xsl:element name="POBox">
						<xsl:value-of select="./*[local-name()='Pobox']" />
					</xsl:element>
				</xsl:if>
				<xsl:element name="PostOffice">
					<xsl:value-of select="./*[local-name()='CityName']" />
				</xsl:element>
				<xsl:element name="CountryCode">
					<xsl:value-of select="./*[local-name()='CountryCode']" />
				</xsl:element>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="ElectronicInvoicingAddressTemplate" match="//*[local-name()='ElectronicInvoiceAddressDetails']">
		<_entities_element>
			<entity>
				<_name>ElectronicInvoicingAddress</_name>
				<_type>F04_EIA</_type>
				<xsl:if test="./*[local-name()='ElectronicInvoiceTargetId']">
					<xsl:element name="BuyerReference">
						<xsl:value-of select="./*[local-name()='ElectronicInvoiceTargetId']" />
					</xsl:element>
				</xsl:if>
				<xsl:element name="ElectronicInvoicingAddress">
					<xsl:value-of select="./*[local-name()='ElectronicInvoiceAddress']" />
				</xsl:element>
				<xsl:element name="OperatorIdentification">
					<xsl:value-of select="./*[local-name()='ElectronicInvoiceRouter']" />
				</xsl:element>

				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="OtherInvoicingAddressTemplate" match="//*[local-name()='OtherInvoicingAddresses']">
		<_entities_element>
			<entity>
				<_name>OtherInvoicingAddress</_name>
				<_type>F04_OIA</_type>
				<xsl:if test="./*[local-name()='AddressType'][text()='AM01']">
					<xsl:element name="EmailAddress">
						<xsl:value-of select="./*[local-name()='Address']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='AddressType'][text()='AM02']">
					<xsl:element name="TelephoneNumber">
						<xsl:value-of select="./*[local-name()='Address']" />
					</xsl:element>
				</xsl:if>    
				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="CustomerTemplate" match="//*[local-name()='ConsumerInvolvedCustomerParty']">
		<_entities_element>
			<entity>
				<_name>Customer</_name>
				<_type>F04_CUS</_type>
				<xsl:element name="CustomerIdentification">
					<xsl:value-of select="./*[local-name()='Identification']" />
				</xsl:element>
				<xsl:element name="CustomerIdentificationType">
					<xsl:value-of select="./*[local-name()='IdentificationType']" />
				</xsl:element>
				<xsl:element name="CustomerType">
					<xsl:value-of select="./*[local-name()='CustomerType']" />
				</xsl:element>
				<xsl:element name="CustomerSubtype">
					<xsl:value-of select="./*[local-name()='CustomerSubType']" />
				</xsl:element>
				<xsl:element name="IsInformationRestricted">
					<xsl:choose>
						<xsl:when test="./*[local-name()='InformationRestriction']='0' or ./*[local-name()='InformationRestriction']='false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="Language">
					<xsl:value-of select="./*[local-name()='Language']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='Name']">
					<xsl:element name="CompanyName">
						<xsl:value-of select="./*[local-name()='Name']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='GivenName']">
					<xsl:element name="GivenName">
						<xsl:value-of select="./*[local-name()='GivenName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='MiddleName']">
					<xsl:element name="MiddleNames">
						<xsl:value-of select="./*[local-name()='MiddleName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='FamilyName']">
					<xsl:element name="FamilyName">
						<xsl:value-of select="./*[local-name()='FamilyName']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='DateOfBirth']">
					<xsl:element name="DateOfBirth">
						<xsl:value-of select="./*[local-name()='DateOfBirth']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='AdditionalCode']">
					<xsl:element name="AdditionalIdentification">
						<xsl:value-of select="./*[local-name()='AdditionalCode']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='CustomerCommunication']/*[local-name()='CommunicationChannel'][text()='AD01']">
					<xsl:element name="TelephoneNumber">
						<xsl:value-of select="./*[local-name()='CustomerCommunication']/*[local-name()='CommunicationChannel'][text()='AD01']/../*[local-name()='CompleteNumber']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='CustomerCommunication']/*[local-name()='CommunicationChannel'][text()='AD02']">
					<xsl:element name="EmailAddress">
						<xsl:value-of select="./*[local-name()='CustomerCommunication']/*[local-name()='CommunicationChannel'][text()='AD02']/../*[local-name()='CompleteNumber']" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='CareOf']">
					<xsl:element name="AddressNote">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='CareOf']" />
					</xsl:element>
				</xsl:if>	
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='StreetName']">
					<xsl:element name="StreetName">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='StreetName']" />
					</xsl:element>
				</xsl:if>				
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='BuildingNumber']">
					<xsl:element name="BuildingNumber">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='BuildingNumber']" />
					</xsl:element>
				</xsl:if>								
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='FloorIdentification']">
					<xsl:element name="StairwellIdentification">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='FloorIdentification']" />
					</xsl:element>
				</xsl:if>												
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='RoomIdentification']">
					<xsl:element name="Apartment">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='RoomIdentification']" />
					</xsl:element>
				</xsl:if>							
				<xsl:element name="PostalCode">
					<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='Postcode']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='Pobox']">
					<xsl:element name="POBox">
						<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='Pobox']" />
					</xsl:element>
				</xsl:if>
				<xsl:element name="PostOffice">
					<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='CityName']" />
				</xsl:element>
				<xsl:element name="CountryCode">
					<xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerAddress']/*[local-name()='CountryCode']" />
				</xsl:element>
			</entity>
		</_entities_element>
	</xsl:template>
</xsl:stylesheet>