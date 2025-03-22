<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AgreementTemplate" match="//*[local-name()='Transaction']">
       <_name>Agreement</_name>
       <_type>F06_AGR</_type>
       <xsl:element name="ReasonForAgreementEnd">
           <xsl:value-of select="./*[local-name()='Reason']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='Identification']">
       <xsl:element name="AgreementIdentification">
           <xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='Identification']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='MasterDataContract']/*[local-name()='ContractType']">
       <xsl:element name="AgreementType">
           <xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='ContractType']" />
       </xsl:element>
       </xsl:if>

          <_entities>
              <xsl:apply-templates />
          </_entities>
</xsl:template>
<xsl:template name="PostalInvoicingAddressTemplate" match="//*[local-name()='InvoicingAddress']">
<_entities_element>
   <entity>
       <_name>PostalInvoicingAddress</_name>
       <_type>F06_PIA</_type>
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
<xsl:template name="AccountingPointTemplate" match="//*[local-name()='MeteringPointOfContract']">
<_entities_element>
   <entity>
       <_name>AccountingPoint</_name>
       <_type>F06_ACP</_type>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='Identification']" />
       </xsl:element>
        <xsl:element name="MeteringGridAreaCode">
                <xsl:value-of select="//*[local-name()='Transaction']/*[ local-name()='MasterDataContract']/*[ local-name()='MeteringGridAreaUsedDomainLocation']/*[ local-name()='Identification']" />
       </xsl:element>
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
       <_type>F06_CUS</_type>
       <xsl:if test="./*[local-name()='Identification']">
       <xsl:element name="CustomerIdentification">
           <xsl:value-of select="./*[local-name()='Identification']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="CustomerIdentificationType">
           <xsl:value-of select="./*[local-name()='IdentificationType']" />
       </xsl:element>
       <xsl:element name="CustomerType">
           <xsl:value-of select="./*[local-name()='CustomerType']" />
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
       <xsl:element name="MiddleName">
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

          <_entities>
              <xsl:apply-templates />
          </_entities>
      </entity>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
