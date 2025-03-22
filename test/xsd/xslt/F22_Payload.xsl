<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="PriceTemplate" match="//*[local-name()='Transaction']">
       <_name>Price</_name>
       <_type>F22_PRC</_type>
       <xsl:element name="OrganisationIdentifier">
           <xsl:value-of select="./*[local-name()='ProductOwner']" />
       </xsl:element>
       <xsl:element name="ProductCode">
           <xsl:value-of select="./*[local-name()='ProductIdentification']" />
       </xsl:element>
       <xsl:element name="ProductComponentCode">
           <xsl:value-of select="./*[local-name()='ProductComponentIdentification']" />
       </xsl:element>
       <xsl:element name="Price">
           <xsl:value-of select="./*[local-name()='Price']" />
       </xsl:element>
       <xsl:element name="PriceWithTax">
           <xsl:value-of select="./*[local-name()='PriceWithTax']" />
       </xsl:element>

</xsl:template>
</xsl:stylesheet>
