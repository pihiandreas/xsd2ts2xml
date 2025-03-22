<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AgreementTemplate" match="//*[local-name()='Transaction']">
       <_name>Agreement</_name>
       <_type>F15_AGR</_type>
       <xsl:element name="AgreementStartDate">
		   <xsl:value-of select="replace(./*[local-name()='AuthorizationPeriod']/*[local-name()='Start'], '\+00:00', 'Z')"/>
       </xsl:element>
       <xsl:element name="AgreementEndDate">
		   <xsl:value-of select="replace(./*[local-name()='AuthorizationPeriod']/*[local-name()='End'], '\+00:00', 'Z')"/>
       </xsl:element>
       <xsl:element name="AuthorisationReason">
           <xsl:value-of select="./*[local-name()='Reason']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='Description']">
       <xsl:element name="AuthorisationDescription">
           <xsl:value-of select="./*[local-name()='Description']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="OrganisationIdentifier">
           <xsl:value-of select="./*[local-name()='PartyIdentification']" />
       </xsl:element>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='MeteringPoint']" />
       </xsl:element>

          <_entities>
              <xsl:apply-templates />
          </_entities>
</xsl:template>
<xsl:template name="CustomerTemplate" match="//*[local-name()='CustomerList']">
<_entities_element>
   <entity>
       <_name>Customer</_name>
       <_type>F15_CUS</_type>
       <xsl:element name="CustomerIdentification">
           <xsl:value-of select="./*[local-name()='Identification']" />
       </xsl:element>

          <_entities>
              <xsl:apply-templates />
          </_entities>
      </entity>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
