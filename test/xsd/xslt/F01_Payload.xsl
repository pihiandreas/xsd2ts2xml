<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="CustomerTemplate" match="//*[local-name()='Transaction']">
       <_name>Customer</_name>
       <_type>F01_CUS</_type>
       <xsl:element name="CustomerIdentification">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Identification']" />
       </xsl:element>
       <xsl:element name="CustomerIdentificationType">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='IdentificationType']" />
       </xsl:element>
       <xsl:element name="CustomerType">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='CustomerType']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='CustomerSubType']">
       <xsl:element name="CustomerSubtype">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='CustomerSubType']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='AlternateIdentification']">
       <xsl:element name="PartyOwnCustomerIdentification">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='AlternateIdentification']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='InformationRestriction']">
       <xsl:element name="IsInformationRestricted">
           <xsl:choose>
               <xsl:when test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='InformationRestriction']='0' or ./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='InformationRestriction']='false'">false</xsl:when>
               <xsl:otherwise>true</xsl:otherwise>
           </xsl:choose>
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Language']">
       <xsl:element name="Language">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Language']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Name']">
       <xsl:element name="CompanyName">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Name']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='GivenName']">
       <xsl:element name="GivenName">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='GivenName']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='MiddleName']">
       <xsl:element name="MiddleNames">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='MiddleName']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='FamilyName']">
       <xsl:element name="FamilyName">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='FamilyName']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='DateOfBirth']">
       <xsl:element name="DateOfBirth">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='DateOfBirth']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='AdditionalCode']">
       <xsl:element name="AdditionalIdentification">
           <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='AdditionalCode']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Communication']/*[local-name()='CommunicationChannel']">
<xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Communication']/*[local-name()='CommunicationChannel'][text()='AD01']">
   <xsl:element name="TelephoneNumber">
    <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Communication']/*[local-name()='CommunicationChannel'][text()='AD01']/../*[local-name()='CompleteNumber']" />
   </xsl:element>
  </xsl:if>
  <xsl:if test="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Communication']/*[local-name()='CommunicationChannel'][text()='AD02']">
   <xsl:element name="EmailAddress">
    <xsl:value-of select="./*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='Communication']/*[local-name()='CommunicationChannel'][text()='AD02']/../*[local-name()='CompleteNumber']" />
   </xsl:element>
  </xsl:if>       </xsl:if>

          <_entities>
              <xsl:apply-templates />
          </_entities>
</xsl:template>
<xsl:template name="CustomerPostalAddressTemplate" match="//*[local-name()='ConsumerInvolvedCustomerParty']/*[local-name()='ConsumerInvolvedCustomerAddress']">
<_entities_element>
   <entity>
       <_name>CustomerPostalAddress</_name>
       <_type>F01_CPA</_type>
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
       <xsl:if test="./*[local-name()='Postcode']">
       <xsl:element name="PostalCode">
           <xsl:value-of select="./*[local-name()='Postcode']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='Pobox']">
       <xsl:element name="POBox">
           <xsl:value-of select="./*[local-name()='Pobox']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='CityName']">
       <xsl:element name="PostOffice">
           <xsl:value-of select="./*[local-name()='CityName']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='CountryCode']">
       <xsl:element name="CountryCode">
           <xsl:value-of select="./*[local-name()='CountryCode']" />
       </xsl:element>
       </xsl:if>

          <_entities>
              <xsl:apply-templates />
          </_entities>
      </entity>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
