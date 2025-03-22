<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="CustomerPostalAddressTemplate" match="//*[local-name()='']">
<_entities_element>
   <entity>
       <_name>CustomerPostalAddress</_name>
       <_type>F04_CPA</_type>
       <xsl:element name="PostalCode">
           <xsl:value-of select="./*[local-name()='']" />
       </xsl:element>
       <xsl:element name="POBox">
           <xsl:value-of select="./*[local-name()='']" />
       </xsl:element>
       <xsl:element name="PostOffice">
           <xsl:value-of select="./*[local-name()='']" />
       </xsl:element>
       <xsl:element name="CountryCode">
           <xsl:value-of select="./*[local-name()='']" />
       </xsl:element>

      </entity>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
