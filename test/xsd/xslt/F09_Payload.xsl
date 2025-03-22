<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AccountingPointTemplate" match="//*[local-name()='Transaction']">
       <_name>AccountingPoint</_name>
       <_type>F09_ACP</_type>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='MeteringPoint']" />
       </xsl:element>
       <xsl:element name="ConnectionStatus">
           <xsl:value-of select="./*[local-name()='ConnectionStatus']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='Description']">
       <xsl:element name="Description">
           <xsl:value-of select="./*[local-name()='Description']" />
       </xsl:element>
       </xsl:if>

          <_entities>
              <xsl:apply-templates />
          </_entities>
</xsl:template>
<xsl:template name="ContactPersonTemplate" match="//*[local-name()='Contact']">
<_entities_element>
   <entity>
       <_name>ContactPerson</_name>
       <_type>F09_CCT</_type>
       <xsl:element name="ContactPersonType">
           <xsl:value-of select="./*[local-name()='ContactType']" />
       </xsl:element>
       <xsl:element name="GivenName">
           <xsl:value-of select="./*[local-name()='GivenName']" />
       </xsl:element>
       <xsl:element name="FamilyName">
           <xsl:value-of select="./*[local-name()='FamilyName']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='Name']">
       <xsl:element name="OtherName">
           <xsl:value-of select="./*[local-name()='Name']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="TelephoneNumber">
           <xsl:value-of select="./*[local-name()='Communication']/*[local-name()='CompleteNumber']" />
       </xsl:element>

          <_entities>
              <xsl:apply-templates />
          </_entities>
      </entity>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
