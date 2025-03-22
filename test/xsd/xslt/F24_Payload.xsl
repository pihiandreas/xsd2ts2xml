<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="TimeSeriesValuesTemplate" match="//*[local-name()='Transaction']">
       <_name>TimeSeriesValues</_name>
       <_type>F24_TSV</_type>
       <xsl:element name="OrganisationIdentifier">
           <xsl:value-of select="./*[local-name()='PartyIdentification']" />
       </xsl:element>
       <xsl:element name="MarketRole">
           <xsl:value-of select="./*[local-name()='EnergyBusinessProcessRole']" />
       </xsl:element>
       <xsl:element name="ProductCode">
           <xsl:value-of select="./*[local-name()='ProductIdentification']" />
       </xsl:element>
       <xsl:element name="ProductComponentCode">
           <xsl:value-of select="./*[local-name()='ProductComponentIdentification']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='Start']">
       <xsl:element name="StartOfOccurrence">
           <xsl:value-of select="./*[local-name()='Start']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='End']">
       <xsl:element name="EndOfOccurrence">
           <xsl:value-of select="./*[local-name()='End']" />
       </xsl:element>
       </xsl:if>

</xsl:template>
</xsl:stylesheet>
