<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="AgreementTemplate" match="//*[local-name()='Transaction']">
	<xsl:if test="./*[local-name()='MasterDataContract']">					
		<_entities_element>
			<_name>Agreement</_name>
			<_type>F18_AGR</_type>
				<xsl:element name="AgreementIdentification">
					<xsl:value-of select="./*[local-name()='MasterDataContract']/*[local-name()='Identification']" />
				</xsl:element>
		</_entities_element>   
	</xsl:if>		
	<_entities_element>
		<_name>AccountingPoint</_name>
       <_type>F18_ACP</_type>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='MeteringPointOfContract']/*[local-name()='Identification']" />
       </xsl:element>
	</_entities_element>
</xsl:template>
</xsl:stylesheet>
