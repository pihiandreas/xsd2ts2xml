<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="ProductTemplate" match="//*[local-name()='Transaction']">
       <_name>Product</_name>
       <_type>F12_PRD</_type>
       <xsl:element name="OrganisationIdentifier">
           <xsl:value-of select="./*[local-name()='PartyIdentification']" />
       </xsl:element>
       <xsl:element name="MarketRole">
           <xsl:value-of select="./*[local-name()='EnergyBusinessProcessRole']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='ProductIdentification']">
       <xsl:element name="ProductCode">
           <xsl:value-of select="./*[local-name()='ProductIdentification']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='OnlyActiveProducts']">
       <xsl:element name="OnlyActiveProducts">
           <xsl:choose>
               <xsl:when test="./*[local-name()='OnlyActiveProducts']='0' or ./*[local-name()='OnlyActiveProducts']='false'">false</xsl:when>
               <xsl:otherwise>true</xsl:otherwise>
           </xsl:choose>
       </xsl:element>
       </xsl:if>

</xsl:template>
</xsl:stylesheet>
