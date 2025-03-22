<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AccountingPointTemplate" match="//*[local-name()='Transaction']">
       <_name>AccountingPoint</_name>
       <_type>F03_ACP</_type>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='IdentificationMP']" />
       </xsl:element>

          <_entities>
              <xsl:apply-templates />
          </_entities>
</xsl:template>
<xsl:template name="CustomersTemplate" match="//*[local-name()='MPCustomer']">
<_entities_element>
   <entity>
       <_name>Customers</_name>
       <_type>F03_ACP_CUS</_type>
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
